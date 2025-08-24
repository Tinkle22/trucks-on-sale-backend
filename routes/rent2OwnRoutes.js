const express = require('express');
const { body, param, query } = require('express-validator');
const rent2OwnController = require('../controllers/rent2OwnController');
const router = express.Router();

// Validation middleware for creating rent-to-own booking
const validateCreateBooking = [
  body('vehicle_id')
    .isInt({ min: 1 })
    .withMessage('Vehicle ID must be a positive integer'),
  
  body('customer_name')
    .trim()
    .isLength({ min: 2, max: 100 })
    .withMessage('Customer name must be between 2 and 100 characters')
    .matches(/^[a-zA-Z\s]+$/)
    .withMessage('Customer name must contain only letters and spaces'),
  
  body('customer_email')
    .isEmail()
    .normalizeEmail()
    .withMessage('Please provide a valid email address'),
  
  body('customer_phone')
    .optional()
    .isMobilePhone()
    .withMessage('Please provide a valid phone number'),
  
  body('monthly_income')
    .isFloat({ min: 0 })
    .withMessage('Monthly income must be a positive number'),
  
  body('employment_status')
    .isIn(['employed', 'self-employed', 'unemployed', 'retired', 'student'])
    .withMessage('Employment status must be one of: employed, self-employed, unemployed, retired, student'),
  
  body('employer_name')
    .optional()
    .trim()
    .isLength({ max: 100 })
    .withMessage('Employer name must not exceed 100 characters'),
  
  body('preferred_term')
    .isInt({ min: 6, max: 72 })
    .withMessage('Preferred term must be between 6 and 72 months'),
  
  body('down_payment')
    .isFloat({ min: 0 })
    .withMessage('Down payment must be a positive number')
];

// Validation middleware for updating rent-to-own booking
const validateUpdateBooking = [
  body('customer_name')
    .optional()
    .trim()
    .isLength({ min: 2, max: 100 })
    .withMessage('Customer name must be between 2 and 100 characters')
    .matches(/^[a-zA-Z\s]+$/)
    .withMessage('Customer name must contain only letters and spaces'),
  
  body('customer_email')
    .optional()
    .isEmail()
    .normalizeEmail()
    .withMessage('Please provide a valid email address'),
  
  body('customer_phone')
    .optional()
    .isMobilePhone()
    .withMessage('Please provide a valid phone number'),
  
  body('monthly_income')
    .optional()
    .isFloat({ min: 0 })
    .withMessage('Monthly income must be a positive number'),
  
  body('employment_status')
    .optional()
    .isIn(['employed', 'self-employed', 'unemployed', 'retired', 'student'])
    .withMessage('Employment status must be one of: employed, self-employed, unemployed, retired, student'),
  
  body('employer_name')
    .optional()
    .trim()
    .isLength({ max: 100 })
    .withMessage('Employer name must not exceed 100 characters'),
  
  body('preferred_term')
    .optional()
    .isInt({ min: 6, max: 72 })
    .withMessage('Preferred term must be between 6 and 72 months'),
  
  body('down_payment')
    .optional()
    .isFloat({ min: 0 })
    .withMessage('Down payment must be a positive number')
];

// Validation middleware for status update
const validateStatusUpdate = [
  body('status')
    .isIn(['pending', 'approved', 'rejected', 'active', 'completed', 'cancelled'])
    .withMessage('Status must be one of: pending, approved, rejected, active, completed, cancelled')
];

// Validation middleware for ID parameters
const validateIdParam = [
  param('id')
    .isInt({ min: 1 })
    .withMessage('ID must be a positive integer')
];

const validateVehicleIdParam = [
  param('vehicleId')
    .isInt({ min: 1 })
    .withMessage('Vehicle ID must be a positive integer')
];

const validateEmailParam = [
  param('email')
    .isEmail()
    .normalizeEmail()
    .withMessage('Please provide a valid email address')
];

// Validation middleware for query parameters
const validateQueryParams = [
  query('page')
    .optional()
    .isInt({ min: 1 })
    .withMessage('Page must be a positive integer'),
  
  query('limit')
    .optional()
    .isInt({ min: 1, max: 100 })
    .withMessage('Limit must be between 1 and 100'),
  
  query('status')
    .optional()
    .isIn(['pending', 'approved', 'rejected', 'active', 'completed', 'cancelled'])
    .withMessage('Status must be one of: pending, approved, rejected, active, completed, cancelled'),
  
  query('customer_email')
    .optional()
    .isEmail()
    .normalizeEmail()
    .withMessage('Please provide a valid email address'),
  
  query('vehicle_id')
    .optional()
    .isInt({ min: 1 })
    .withMessage('Vehicle ID must be a positive integer')
];

// Validation middleware for vehicle search
const validateVehicleQuery = [
  query('page')
    .optional()
    .isInt({ min: 1 })
    .withMessage('Page must be a positive integer'),
  
  query('limit')
    .optional()
    .isInt({ min: 1, max: 100 })
    .withMessage('Limit must be between 1 and 100'),
  
  query('min_price')
    .optional()
    .isFloat({ min: 0 })
    .withMessage('Minimum price must be a positive number'),
  
  query('max_price')
    .optional()
    .isFloat({ min: 0 })
    .withMessage('Maximum price must be a positive number'),
  
  query('category')
    .optional()
    .trim()
    .isLength({ min: 1, max: 50 })
    .withMessage('Category must be between 1 and 50 characters'),
  
  query('make')
    .optional()
    .trim()
    .isLength({ min: 1, max: 50 })
    .withMessage('Make must be between 1 and 50 characters'),
  
  query('model')
    .optional()
    .trim()
    .isLength({ min: 1, max: 50 })
    .withMessage('Model must be between 1 and 50 characters'),
  
  query('region')
    .optional()
    .trim()
    .isLength({ min: 1, max: 50 })
    .withMessage('Region must be between 1 and 50 characters'),
  
  query('city')
    .optional()
    .trim()
    .isLength({ min: 1, max: 50 })
    .withMessage('City must be between 1 and 50 characters')
];

// Validation middleware for search
const validateSearch = [
  query('q')
    .trim()
    .isLength({ min: 2, max: 100 })
    .withMessage('Search term must be between 2 and 100 characters')
];

// Authentication middleware (placeholder - implement based on your auth system)
const authenticateUser = (req, res, next) => {
  // TODO: Implement authentication logic
  // For now, just pass through
  next();
};

// Authorization middleware (placeholder - implement based on your auth system)
const authorizeAdmin = (req, res, next) => {
  // TODO: Implement admin authorization logic
  // For now, just pass through
  next();
};

// Routes

// Public routes - Available vehicles
router.get('/vehicles', validateVehicleQuery, rent2OwnController.getAvailableVehicles);
router.get('/vehicles/:vehicleId/availability', validateVehicleIdParam, rent2OwnController.checkVehicleAvailability);

// Customer routes - Booking management
router.post('/bookings', validateCreateBooking, rent2OwnController.createBooking);
router.get('/bookings/customer/:email', validateEmailParam, rent2OwnController.getBookingsByEmail);

// Admin routes - Full booking management
router.get('/bookings', authenticateUser, authorizeAdmin, validateQueryParams, rent2OwnController.getAllBookings);
router.get('/bookings/active', authenticateUser, authorizeAdmin, rent2OwnController.getActiveBookings);
router.get('/bookings/pending', authenticateUser, authorizeAdmin, rent2OwnController.getPendingBookings);
router.get('/bookings/recent', authenticateUser, authorizeAdmin, rent2OwnController.getRecentBookings);
router.get('/bookings/statistics', authenticateUser, authorizeAdmin, rent2OwnController.getStatistics);
router.get('/bookings/search', authenticateUser, authorizeAdmin, validateSearch, rent2OwnController.searchBookings);
router.get('/bookings/vehicle/:vehicleId', authenticateUser, authorizeAdmin, validateVehicleIdParam, rent2OwnController.getBookingsByVehicle);
router.get('/bookings/:id', authenticateUser, authorizeAdmin, validateIdParam, rent2OwnController.getBookingById);
router.put('/bookings/:id', authenticateUser, authorizeAdmin, validateIdParam, validateUpdateBooking, rent2OwnController.updateBooking);
router.patch('/bookings/:id/status', authenticateUser, authorizeAdmin, validateIdParam, validateStatusUpdate, rent2OwnController.updateBookingStatus);
router.delete('/bookings/:id', authenticateUser, authorizeAdmin, validateIdParam, rent2OwnController.deleteBooking);

// Error handling middleware
router.use((error, req, res, next) => {
  console.error('Rent-to-own routes error:', error);
  res.status(500).json({ 
    message: 'Internal server error in rent-to-own routes',
    error: process.env.NODE_ENV === 'development' ? error.message : 'Something went wrong'
  });
});

module.exports = router;