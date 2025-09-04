const express = require('express');
const router = express.Router();
const rentToOwnBookingController = require('../controllers/rentToOwnBookingController');
const { body } = require('express-validator');

// Validation middleware
const bookingValidation = [
  body('vehicle_id').isInt().withMessage('Valid vehicle ID is required'),
  body('customer_name').notEmpty().withMessage('Customer name is required'),
  body('customer_email').isEmail().withMessage('Valid email is required'),
  body('customer_phone').notEmpty().withMessage('Phone number is required'),
  body('monthly_income').isFloat({ min: 0 }).withMessage('Monthly income must be a positive number'),
  body('employment_status').notEmpty().withMessage('Employment status is required'),
  body('preferred_term').isInt({ min: 1, max: 72 }).withMessage('Preferred term must be between 1 and 72 months'),
  body('down_payment').optional().isFloat({ min: 0 }).withMessage('Down payment must be a positive number')
];

const statusValidation = [
  body('status').isIn(['pending', 'approved', 'active', 'completed', 'rejected']).withMessage('Invalid status value')
];

// Authentication middleware (placeholder)
const authenticateToken = (req, res, next) => {
  // This should verify JWT token and set req.user
  next();
};

const requireAdmin = (req, res, next) => {
  if (req.user && req.user.user_type === 'admin') {
    next();
  } else {
    res.status(403).json({ message: 'Admin access required' });
  }
};

const requireDealerOrAdmin = (req, res, next) => {
  if (req.user && (req.user.user_type === 'dealer' || req.user.user_type === 'admin')) {
    next();
  } else {
    res.status(403).json({ message: 'Dealer or admin access required' });
  }
};

// Public routes
router.post('/', bookingValidation, rentToOwnBookingController.createBooking);
router.get('/email/:email', rentToOwnBookingController.getBookingsByEmail);
router.get('/vehicle/:vehicleId/availability', rentToOwnBookingController.checkVehicleAvailability);

// Protected routes
router.get('/', authenticateToken, requireDealerOrAdmin, rentToOwnBookingController.getAllBookings);
router.get('/active', authenticateToken, requireDealerOrAdmin, rentToOwnBookingController.getActiveBookings);
router.get('/pending', authenticateToken, requireDealerOrAdmin, rentToOwnBookingController.getPendingBookings);
router.get('/status/:status', authenticateToken, requireDealerOrAdmin, rentToOwnBookingController.getBookingsByStatus);
router.get('/vehicle/:vehicleId', authenticateToken, requireDealerOrAdmin, rentToOwnBookingController.getBookingsByVehicle);
router.get('/dealer/:dealerId', authenticateToken, requireDealerOrAdmin, rentToOwnBookingController.getDealerBookings);
router.get('/:id', authenticateToken, requireDealerOrAdmin, rentToOwnBookingController.getBookingById);
router.put('/:id', authenticateToken, requireDealerOrAdmin, bookingValidation, rentToOwnBookingController.updateBooking);
router.put('/:id/status', authenticateToken, requireDealerOrAdmin, statusValidation, rentToOwnBookingController.updateBookingStatus);
router.delete('/:id', authenticateToken, requireDealerOrAdmin, rentToOwnBookingController.deleteBooking);

// Admin routes
router.get('/admin/statistics', authenticateToken, requireAdmin, rentToOwnBookingController.getBookingStatistics);

module.exports = router;