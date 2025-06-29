const db = require('../config/db');

class AuctionBid {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM auction_bids WHERE bid_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async create(bidData) {
    try {
      const columns = Object.keys(bidData).join(', ');
      const placeholders = Object.keys(bidData).map(() => '?').join(', ');
      const values = Object.values(bidData);
      
      const [result] = await db.query(
        `INSERT INTO auction_bids (${columns}) VALUES (${placeholders})`,
        values
      );
      
      return { bid_id: result.insertId, ...bidData };
    } catch (error) {
      throw error;
    }
  }

  static async getByAuction(auctionId, page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      
      const [rows] = await db.query(
        `SELECT ab.*, u.username, u.company_name
         FROM auction_bids ab
         LEFT JOIN users u ON ab.bidder_id = u.user_id
         WHERE ab.auction_id = ?
         ORDER BY ab.bid_time DESC LIMIT ? OFFSET ?`,
        [auctionId, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM auction_bids WHERE auction_id = ?',
        [auctionId]
      );
      
      return {
        bids: rows,
        pagination: {
          total: countResult[0].total,
          page: parseInt(page),
          limit: parseInt(limit),
          pages: Math.ceil(countResult[0].total / limit)
        }
      };
    } catch (error) {
      throw error;
    }
  }

  static async getByBidder(bidderId, page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      
      const [rows] = await db.query(
        `SELECT ab.*, a.auction_id, a.status as auction_status, 
                v.make, v.model, v.year, a.end_time
         FROM auction_bids ab
         LEFT JOIN auctions a ON ab.auction_id = a.auction_id
         LEFT JOIN vehicles v ON a.vehicle_id = v.vehicle_id
         WHERE ab.bidder_id = ?
         ORDER BY ab.bid_time DESC LIMIT ? OFFSET ?`,
        [bidderId, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM auction_bids WHERE bidder_id = ?',
        [bidderId]
      );
      
      return {
        bids: rows,
        pagination: {
          total: countResult[0].total,
          page: parseInt(page),
          limit: parseInt(limit),
          pages: Math.ceil(countResult[0].total / limit)
        }
      };
    } catch (error) {
      throw error;
    }
  }

  static async getHighestBid(auctionId) {
    try {
      const [rows] = await db.query(
        `SELECT ab.*, u.username, u.company_name
         FROM auction_bids ab
         LEFT JOIN users u ON ab.bidder_id = u.user_id
         WHERE ab.auction_id = ?
         ORDER BY ab.bid_amount DESC, ab.bid_time ASC
         LIMIT 1`,
        [auctionId]
      );
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async getBidHistory(auctionId) {
    try {
      const [rows] = await db.query(
        `SELECT ab.*, u.username, u.company_name
         FROM auction_bids ab
         LEFT JOIN users u ON ab.bidder_id = u.user_id
         WHERE ab.auction_id = ?
         ORDER BY ab.bid_time DESC`,
        [auctionId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getUserBidsForAuction(auctionId, bidderId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM auction_bids WHERE auction_id = ? AND bidder_id = ? ORDER BY bid_time DESC',
        [auctionId, bidderId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getLatestBidForAuction(auctionId) {
    try {
      const [rows] = await db.query(
        `SELECT ab.*, u.username, u.company_name
         FROM auction_bids ab
         LEFT JOIN users u ON ab.bidder_id = u.user_id
         WHERE ab.auction_id = ?
         ORDER BY ab.bid_time DESC
         LIMIT 1`,
        [auctionId]
      );
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async getBidCount(auctionId) {
    try {
      const [rows] = await db.query(
        'SELECT COUNT(*) as total FROM auction_bids WHERE auction_id = ?',
        [auctionId]
      );
      return rows[0].total;
    } catch (error) {
      throw error;
    }
  }

  static async getUniqueBidders(auctionId) {
    try {
      const [rows] = await db.query(
        'SELECT COUNT(DISTINCT bidder_id) as total FROM auction_bids WHERE auction_id = ?',
        [auctionId]
      );
      return rows[0].total;
    } catch (error) {
      throw error;
    }
  }

  static async hasUserBid(auctionId, bidderId) {
    try {
      const [rows] = await db.query(
        'SELECT COUNT(*) as total FROM auction_bids WHERE auction_id = ? AND bidder_id = ?',
        [auctionId, bidderId]
      );
      return rows[0].total > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getWinningBids(bidderId) {
    try {
      const [rows] = await db.query(
        `SELECT ab.*, a.auction_id, a.status as auction_status,
                v.make, v.model, v.year, v.vehicle_id
         FROM auction_bids ab
         LEFT JOIN auctions a ON ab.auction_id = a.auction_id
         LEFT JOIN vehicles v ON a.vehicle_id = v.vehicle_id
         WHERE ab.bidder_id = ? AND a.winner_id = ? AND a.status = 'ended'
         ORDER BY ab.bid_time DESC`,
        [bidderId, bidderId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getStatistics() {
    try {
      const [totalBids] = await db.query('SELECT COUNT(*) as total FROM auction_bids');
      const [uniqueBidders] = await db.query('SELECT COUNT(DISTINCT bidder_id) as total FROM auction_bids');
      const [avgBidAmount] = await db.query('SELECT AVG(bid_amount) as average FROM auction_bids');
      const [maxBidAmount] = await db.query('SELECT MAX(bid_amount) as maximum FROM auction_bids');
      
      return {
        total_bids: totalBids[0].total,
        unique_bidders: uniqueBidders[0].total,
        average_bid_amount: parseFloat(avgBidAmount[0].average || 0).toFixed(2),
        maximum_bid_amount: parseFloat(maxBidAmount[0].maximum || 0).toFixed(2)
      };
    } catch (error) {
      throw error;
    }
  }

  static async deleteByAuction(auctionId) {
    try {
      const [result] = await db.query('DELETE FROM auction_bids WHERE auction_id = ?', [auctionId]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  }

  static async getTopBidders(limit = 10) {
    try {
      const [rows] = await db.query(
        `SELECT u.user_id, u.username, u.company_name,
                COUNT(ab.bid_id) as total_bids,
                MAX(ab.bid_amount) as highest_bid,
                AVG(ab.bid_amount) as average_bid
         FROM auction_bids ab
         LEFT JOIN users u ON ab.bidder_id = u.user_id
         GROUP BY ab.bidder_id
         ORDER BY total_bids DESC, highest_bid DESC
         LIMIT ?`,
        [parseInt(limit)]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = AuctionBid;
