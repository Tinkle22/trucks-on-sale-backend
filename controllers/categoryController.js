const Category = require('../models/Category');
const CategoryMake = require('../models/CategoryMake');
const Subcategory = require('../models/Subcategory');
const { validationResult } = require('express-validator');

// Get all categories
exports.getAllCategories = async (req, res) => {
  try {
    const { status, include_subcategories, include_makes } = req.query;
    
    const filters = {};
    if (status) filters.status = status;
    
    let categories;
    
    if (include_subcategories === 'true') {
      categories = await Category.getWithSubcategories();
    } else if (include_makes === 'true') {
      categories = await Category.getWithMakes();
    } else {
      categories = await Category.getAll(filters);
    }
    
    res.json({ categories });
  } catch (error) {
    console.error('Get all categories error:', error);
    res.status(500).json({ message: 'Server error while fetching categories' });
  }
};

// Get category by ID
exports.getCategoryById = async (req, res) => {
  try {
    const { id } = req.params;
    
    const category = await Category.findById(id);
    if (!category) {
      return res.status(404).json({ message: 'Category not found' });
    }
    
    // Get subcategories and makes for this category
    const subcategories = await Subcategory.findByCategory(id);
    const makes = await CategoryMake.findByCategory(id);
    
    category.subcategories = subcategories;
    category.makes = makes;
    
    res.json({ category });
  } catch (error) {
    console.error('Get category by ID error:', error);
    res.status(500).json({ message: 'Server error while fetching category' });
  }
};

// Create new category (admin only)
exports.createCategory = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    // Check if category key already exists
    const existingCategory = await Category.findByKey(req.body.category_key);
    if (existingCategory) {
      return res.status(400).json({ message: 'Category key already exists' });
    }
    
    // Create category
    const category = await Category.create(req.body);
    
    res.status(201).json({
      message: 'Category created successfully',
      category
    });
  } catch (error) {
    console.error('Create category error:', error);
    res.status(500).json({ message: 'Server error while creating category' });
  }
};

// Update category (admin only)
exports.updateCategory = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    
    // Check if category exists
    const existingCategory = await Category.findById(id);
    if (!existingCategory) {
      return res.status(404).json({ message: 'Category not found' });
    }
    
    // If updating category_key, check for duplicates
    if (req.body.category_key && req.body.category_key !== existingCategory.category_key) {
      const duplicateCategory = await Category.findByKey(req.body.category_key);
      if (duplicateCategory) {
        return res.status(400).json({ message: 'Category key already exists' });
      }
    }
    
    // Update category
    const updated = await Category.update(id, req.body);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update category' });
    }
    
    // Get updated category
    const updatedCategory = await Category.findById(id);
    
    res.json({
      message: 'Category updated successfully',
      category: updatedCategory
    });
  } catch (error) {
    console.error('Update category error:', error);
    res.status(500).json({ message: 'Server error while updating category' });
  }
};

// Delete category (admin only)
exports.deleteCategory = async (req, res) => {
  try {
    const { id } = req.params;
    
    // Check if category exists
    const existingCategory = await Category.findById(id);
    if (!existingCategory) {
      return res.status(404).json({ message: 'Category not found' });
    }
    
    // Delete category (this will cascade delete subcategories and makes due to foreign key constraints)
    const deleted = await Category.delete(id);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete category' });
    }
    
    res.json({ message: 'Category deleted successfully' });
  } catch (error) {
    console.error('Delete category error:', error);
    res.status(500).json({ message: 'Server error while deleting category' });
  }
};

// Update category status (admin only)
exports.updateCategoryStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;
    
    // Validate status
    if (!['active', 'inactive'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status value' });
    }
    
    // Check if category exists
    const existingCategory = await Category.findById(id);
    if (!existingCategory) {
      return res.status(404).json({ message: 'Category not found' });
    }
    
    // Update status
    const updated = await Category.updateStatus(id, status);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update category status' });
    }
    
    res.json({ message: `Category status updated to ${status}` });
  } catch (error) {
    console.error('Update category status error:', error);
    res.status(500).json({ message: 'Server error while updating category status' });
  }
};

// Get active categories
exports.getActiveCategories = async (req, res) => {
  try {
    const categories = await Category.getActive();
    res.json({ categories });
  } catch (error) {
    console.error('Get active categories error:', error);
    res.status(500).json({ message: 'Server error while fetching active categories' });
  }
};

// Get category statistics (admin only)
exports.getCategoryStatistics = async (req, res) => {
  try {
    const stats = await Category.getStatistics();
    res.json({ stats });
  } catch (error) {
    console.error('Get category statistics error:', error);
    res.status(500).json({ message: 'Server error while fetching category statistics' });
  }
};

// Get makes by category
exports.getMakesByCategory = async (req, res) => {
  try {
    const { categoryId } = req.params;
    
    // Check if category exists
    const category = await Category.findById(categoryId);
    if (!category) {
      return res.status(404).json({ message: 'Category not found' });
    }
    
    const makes = await CategoryMake.findByCategory(categoryId);
    res.json({ makes });
  } catch (error) {
    console.error('Get makes by category error:', error);
    res.status(500).json({ message: 'Server error while fetching makes' });
  }
};

// Add make to category (admin only)
exports.addMakeToCategory = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { categoryId } = req.params;
    const { make_name } = req.body;
    
    // Check if category exists
    const category = await Category.findById(categoryId);
    if (!category) {
      return res.status(404).json({ message: 'Category not found' });
    }
    
    // Check if make already exists for this category
    const existingMake = await CategoryMake.findByCategoryAndName(categoryId, make_name);
    if (existingMake) {
      return res.status(400).json({ message: 'Make already exists for this category' });
    }
    
    // Create make
    const make = await CategoryMake.create({
      category_id: categoryId,
      make_name,
      status: 'active'
    });
    
    res.status(201).json({
      message: 'Make added to category successfully',
      make
    });
  } catch (error) {
    console.error('Add make to category error:', error);
    res.status(500).json({ message: 'Server error while adding make to category' });
  }
};

// Update make (admin only)
exports.updateMake = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { makeId } = req.params;
    
    // Check if make exists
    const existingMake = await CategoryMake.findById(makeId);
    if (!existingMake) {
      return res.status(404).json({ message: 'Make not found' });
    }
    
    // Update make
    const updated = await CategoryMake.update(makeId, req.body);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update make' });
    }
    
    // Get updated make
    const updatedMake = await CategoryMake.findById(makeId);
    
    res.json({
      message: 'Make updated successfully',
      make: updatedMake
    });
  } catch (error) {
    console.error('Update make error:', error);
    res.status(500).json({ message: 'Server error while updating make' });
  }
};

// Delete make (admin only)
exports.deleteMake = async (req, res) => {
  try {
    const { makeId } = req.params;
    
    // Check if make exists
    const existingMake = await CategoryMake.findById(makeId);
    if (!existingMake) {
      return res.status(404).json({ message: 'Make not found' });
    }
    
    // Delete make
    const deleted = await CategoryMake.delete(makeId);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete make' });
    }
    
    res.json({ message: 'Make deleted successfully' });
  } catch (error) {
    console.error('Delete make error:', error);
    res.status(500).json({ message: 'Server error while deleting make' });
  }
};
