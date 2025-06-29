const db = require('../config/db');

class Auction {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM auctions WHERE auction_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async create(auctionData) {
    try {
      const columns = Object.keys(auctionData).join(', ');
      const placeholders = Object.keys(auctionData).map(() => '?').join(', ');
      const values = Object.values(auctionData);
      
      const [result] = await db.query(
        `INSERT INTO auctions (${columns}) VALUES (${placeholders})`,
        values
      );
      
      return { auction_id: result.insertId, ...auctionData };
    } catch (error) {
      throw error;
    }
  }

  static async update(id, auctionData) {
    try {
      const entries = Object.entries(auctionData);
      const setClause = entries.map(([key]) => `${key} = ?`).join(', ');
      const values = [...entries.map(([_, value]) => value), id];
      
      const [result] = await db.query(
        `UPDATE auctions SET ${setClause} WHERE auction_id = ?`,
        values
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM auctions WHERE auction_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getAll(filters = {}, page = 1, limit = 10) {
    try {
      let query = `
        SELECT a.*, v.make, v.model, v.year, v.category, v.dealer_id,
               u.company_name as dealer_name
        FROM auctions a
        LEFT JOIN vehicles v ON a.vehicle_id = v.vehicle_id
        LEFT JOIN users u ON v.dealer_id = u.user_id
      `;
      let countQuery = 'SELECT COUNT(*) as total FROM auctions a';
      let queryParams = [];
      
      // Build WHERE clause based on filters
      if (Object.keys(filters).length > 0) {
        const whereConditions = [];
        
        for (const [key, value] of Object.entries(filters)) {
          if (value !== undefined && value !== null && value !== '') {
            if (key === 'status') {
              whereConditions.push('a.status = ?');
            } else if (key === 'category') {
              whereConditions.push('v.category = ?');
            } else {
              whereConditions.push(`a.${key} = ?`);
            }
            queryParams.push(value);
          }
        }
        
        if (whereConditions.length > 0) {
          const whereClause = whereConditions.join(' AND ');
          query += ` WHERE ${whereClause}`;
          countQuery += ` LEFT JOIN vehicles v ON a.vehicle_id = v.vehicle_id WHERE ${whereClause}`;
        }
      }
      
      // Add pagination
      const offset = (page - 1) * limit;
      query += ' ORDER BY a.created_at DESC LIMIT ? OFFSET ?';
      queryParams.push(parseInt(limit), parseInt(offset));
      
      // Execute queries
      const [rows] = await db.query(query, queryParams);
      const [countResult] = await db.query(countQuery, queryParams.slice(0, -2));
      
      return {
        auctions: rows,
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

  static async getByStatus(status, page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      
      const [rows] = await db.query(
        `SELECT a.*, v.make, v.model, v.year, v.category, v.dealer_id,
                u.company_name as dealer_name
         FROM auctions a
         LEFT JOIN vehicles v ON a.vehicle_id = v.vehicle_id
         LEFT JOIN users u ON v.dealer_id = u.user_id
         WHERE a.status = ?
         ORDER BY a.created_at DESC LIMIT ? OFFSET ?`,
        [status, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM auctions WHERE status = ?',
        [status]
      );
      
      return {
        auctions: rows,
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

  static async getActive(page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      
      const [rows] = await db.query(
        `SELECT a.*, v.make, v.model, v.year, v.category, v.dealer_id,
                u.company_name as dealer_name
         FROM auctions a
         LEFT JOIN vehicles v ON a.vehicle_id = v.vehicle_id
         LEFT JOIN users u ON v.dealer_id = u.user_id
         WHERE a.status = 'active' AND a.end_time > NOW()
         ORDER BY a.end_time ASC LIMIT ? OFFSET ?`,
        [parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM auctions WHERE status = "active" AND end_time > NOW()'
      );
      
      return {
        auctions: rows,
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

  static async getUpcoming(page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      
      const [rows] = await db.query(
        `SELECT a.*, v.make, v.model, v.year, v.category, v.dealer_id,
                u.company_name as dealer_name
         FROM auctions a
         LEFT JOIN vehicles v ON a.vehicle_id = v.vehicle_id
         LEFT JOIN users u ON v.dealer_id = u.user_id
         WHERE a.status = 'upcoming' AND a.start_time > NOW()
         ORDER BY a.start_time ASC LIMIT ? OFFSET ?`,
        [parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM auctions WHERE status = "upcoming" AND start_time > NOW()'
      );
      
      return {
        auctions: rows,
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

  static async updateStatus(id, status) {
    try {
      const [result] = await db.query(
        'UPDATE auctions SET status = ? WHERE auction_id = ?',
        [status, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async updateCurrentBid(id, bidAmount, bidderId) {
    try {
      const [result] = await db.query(
        'UPDATE auctions SET current_bid = ? WHERE auction_id = ?',
        [bidAmount, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async setWinner(id, winnerId) {
    try {
      const [result] = await db.query(
        'UPDATE auctions SET winner_id = ?, status = "ended" WHERE auction_id = ?',
        [winnerId, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getByVehicle(vehicleId) {
    try {
      const [rows] = await db.query('SELECT * FROM auctions WHERE vehicle_id = ?', [vehicleId]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async getStatistics() {
    try {
      const [totalAuctions] = await db.query('SELECT COUNT(*) as total FROM auctions');
      const [activeAuctions] = await db.query('SELECT COUNT(*) as total FROM auctions WHERE status = "active"');
      const [upcomingAuctions] = await db.query('SELECT COUNT(*) as total FROM auctions WHERE status = "upcoming"');
      const [endedAuctions] = await db.query('SELECT COUNT(*) as total FROM auctions WHERE status = "ended"');
      const [totalBids] = await db.query('SELECT COUNT(*) as total FROM auction_bids');
      
      return {
        total_auctions: totalAuctions[0].total,
        active_auctions: activeAuctions[0].total,
        upcoming_auctions: upcomingAuctions[0].total,
        ended_auctions: endedAuctions[0].total,
        total_bids: totalBids[0].total
      };
    } catch (error) {
      throw error;
    }
  }

  static async getExpiredAuctions() {
    try {
      const [rows] = await db.query(
        'SELECT * FROM auctions WHERE status = "active" AND end_time <= NOW()'
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getAuctionsToStart() {
    try {
      const [rows] = await db.query(
        'SELECT * FROM auctions WHERE status = "upcoming" AND start_time <= NOW()'
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = Auction;
