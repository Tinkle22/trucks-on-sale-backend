const express = require('express');
const router = express.Router();
const subcategoryController = require('../controllers/subcategoryController');

// All routes are public
router.get('/', subcategoryController.getAllSubcategories);
router.get('/category/:category', subcategoryController.getSubcategoriesByCategory);
router.get('/:id', subcategoryController.getSubcategoryById);

module.exports = router;