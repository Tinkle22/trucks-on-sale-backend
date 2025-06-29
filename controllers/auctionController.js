const Auction = require('../models/Auction');
const AuctionBid = require('../models/AuctionBid');
const Vehicle = require('../models/Vehicle');
const { validationResult } = require('express-validator');

// Get all auctions
exports.getAllAuctions = async (req, res) => {
  try {
    const { 
      status, category, page = 1, limit = 10 
    } = req.query;

    const filters = {};
    if (status) filters.status = status;
    if (category) filters.category = category;

    const result = await Auction.getAll(filters, page, limit);

    res.json(result);
  } catch (error) {
    console.error('Get all auctions error:', error);
    res.status(500).json({ message: 'Server error while fetching auctions' });
  }
};

// Get auction by ID
exports.getAuctionById = async (req, res) => {
  try {
    const { id } = req.params;
    
    const auction = await Auction.findById(id);
    if (!auction) {
      return res.status(404).json({ message: 'Auction not found' });
    }
    
    // Get vehicle details
    const vehicle = await Vehicle.findById(auction.vehicle_id);
    auction.vehicle = vehicle;
    
    // Get bid history
    const bidHistory = await AuctionBid.getBidHistory(id);
    auction.bid_history = bidHistory;
    
    // Get bid statistics
    const bidCount = await AuctionBid.getBidCount(id);
    const uniqueBidders = await AuctionBid.getUniqueBidders(id);
    auction.bid_stats = {
      total_bids: bidCount,
      unique_bidders: uniqueBidders
    };
    
    res.json({ auction });
  } catch (error) {
    console.error('Get auction by ID error:', error);
    res.status(500).json({ message: 'Server error while fetching auction' });
  }
};

// Create new auction (dealer/admin only)
exports.createAuction = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { vehicle_id } = req.body;
    
    // Check if vehicle exists and belongs to the dealer
    const vehicle = await Vehicle.findById(vehicle_id);
    if (!vehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    if (vehicle.dealer_id !== req.user.user_id && req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to create auction for this vehicle' });
    }
    
    // Check if vehicle already has an auction
    const existingAuction = await Auction.getByVehicle(vehicle_id);
    if (existingAuction) {
      return res.status(400).json({ message: 'Vehicle already has an auction' });
    }
    
    // Create auction
    const auction = await Auction.create(req.body);
    
    res.status(201).json({
      message: 'Auction created successfully',
      auction
    });
  } catch (error) {
    console.error('Create auction error:', error);
    res.status(500).json({ message: 'Server error while creating auction' });
  }
};

// Update auction (dealer/admin only)
exports.updateAuction = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    
    // Check if auction exists
    const existingAuction = await Auction.findById(id);
    if (!existingAuction) {
      return res.status(404).json({ message: 'Auction not found' });
    }
    
    // Check authorization
    const vehicle = await Vehicle.findById(existingAuction.vehicle_id);
    if (vehicle.dealer_id !== req.user.user_id && req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to update this auction' });
    }
    
    // Don't allow updates to active auctions with bids
    if (existingAuction.status === 'active' && existingAuction.current_bid > existingAuction.starting_bid) {
      return res.status(400).json({ message: 'Cannot update auction with existing bids' });
    }
    
    // Update auction
    const updated = await Auction.update(id, req.body);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update auction' });
    }
    
    // Get updated auction
    const updatedAuction = await Auction.findById(id);
    
    res.json({
      message: 'Auction updated successfully',
      auction: updatedAuction
    });
  } catch (error) {
    console.error('Update auction error:', error);
    res.status(500).json({ message: 'Server error while updating auction' });
  }
};

// Delete auction (dealer/admin only)
exports.deleteAuction = async (req, res) => {
  try {
    const { id } = req.params;
    
    // Check if auction exists
    const existingAuction = await Auction.findById(id);
    if (!existingAuction) {
      return res.status(404).json({ message: 'Auction not found' });
    }
    
    // Check authorization
    const vehicle = await Vehicle.findById(existingAuction.vehicle_id);
    if (vehicle.dealer_id !== req.user.user_id && req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to delete this auction' });
    }
    
    // Don't allow deletion of active auctions with bids
    if (existingAuction.status === 'active' && existingAuction.current_bid > existingAuction.starting_bid) {
      return res.status(400).json({ message: 'Cannot delete auction with existing bids' });
    }
    
    // Delete auction bids first
    await AuctionBid.deleteByAuction(id);
    
    // Delete auction
    const deleted = await Auction.delete(id);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete auction' });
    }
    
    res.json({ message: 'Auction deleted successfully' });
  } catch (error) {
    console.error('Delete auction error:', error);
    res.status(500).json({ message: 'Server error while deleting auction' });
  }
};

// Place bid on auction
exports.placeBid = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    const { bid_amount } = req.body;
    const bidder_id = req.user.user_id;
    
    // Check if auction exists and is active
    const auction = await Auction.findById(id);
    if (!auction) {
      return res.status(404).json({ message: 'Auction not found' });
    }
    
    if (auction.status !== 'active') {
      return res.status(400).json({ message: 'Auction is not active' });
    }
    
    // Check if auction has ended
    if (new Date() > new Date(auction.end_time)) {
      return res.status(400).json({ message: 'Auction has ended' });
    }
    
    // Check if bid amount is higher than current bid
    const currentBid = auction.current_bid || auction.starting_bid;
    if (bid_amount <= currentBid) {
      return res.status(400).json({ 
        message: `Bid must be higher than current bid of ${currentBid}` 
      });
    }
    
    // Check if bidder is not the vehicle owner
    const vehicle = await Vehicle.findById(auction.vehicle_id);
    if (vehicle.dealer_id === bidder_id) {
      return res.status(400).json({ message: 'Cannot bid on your own vehicle' });
    }
    
    // Create bid
    const bid = await AuctionBid.create({
      auction_id: id,
      bidder_id,
      bid_amount
    });
    
    // Update auction current bid
    await Auction.updateCurrentBid(id, bid_amount, bidder_id);
    
    res.status(201).json({
      message: 'Bid placed successfully',
      bid
    });
  } catch (error) {
    console.error('Place bid error:', error);
    res.status(500).json({ message: 'Server error while placing bid' });
  }
};

// Get active auctions
exports.getActiveAuctions = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    
    const result = await Auction.getActive(page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get active auctions error:', error);
    res.status(500).json({ message: 'Server error while fetching active auctions' });
  }
};

// Get upcoming auctions
exports.getUpcomingAuctions = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    
    const result = await Auction.getUpcoming(page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get upcoming auctions error:', error);
    res.status(500).json({ message: 'Server error while fetching upcoming auctions' });
  }
};

// Get auction bids
exports.getAuctionBids = async (req, res) => {
  try {
    const { id } = req.params;
    const { page = 1, limit = 10 } = req.query;
    
    // Check if auction exists
    const auction = await Auction.findById(id);
    if (!auction) {
      return res.status(404).json({ message: 'Auction not found' });
    }
    
    const result = await AuctionBid.getByAuction(id, page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get auction bids error:', error);
    res.status(500).json({ message: 'Server error while fetching auction bids' });
  }
};

// Get user bids
exports.getUserBids = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    const bidder_id = req.user.user_id;
    
    const result = await AuctionBid.getByBidder(bidder_id, page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get user bids error:', error);
    res.status(500).json({ message: 'Server error while fetching user bids' });
  }
};

// Get auction statistics (admin only)
exports.getAuctionStatistics = async (req, res) => {
  try {
    const auctionStats = await Auction.getStatistics();
    const bidStats = await AuctionBid.getStatistics();
    
    const stats = {
      ...auctionStats,
      ...bidStats
    };
    
    res.json({ stats });
  } catch (error) {
    console.error('Get auction statistics error:', error);
    res.status(500).json({ message: 'Server error while fetching auction statistics' });
  }
};

// End auction (admin only or automatic)
exports.endAuction = async (req, res) => {
  try {
    const { id } = req.params;
    
    // Check if auction exists
    const auction = await Auction.findById(id);
    if (!auction) {
      return res.status(404).json({ message: 'Auction not found' });
    }
    
    if (auction.status !== 'active') {
      return res.status(400).json({ message: 'Auction is not active' });
    }
    
    // Get highest bid
    const highestBid = await AuctionBid.getHighestBid(id);
    
    if (highestBid && (!auction.reserve_price || highestBid.bid_amount >= auction.reserve_price)) {
      // Set winner
      await Auction.setWinner(id, highestBid.bidder_id);
    } else {
      // No winner, just end auction
      await Auction.updateStatus(id, 'ended');
    }
    
    res.json({ message: 'Auction ended successfully' });
  } catch (error) {
    console.error('End auction error:', error);
    res.status(500).json({ message: 'Server error while ending auction' });
  }
};
