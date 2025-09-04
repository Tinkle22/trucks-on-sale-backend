const Vehicle = require('../models/Vehicle');
const AuctionBid = require('../models/AuctionBid');
const db = require('../config/db');

// Get all auction vehicles
exports.getAuctionVehicles = async (req, res) => {
  try {
    const { page = 1, limit = 10, category, region, make, model, min_price, max_price } = req.query;
    const offset = (parseInt(page) - 1) * parseInt(limit);

    let whereClause = "WHERE v.listing_type = 'auction' AND v.status = 'available'";
    let queryParams = [];

    // Add filters
    if (category) {
      whereClause += " AND v.category = ?";
      queryParams.push(category);
    }
    if (region) {
      whereClause += " AND v.region = ?";
      queryParams.push(region);
    }
    if (make) {
      whereClause += " AND v.make = ?";
      queryParams.push(make);
    }
    if (model) {
      whereClause += " AND v.model = ?";
      queryParams.push(model);
    }
    if (min_price) {
      whereClause += " AND v.price >= ?";
      queryParams.push(parseFloat(min_price));
    }
    if (max_price) {
      whereClause += " AND v.price <= ?";
      queryParams.push(parseFloat(max_price));
    }

    // Check if auction is still active
    whereClause += " AND (v.auction_end_date IS NULL OR v.auction_end_date > NOW())";

    const query = `
      SELECT v.*, 
             vi.image_path,
             COALESCE(v.current_bid, v.reserve_price, v.price) as current_bid_amount,
             (SELECT COUNT(*) FROM auction_bids ab WHERE ab.vehicle_id = v.vehicle_id AND ab.status = 'active') as bid_count,
             CASE 
               WHEN v.auction_end_date IS NOT NULL AND v.auction_end_date <= NOW() THEN 'ended'
               WHEN v.auction_start_date IS NOT NULL AND v.auction_start_date > NOW() THEN 'upcoming'
               ELSE 'active'
             END as auction_status
      FROM vehicles v
      LEFT JOIN (
        SELECT vehicle_id, image_path
        FROM vehicle_images
        WHERE is_primary = 1
      ) vi ON v.vehicle_id = vi.vehicle_id
      ${whereClause}
      ORDER BY v.featured DESC, v.created_at DESC
      LIMIT ? OFFSET ?
    `;

    queryParams.push(parseInt(limit), parseInt(offset));
    const [vehicles] = await db.query(query, queryParams);

    // Get total count
    const countQuery = `SELECT COUNT(*) as total FROM vehicles v ${whereClause}`;
    const [countResult] = await db.query(countQuery, queryParams.slice(0, -2));
    const total = countResult[0].total;

    res.json({
      vehicles,
      pagination: {
        current_page: parseInt(page),
        per_page: parseInt(limit),
        total,
        total_pages: Math.ceil(total / parseInt(limit))
      }
    });
  } catch (error) {
    console.error('Get auction vehicles error:', error);
    res.status(500).json({ message: 'Server error while fetching auction vehicles' });
  }
};

// Get auction vehicle details with bid history
exports.getAuctionVehicleDetails = async (req, res) => {
  try {
    const { id } = req.params;

    // Get vehicle details
    const vehicle = await Vehicle.findById(id);
    if (!vehicle || vehicle.listing_type !== 'auction') {
      return res.status(404).json({ message: 'Auction vehicle not found' });
    }

    // Get bid history
    const [bidHistory] = await db.query(`
      SELECT ab.*, 
             DATE_FORMAT(ab.bid_time, '%Y-%m-%d %H:%i:%s') as formatted_bid_time
      FROM auction_bids ab 
      WHERE ab.vehicle_id = ? AND ab.status = 'active'
      ORDER BY ab.bid_amount DESC, ab.bid_time DESC
    `, [id]);

    // Get highest bid
    const [highestBidResult] = await db.query(`
      SELECT ab.*, 
             DATE_FORMAT(ab.bid_time, '%Y-%m-%d %H:%i:%s') as formatted_bid_time
      FROM auction_bids ab 
      WHERE ab.vehicle_id = ? AND ab.status = 'active'
      ORDER BY ab.bid_amount DESC, ab.bid_time DESC
      LIMIT 1
    `, [id]);

    const highestBid = highestBidResult[0] || null;

    // Get bid statistics
    const [bidStats] = await db.query(`
      SELECT 
        COUNT(*) as total_bids,
        COUNT(DISTINCT bidder_email) as unique_bidders,
        MIN(bid_amount) as lowest_bid,
        MAX(bid_amount) as highest_bid
      FROM auction_bids 
      WHERE vehicle_id = ? AND status = 'active'
    `, [id]);

    // Determine auction status
    let auctionStatus = 'active';
    if (vehicle.auction_end_date && new Date(vehicle.auction_end_date) <= new Date()) {
      auctionStatus = 'ended';
    } else if (vehicle.auction_start_date && new Date(vehicle.auction_start_date) > new Date()) {
      auctionStatus = 'upcoming';
    }

    res.json({
      vehicle: {
        ...vehicle,
        auction_status: auctionStatus,
        current_bid_amount: vehicle.current_bid || vehicle.reserve_price || vehicle.price
      },
      bidHistory: bidHistory,
      currentBid: highestBid ? highestBid.bid_amount : 0,
      bidCount: bidStats[0].total_bids,
      highest_bid: highestBid,
      bid_statistics: bidStats[0]
    });
  } catch (error) {
    console.error('Get auction vehicle details error:', error);
    res.status(500).json({ message: 'Server error while fetching auction vehicle details' });
  }
};

// Place bid on auction vehicle
exports.placeBid = async (req, res) => {
  try {
    const { id } = req.params;
    const { bidder_name, bidder_email, bidder_phone, bid_amount } = req.body;

    // Validate required fields
    if (!bidder_name || !bidder_email || !bidder_phone || !bid_amount) {
      return res.status(400).json({ message: 'All bid fields are required' });
    }

    // Get vehicle details
    const vehicle = await Vehicle.findById(id);
    if (!vehicle || vehicle.listing_type !== 'auction') {
      return res.status(404).json({ message: 'Auction vehicle not found' });
    }

    // Check if auction is active
    if (vehicle.auction_end_date && new Date(vehicle.auction_end_date) <= new Date()) {
      return res.status(400).json({ message: 'Auction has ended' });
    }

    if (vehicle.auction_start_date && new Date(vehicle.auction_start_date) > new Date()) {
      return res.status(400).json({ message: 'Auction has not started yet' });
    }

    // Get current highest bid
    const [currentBidResult] = await db.query(`
      SELECT MAX(bid_amount) as highest_bid
      FROM auction_bids 
      WHERE vehicle_id = ? AND status = 'active'
    `, [id]);

    const currentHighestBid = currentBidResult[0].highest_bid || 0;
    const startingPrice = vehicle.reserve_price || vehicle.price || 0;
    
    // If no bids exist, minimum bid is the starting price
    // If bids exist, minimum bid is current highest + 1000
    const minimumBid = currentHighestBid > 0 ? currentHighestBid + 1000 : startingPrice;

    if (parseFloat(bid_amount) < minimumBid) {
      return res.status(400).json({ 
        message: `Bid must be at least R${Math.round(minimumBid).toLocaleString('en-ZA', { maximumFractionDigits: 0 })}`,
        minimum_bid: Math.round(minimumBid),
        current_highest_bid: Math.round(currentHighestBid)
      });
    }

    // Create the bid
    const [result] = await db.query(`
      INSERT INTO auction_bids (vehicle_id, bidder_name, bidder_email, bidder_phone, bid_amount, status)
      VALUES (?, ?, ?, ?, ?, 'active')
    `, [id, bidder_name, bidder_email, bidder_phone, parseFloat(bid_amount)]);

    // Update vehicle current_bid
    await db.query(`
      UPDATE vehicles 
      SET current_bid = ? 
      WHERE vehicle_id = ?
    `, [parseFloat(bid_amount), id]);

    // Mark previous bids as outbid
    await db.query(`
      UPDATE auction_bids 
      SET status = 'outbid' 
      WHERE vehicle_id = ? AND bid_id != ? AND status = 'active'
    `, [id, result.insertId]);

    res.json({
      message: 'Bid placed successfully',
      bid: {
        bid_id: result.insertId,
        vehicle_id: id,
        bidder_name,
        bidder_email,
        bidder_phone,
        bid_amount: parseFloat(bid_amount),
        bid_time: new Date(),
        status: 'active'
      }
    });
  } catch (error) {
    console.error('Place bid error:', error);
    res.status(500).json({ message: 'Server error while placing bid' });
  }
};

// Get bid history for a vehicle
exports.getVehicleBidHistory = async (req, res) => {
  try {
    const { id } = req.params;
    const { page = 1, limit = 20 } = req.query;
    const offset = (parseInt(page) - 1) * parseInt(limit);

    // Check if vehicle exists and is auction type
    const vehicle = await Vehicle.findById(id);
    if (!vehicle || vehicle.listing_type !== 'auction') {
      return res.status(404).json({ message: 'Auction vehicle not found' });
    }

    const [bids] = await db.query(`
      SELECT ab.*, 
             DATE_FORMAT(ab.bid_time, '%Y-%m-%d %H:%i:%s') as formatted_bid_time
      FROM auction_bids ab 
      WHERE ab.vehicle_id = ?
      ORDER BY ab.bid_amount DESC, ab.bid_time DESC
      LIMIT ? OFFSET ?
    `, [id, parseInt(limit), parseInt(offset)]);

    // Get total count
    const [countResult] = await db.query(`
      SELECT COUNT(*) as total 
      FROM auction_bids 
      WHERE vehicle_id = ?
    `, [id]);
    const total = countResult[0].total;

    res.json({
      bids,
      pagination: {
        current_page: parseInt(page),
        per_page: parseInt(limit),
        total,
        total_pages: Math.ceil(total / parseInt(limit))
      }
    });
  } catch (error) {
    console.error('Get vehicle bid history error:', error);
    res.status(500).json({ message: 'Server error while fetching bid history' });
  }
};

// Get auction statistics
exports.getAuctionStatistics = async (req, res) => {
  try {
    const [stats] = await db.query(`
      SELECT 
        (SELECT COUNT(*) FROM vehicles WHERE listing_type = 'auction' AND status = 'available') as total_auctions,
        (SELECT COUNT(*) FROM vehicles WHERE listing_type = 'auction' AND status = 'available' AND (auction_end_date IS NULL OR auction_end_date > NOW())) as active_auctions,
        (SELECT COUNT(*) FROM vehicles WHERE listing_type = 'auction' AND status = 'available' AND auction_end_date IS NOT NULL AND auction_end_date <= NOW()) as ended_auctions,
        (SELECT COUNT(*) FROM auction_bids WHERE status = 'active') as total_bids,
        (SELECT COUNT(DISTINCT bidder_email) FROM auction_bids WHERE status = 'active') as unique_bidders,
        (SELECT AVG(bid_amount) FROM auction_bids WHERE status = 'active') as average_bid,
        (SELECT MAX(bid_amount) FROM auction_bids WHERE status = 'active') as highest_bid
    `);

    res.json(stats[0]);
  } catch (error) {
    console.error('Get auction statistics error:', error);
    res.status(500).json({ message: 'Server error while fetching auction statistics' });
  }
};