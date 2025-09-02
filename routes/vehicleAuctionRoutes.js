const express = require('express');
const router = express.Router();
const vehicleAuctionController = require('../controllers/vehicleAuctionController');
const { body, validationResult } = require('express-validator');

// Validation middleware
const bidValidation = [
  body('bidder_name')
    .notEmpty()
    .withMessage('Bidder name is required')
    .isLength({ min: 2, max: 100 })
    .withMessage('Bidder name must be between 2 and 100 characters'),
  body('bidder_email')
    .isEmail()
    .withMessage('Valid email is required')
    .normalizeEmail(),
  body('bidder_phone')
    .notEmpty()
    .withMessage('Phone number is required')
    .isMobilePhone()
    .withMessage('Valid phone number is required'),
  body('bid_amount')
    .isNumeric()
    .withMessage('Bid amount must be a number')
    .isFloat({ min: 1 })
    .withMessage('Bid amount must be greater than 0')
];

// Validation error handler
const handleValidationErrors = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      message: 'Validation failed',
      errors: errors.array()
    });
  }
  next();
};

// Public routes
router.get('/', vehicleAuctionController.getAuctionVehicles);
router.get('/statistics', vehicleAuctionController.getAuctionStatistics);
router.get('/:id', vehicleAuctionController.getAuctionVehicleDetails);
router.get('/:id/bids', vehicleAuctionController.getVehicleBidHistory);
router.post('/:id/bid', bidValidation, handleValidationErrors, vehicleAuctionController.placeBid);

module.exports = router;