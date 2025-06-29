const express = require('express');
const router = express.Router();
const categoryController = require('../controllers/categoryController');
const { body } = require('express-validator');
const { authenticateToken, requireAdmin } = require('../middleware/auth');

// Validation middleware
const categoryValidation = [
  body('category_key').notEmpty().withMessage('Category key is required'),
  body('category_name').notEmpty().withMessage('Category name is required'),
  body('listing_label').notEmpty().withMessage('Listing label is required')
];

const makeValidation = [
  body('make_name').notEmpty().withMessage('Make name is required')
];



// Public routes
router.get('/', categoryController.getAllCategories);
router.get('/active', categoryController.getActiveCategories);
router.get('/:id', categoryController.getCategoryById);
router.get('/:categoryId/makes', categoryController.getMakesByCategory);

// Admin routes
router.post('/', authenticateToken, requireAdmin, categoryValidation, categoryController.createCategory);
router.put('/:id', authenticateToken, requireAdmin, categoryValidation, categoryController.updateCategory);
router.delete('/:id', authenticateToken, requireAdmin, categoryController.deleteCategory);
router.put('/:id/status', authenticateToken, requireAdmin, categoryController.updateCategoryStatus);
router.get('/admin/statistics', authenticateToken, requireAdmin, categoryController.getCategoryStatistics);

// Make management routes
router.post('/:categoryId/makes', authenticateToken, requireAdmin, makeValidation, categoryController.addMakeToCategory);
router.put('/makes/:makeId', authenticateToken, requireAdmin, makeValidation, categoryController.updateMake);
router.delete('/makes/:makeId', authenticateToken, requireAdmin, categoryController.deleteMake);

module.exports = router;
