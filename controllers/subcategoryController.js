const Subcategory = require('../models/Subcategory');

// Get all subcategories
exports.getAllSubcategories = async (req, res) => {
  try {
    const subcategories = await Subcategory.getAll();
    res.json({ subcategories });
  } catch (error) {
    console.error('Get all subcategories error:', error);
    res.status(500).json({ message: 'Server error while fetching subcategories' });
  }
};

// Get subcategories by category
exports.getSubcategoriesByCategory = async (req, res) => {
  try {
    const { category } = req.params;
    
    const subcategories = await Subcategory.getByCategory(category);
    res.json({ subcategories });
  } catch (error) {
    console.error('Get subcategories by category error:', error);
    res.status(500).json({ message: 'Server error while fetching subcategories' });
  }
};

// Get subcategory by ID
exports.getSubcategoryById = async (req, res) => {
  try {
    const { id } = req.params;
    
    const subcategory = await Subcategory.findById(id);
    if (!subcategory) {
      return res.status(404).json({ message: 'Subcategory not found' });
    }
    
    res.json({ subcategory });
  } catch (error) {
    console.error('Get subcategory by ID error:', error);
    res.status(500).json({ message: 'Server error while fetching subcategory' });
  }
};