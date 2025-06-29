const express = require('express');
const router = express.Router();
const financeApplicationController = require('../controllers/financeApplicationController');
const { body } = require('express-validator');
const { authenticateToken, requireAdmin } = require('../middleware/auth');

// Validation middleware
const applicationValidation = [
  body('full_name').notEmpty().withMessage('Full name is required'),
  body('email').isEmail().withMessage('Valid email is required'),
  body('phone').notEmpty().withMessage('Phone number is required'),
  body('annual_income').optional().isFloat({ min: 0 }).withMessage('Annual income must be a positive number'),
  body('loan_amount').optional().isFloat({ min: 0 }).withMessage('Loan amount must be a positive number'),
  body('loan_term').optional().isInt({ min: 1 }).withMessage('Loan term must be a positive integer'),
  body('vehicle_id').optional().isInt().withMessage('Valid vehicle ID is required')
];

const statusValidation = [
  body('status').isIn(['pending', 'approved', 'rejected']).withMessage('Invalid status value')
];



// Public routes
router.post('/', applicationValidation, financeApplicationController.createApplication);
router.get('/email/:email', financeApplicationController.getApplicationsByEmail);

// Admin routes
router.get('/', authenticateToken, requireAdmin, financeApplicationController.getAllApplications);
router.get('/statistics', authenticateToken, requireAdmin, financeApplicationController.getApplicationStatistics);
router.get('/recent', authenticateToken, requireAdmin, financeApplicationController.getRecentApplications);
router.get('/date-range', authenticateToken, requireAdmin, financeApplicationController.getApplicationsByDateRange);
router.get('/status/:status', authenticateToken, requireAdmin, financeApplicationController.getApplicationsByStatus);
router.get('/employment/:employmentStatus', authenticateToken, requireAdmin, financeApplicationController.getApplicationsByEmploymentStatus);
router.get('/credit-score/:creditScoreRange', authenticateToken, requireAdmin, financeApplicationController.getApplicationsByCreditScore);
router.get('/vehicle/:vehicleId', authenticateToken, requireAdmin, financeApplicationController.getApplicationsByVehicle);
router.get('/:id', authenticateToken, requireAdmin, financeApplicationController.getApplicationById);
router.put('/:id', authenticateToken, requireAdmin, applicationValidation, financeApplicationController.updateApplication);
router.put('/:id/status', authenticateToken, requireAdmin, statusValidation, financeApplicationController.updateApplicationStatus);
router.delete('/:id', authenticateToken, requireAdmin, financeApplicationController.deleteApplication);

module.exports = router;
