const express = require('express');
const router = express.Router();
const hireBookingController = require('../controllers/hireBookingController');
const { body } = require('express-validator');

// Validation middleware
const bookingValidation = [
  body('vehicle_id').isInt().withMessage('Valid vehicle ID is required'),
  body('customer_name').notEmpty().withMessage('Customer name is required'),
  body('email').isEmail().withMessage('Valid email is required'),
  body('phone').notEmpty().withMessage('Phone number is required'),
  body('start_date').isISO8601().withMessage('Valid start date is required'),
  body('end_date').isISO8601().withMessage('Valid end date is required'),
  body('daily_rate').optional().isFloat({ min: 0 }).withMessage('Daily rate must be a positive number'),
  body('total_cost').optional().isFloat({ min: 0 }).withMessage('Total cost must be a positive number')
];

const statusValidation = [
  body('status').isIn(['pending', 'confirmed', 'active', 'completed', 'cancelled']).withMessage('Invalid status value')
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
router.post('/', bookingValidation, hireBookingController.createBooking);
router.get('/email/:email', hireBookingController.getBookingsByEmail);
router.get('/vehicle/:vehicleId/availability', hireBookingController.checkVehicleAvailability);

// Protected routes
router.get('/', authenticateToken, requireDealerOrAdmin, hireBookingController.getAllBookings);
router.get('/active', authenticateToken, requireDealerOrAdmin, hireBookingController.getActiveBookings);
router.get('/upcoming', authenticateToken, requireDealerOrAdmin, hireBookingController.getUpcomingBookings);
router.get('/status/:status', authenticateToken, requireDealerOrAdmin, hireBookingController.getBookingsByStatus);
router.get('/vehicle/:vehicleId', authenticateToken, requireDealerOrAdmin, hireBookingController.getBookingsByVehicle);
router.get('/dealer/:dealerId', authenticateToken, requireDealerOrAdmin, hireBookingController.getDealerBookings);
router.get('/:id', authenticateToken, requireDealerOrAdmin, hireBookingController.getBookingById);
router.put('/:id', authenticateToken, requireDealerOrAdmin, bookingValidation, hireBookingController.updateBooking);
router.put('/:id/status', authenticateToken, requireDealerOrAdmin, statusValidation, hireBookingController.updateBookingStatus);
router.delete('/:id', authenticateToken, requireDealerOrAdmin, hireBookingController.deleteBooking);

// Admin routes
router.get('/admin/statistics', authenticateToken, requireAdmin, hireBookingController.getBookingStatistics);

module.exports = router;
