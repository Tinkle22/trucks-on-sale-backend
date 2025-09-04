const db = require('../config/db');

class RentToOwnBooking {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM rent_to_own_bookings WHERE booking_id = ?', [id]);
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
        `INSERT INTO rent_to_own_bookings (${columns}) VALUES (${placeholders})`,
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
        `UPDATE rent_to_own_bookings SET ${setClause} WHERE booking_id = ?`,
        values
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM rent_to_own_bookings WHERE booking_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getAll(filters = {}, page = 1, limit = 10) {
    try {
      let query = `
        SELECT rtob.*, v.make, v.model, v.year, v.category, v.dealer_id,
               u.company_name as dealer_name
        FROM rent_to_own_bookings rtob
        LEFT JOIN vehicles v ON rtob.vehicle_id = v.vehicle_id
        LEFT JOIN users u ON v.dealer_id = u.user_id
      `;
      let countQuery = 'SELECT COUNT(*) as total FROM rent_to_own_bookings rtob';
      let queryParams = [];
      
      // Build WHERE clause based on filters
      if (Object.keys(filters).length > 0) {
        const whereConditions = [];
        
        for (const [key, value] of Object.entries(filters)) {
          if (value !== undefined && value !== null && value !== '') {
            if (key === 'status') {
              whereConditions.push('rtob.status = ?');
            } else if (key === 'category') {
              whereConditions.push('v.category = ?');
            } else if (key === 'dealer_id') {
              whereConditions.push('v.dealer_id = ?');
            } else {
              whereConditions.push(`rtob.${key} = ?`);
            }
            queryParams.push(value);
          }
        }
        
        if (whereConditions.length > 0) {
          const whereClause = whereConditions.join(' AND ');
          query += ` WHERE ${whereClause}`;
          countQuery += ` LEFT JOIN vehicles v ON rtob.vehicle_id = v.vehicle_id WHERE ${whereClause}`;
        }
      }
      
      // Add pagination
      const offset = (page - 1) * limit;
      query += ' ORDER BY rtob.created_at DESC LIMIT ? OFFSET ?';
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
        `SELECT rtob.*, v.make, v.model, v.year, v.category, v.dealer_id,
                u.company_name as dealer_name
         FROM rent_to_own_bookings rtob
         LEFT JOIN vehicles v ON rtob.vehicle_id = v.vehicle_id
         LEFT JOIN users u ON v.dealer_id = u.user_id
         WHERE rtob.status = ?
         ORDER BY rtob.created_at DESC LIMIT ? OFFSET ?`,
        [status, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM rent_to_own_bookings WHERE status = ?',
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
        'SELECT * FROM rent_to_own_bookings WHERE vehicle_id = ? ORDER BY created_at DESC',
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
        `SELECT rtob.*, v.make, v.model, v.year, v.category
         FROM rent_to_own_bookings rtob
         LEFT JOIN vehicles v ON rtob.vehicle_id = v.vehicle_id
         WHERE rtob.customer_email = ?
         ORDER BY rtob.created_at DESC`,
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
        `SELECT rtob.*, v.make, v.model, v.year, v.category
         FROM rent_to_own_bookings rtob
         LEFT JOIN vehicles v ON rtob.vehicle_id = v.vehicle_id
         WHERE v.dealer_id = ?
         ORDER BY rtob.created_at DESC LIMIT ? OFFSET ?`,
        [dealerId, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        `SELECT COUNT(*) as total
         FROM rent_to_own_bookings rtob
         LEFT JOIN vehicles v ON rtob.vehicle_id = v.vehicle_id
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

  static async checkVehicleAvailability(vehicleId) {
    try {
      // Check if vehicle has any active rent-to-own bookings
      const [rows] = await db.query(
        'SELECT COUNT(*) as count FROM rent_to_own_bookings WHERE vehicle_id = ? AND status IN ("approved", "active")',
        [vehicleId]
      );
      
      return rows[0].count === 0;
    } catch (error) {
      throw error;
    }
  }

  static async getStatistics() {
    try {
      const [totalBookings] = await db.query('SELECT COUNT(*) as total FROM rent_to_own_bookings');
      const [pendingBookings] = await db.query('SELECT COUNT(*) as pending FROM rent_to_own_bookings WHERE status = "pending"');
      const [approvedBookings] = await db.query('SELECT COUNT(*) as approved FROM rent_to_own_bookings WHERE status = "approved"');
      const [activeBookings] = await db.query('SELECT COUNT(*) as active FROM rent_to_own_bookings WHERE status = "active"');
      const [completedBookings] = await db.query('SELECT COUNT(*) as completed FROM rent_to_own_bookings WHERE status = "completed"');
      
      return {
        total: totalBookings[0].total,
        pending: pendingBookings[0].pending,
        approved: approvedBookings[0].approved,
        active: activeBookings[0].active,
        completed: completedBookings[0].completed
      };
    } catch (error) {
      throw error;
    }
  }
}

module.exports = RentToOwnBooking;