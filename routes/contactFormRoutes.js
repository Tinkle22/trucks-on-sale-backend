const express = require('express');
const { body } = require('express-validator');
const router = express.Router();
const {
  createContactForm,
  getAllContactForms,
  getFinanceApplications,
  getContactFormsOnly,
  getContactFormsByDealership,
  getContactFormById,
  updateContactFormStatus,
  deleteContactForm,
  getContactFormStats
} = require('../controllers/contactFormController');
const { authenticateToken, requireRole } = require('../middleware/auth');

// Validation middleware for contact form creation
const validateContactForm = [
    body('name')
        .trim()
        .isLength({ min: 2, max: 255 })
        .withMessage('Name must be between 2 and 255 characters'),
    body('email')
        .isEmail()
        .normalizeEmail()
        .withMessage('Please provide a valid email address'),
    body('phone')
        .optional()
        .isMobilePhone()
        .withMessage('Please provide a valid phone number'),
    body('subject')
        .optional()
        .trim()
        .isLength({ max: 255 })
        .withMessage('Subject must not exceed 255 characters'),
    body('message')
        .trim()
        .isLength({ min: 10, max: 2000 })
        .withMessage('Message must be between 10 and 2000 characters'),
    body('dealership_id')
        .optional()
        .isInt({ min: 1 })
        .withMessage('Dealership ID must be a positive integer'),
    body('dealership_name')
        .optional()
        .trim()
        .isLength({ max: 255 })
        .withMessage('Dealership name must not exceed 255 characters')
];

// Validation middleware for status update
const validateStatusUpdate = [
    body('status')
        .isIn(['new', 'read', 'replied', 'closed'])
        .withMessage('Status must be one of: new, read, replied, closed')
];

// Public routes
// POST /api/contact-forms - Create a new contact form submission
router.post('/', validateContactForm, createContactForm);

// Protected routes (require authentication)
// GET /api/contact-forms - Get all forms (admin only) - supports filtering by form_type query parameter
router.get('/', authenticateToken, requireRole(['admin']), getAllContactForms);

// GET /api/contact-forms/finance - Get finance applications specifically (admin only)
router.get('/finance', authenticateToken, requireRole(['admin']), getFinanceApplications);

// GET /api/contact-forms/contact - Get contact forms specifically (admin only)
router.get('/contact', authenticateToken, requireRole(['admin']), getContactFormsOnly);

// GET /api/contact-forms/statistics - Get contact form statistics (admin only)
router.get('/statistics', authenticateToken, requireRole(['admin']), getContactFormStats);

// GET /api/contact-forms/dealership/:dealershipId - Get contact forms by dealership
router.get('/dealership/:dealershipId', authenticateToken, requireRole(['admin', 'dealer']), getContactFormsByDealership);

// GET /api/contact-forms/my-forms - Get current user's dealership contact forms
router.get('/my-forms', authenticateToken, requireRole(['dealer']), getContactFormsByDealership);

// GET /api/contact-forms/:id - Get a single contact form by ID
router.get('/:id', authenticateToken, requireRole(['admin', 'dealer']), getContactFormById);

// PUT /api/contact-forms/:id/status - Update contact form status
router.put('/:id/status', authenticateToken, requireRole(['admin', 'dealer']), validateStatusUpdate, updateContactFormStatus);

// DELETE /api/contact-forms/:id - Delete a contact form (admin only)
router.delete('/:id', authenticateToken, requireRole(['admin']), deleteContactForm);

module.exports = router;