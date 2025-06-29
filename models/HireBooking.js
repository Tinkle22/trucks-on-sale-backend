const db = require('../config/db');

class HireBooking {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM hire_bookings WHERE booking_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async create(bookingData) {
    try {
      const columns = Object.keys(bookingData).join(', ');
      const placeholders = Object.keys(bookingData).map(() => '?').join(', ');
      const values = Object.values(bookingData);
      
      const [result] = await db.query(
        `INSERT INTO hire_bookings (${columns}) VALUES (${placeholders})`,
        values
      );
      
      return { booking_id: result.insertId, ...bookingData };
    } catch (error) {
      throw error;
    }
  }

  static async update(id, bookingData) {
    try {
      const entries = Object.entries(bookingData);
      const setClause = entries.map(([key]) => `${key} = ?`).join(', ');
      const values = [...entries.map(([_, value]) => value), id];
      
      const [result] = await db.query(
        `UPDATE hire_bookings SET ${setClause} WHERE booking_id = ?`,
        values
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM hire_bookings WHERE booking_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getAll(filters = {}, page = 1, limit = 10) {
    try {
      let query = `
        SELECT hb.*, v.make, v.model, v.year, v.category, v.dealer_id,
               u.company_name as dealer_name
        FROM hire_bookings hb
        LEFT JOIN vehicles v ON hb.vehicle_id = v.vehicle_id
        LEFT JOIN users u ON v.dealer_id = u.user_id
      `;
      let countQuery = 'SELECT COUNT(*) as total FROM hire_bookings hb';
      let queryParams = [];
      
      // Build WHERE clause based on filters
      if (Object.keys(filters).length > 0) {
        const whereConditions = [];
        
        for (const [key, value] of Object.entries(filters)) {
          if (value !== undefined && value !== null && value !== '') {
            if (key === 'status') {
              whereConditions.push('hb.status = ?');
            } else if (key === 'category') {
              whereConditions.push('v.category = ?');
            } else if (key === 'dealer_id') {
              whereConditions.push('v.dealer_id = ?');
            } else {
              whereConditions.push(`hb.${key} = ?`);
            }
            queryParams.push(value);
          }
        }
        
        if (whereConditions.length > 0) {
          const whereClause = whereConditions.join(' AND ');
          query += ` WHERE ${whereClause}`;
          countQuery += ` LEFT JOIN vehicles v ON hb.vehicle_id = v.vehicle_id WHERE ${whereClause}`;
        }
      }
      
      // Add pagination
      const offset = (page - 1) * limit;
      query += ' ORDER BY hb.created_at DESC LIMIT ? OFFSET ?';
      queryParams.push(parseInt(limit), parseInt(offset));
      
      // Execute queries
      const [rows] = await db.query(query, queryParams);
      const [countResult] = await db.query(countQuery, queryParams.slice(0, -2));
      
      return {
        bookings: rows,
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
        `SELECT hb.*, v.make, v.model, v.year, v.category, v.dealer_id,
                u.company_name as dealer_name
         FROM hire_bookings hb
         LEFT JOIN vehicles v ON hb.vehicle_id = v.vehicle_id
         LEFT JOIN users u ON v.dealer_id = u.user_id
         WHERE hb.status = ?
         ORDER BY hb.created_at DESC LIMIT ? OFFSET ?`,
        [status, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM hire_bookings WHERE status = ?',
        [status]
      );
      
      return {
        bookings: rows,
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

  static async getByVehicle(vehicleId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM hire_bookings WHERE vehicle_id = ? ORDER BY created_at DESC',
        [vehicleId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByEmail(email) {
    try {
      const [rows] = await db.query(
        `SELECT hb.*, v.make, v.model, v.year, v.category
         FROM hire_bookings hb
         LEFT JOIN vehicles v ON hb.vehicle_id = v.vehicle_id
         WHERE hb.email = ?
         ORDER BY hb.created_at DESC`,
        [email]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByDealer(dealerId, page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      
      const [rows] = await db.query(
        `SELECT hb.*, v.make, v.model, v.year, v.category
         FROM hire_bookings hb
         LEFT JOIN vehicles v ON hb.vehicle_id = v.vehicle_id
         WHERE v.dealer_id = ?
         ORDER BY hb.created_at DESC LIMIT ? OFFSET ?`,
        [dealerId, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        `SELECT COUNT(*) as total
         FROM hire_bookings hb
         LEFT JOIN vehicles v ON hb.vehicle_id = v.vehicle_id
         WHERE v.dealer_id = ?`,
        [dealerId]
      );
      
      return {
        bookings: rows,
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
        'UPDATE hire_bookings SET status = ? WHERE booking_id = ?',
        [status, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getActiveBookings(page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      
      const [rows] = await db.query(
        `SELECT hb.*, v.make, v.model, v.year, v.category, v.dealer_id,
                u.company_name as dealer_name
         FROM hire_bookings hb
         LEFT JOIN vehicles v ON hb.vehicle_id = v.vehicle_id
         LEFT JOIN users u ON v.dealer_id = u.user_id
         WHERE hb.status = 'active' AND hb.end_date >= CURDATE()
         ORDER BY hb.start_date ASC LIMIT ? OFFSET ?`,
        [parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM hire_bookings WHERE status = "active" AND end_date >= CURDATE()'
      );
      
      return {
        bookings: rows,
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

  static async getUpcomingBookings(page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      
      const [rows] = await db.query(
        `SELECT hb.*, v.make, v.model, v.year, v.category, v.dealer_id,
                u.company_name as dealer_name
         FROM hire_bookings hb
         LEFT JOIN vehicles v ON hb.vehicle_id = v.vehicle_id
         LEFT JOIN users u ON v.dealer_id = u.user_id
         WHERE hb.status IN ('confirmed', 'pending') AND hb.start_date > CURDATE()
         ORDER BY hb.start_date ASC LIMIT ? OFFSET ?`,
        [parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM hire_bookings WHERE status IN ("confirmed", "pending") AND start_date > CURDATE()'
      );
      
      return {
        bookings: rows,
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

  static async getStatistics() {
    try {
      const [totalBookings] = await db.query('SELECT COUNT(*) as total FROM hire_bookings');
      const [pendingBookings] = await db.query('SELECT COUNT(*) as total FROM hire_bookings WHERE status = "pending"');
      const [confirmedBookings] = await db.query('SELECT COUNT(*) as total FROM hire_bookings WHERE status = "confirmed"');
      const [activeBookings] = await db.query('SELECT COUNT(*) as total FROM hire_bookings WHERE status = "active"');
      const [completedBookings] = await db.query('SELECT COUNT(*) as total FROM hire_bookings WHERE status = "completed"');
      const [cancelledBookings] = await db.query('SELECT COUNT(*) as total FROM hire_bookings WHERE status = "cancelled"');
      const [totalRevenue] = await db.query('SELECT SUM(total_cost) as total FROM hire_bookings WHERE status IN ("completed", "active")');
      const [avgBookingValue] = await db.query('SELECT AVG(total_cost) as average FROM hire_bookings WHERE total_cost IS NOT NULL');
      
      return {
        total_bookings: totalBookings[0].total,
        pending_bookings: pendingBookings[0].total,
        confirmed_bookings: confirmedBookings[0].total,
        active_bookings: activeBookings[0].total,
        completed_bookings: completedBookings[0].total,
        cancelled_bookings: cancelledBookings[0].total,
        total_revenue: parseFloat(totalRevenue[0].total || 0).toFixed(2),
        average_booking_value: parseFloat(avgBookingValue[0].average || 0).toFixed(2)
      };
    } catch (error) {
      throw error;
    }
  }

  static async getBookingsByDateRange(startDate, endDate) {
    try {
      const [rows] = await db.query(
        `SELECT hb.*, v.make, v.model, v.year
         FROM hire_bookings hb
         LEFT JOIN vehicles v ON hb.vehicle_id = v.vehicle_id
         WHERE hb.start_date BETWEEN ? AND ?
         ORDER BY hb.start_date ASC`,
        [startDate, endDate]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async checkVehicleAvailability(vehicleId, startDate, endDate) {
    try {
      const [rows] = await db.query(
        `SELECT COUNT(*) as conflicts
         FROM hire_bookings
         WHERE vehicle_id = ? 
         AND status IN ('confirmed', 'active')
         AND (
           (start_date <= ? AND end_date >= ?) OR
           (start_date <= ? AND end_date >= ?) OR
           (start_date >= ? AND end_date <= ?)
         )`,
        [vehicleId, startDate, startDate, endDate, endDate, startDate, endDate]
      );
      return rows[0].conflicts === 0;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = HireBooking;
