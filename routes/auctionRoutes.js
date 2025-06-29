const express = require('express');
const router = express.Router();
const auctionController = require('../controllers/auctionController');
const { body } = require('express-validator');
const { authenticateToken, requireAdmin, requireDealerOrAdmin } = require('../middleware/auth');

// Validation middleware
const auctionValidation = [
  body('vehicle_id').isInt().withMessage('Valid vehicle ID is required'),
  body('starting_bid').isFloat({ min: 0 }).withMessage('Starting bid must be a positive number'),
  body('start_time').isISO8601().withMessage('Valid start time is required'),
  body('end_time').isISO8601().withMessage('Valid end time is required'),
  body('reserve_price').optional().isFloat({ min: 0 }).withMessage('Reserve price must be a positive number')
];

const bidValidation = [
  body('bid_amount').isFloat({ min: 0 }).withMessage('Bid amount must be a positive number')
];



// Public routes
router.get('/', auctionController.getAllAuctions);
router.get('/active', auctionController.getActiveAuctions);
router.get('/upcoming', auctionController.getUpcomingAuctions);
router.get('/:id', auctionController.getAuctionById);
router.get('/:id/bids', auctionController.getAuctionBids);

// Protected routes (require authentication)
router.post('/:id/bid', authenticateToken, bidValidation, auctionController.placeBid);
router.get('/user/bids', authenticateToken, auctionController.getUserBids);

// Dealer/Admin routes
router.post('/', authenticateToken, requireDealerOrAdmin, auctionValidation, auctionController.createAuction);
router.put('/:id', authenticateToken, requireDealerOrAdmin, auctionValidation, auctionController.updateAuction);
router.delete('/:id', authenticateToken, requireDealerOrAdmin, auctionController.deleteAuction);

// Admin routes
router.get('/admin/statistics', authenticateToken, requireAdmin, auctionController.getAuctionStatistics);
router.put('/:id/end', authenticateToken, requireAdmin, auctionController.endAuction);

module.exports = router;
