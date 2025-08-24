const db = require('../config/db');

class Rent2Own {
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
      const offset = (page - 1) * limit;
      let whereClause = '';
      let queryParams = [];
      
      if (Object.keys(filters).length > 0) {
        const conditions = [];
        Object.entries(filters).forEach(([key, value]) => {
          if (value !== undefined && value !== null && value !== '') {
            conditions.push(`r2o.${key} = ?`);
            queryParams.push(value);
          }
        });
        
        if (conditions.length > 0) {
          whereClause = 'WHERE ' + conditions.join(' AND ');
        }
      }
      
      const query = `
        SELECT 
          r2o.*,
          v.make, v.model, v.year, v.price, v.mileage, v.region, v.city,
          v.condition_type, v.fuel_type, v.transmission
        FROM rent_to_own_bookings r2o
        LEFT JOIN vehicles v ON r2o.vehicle_id = v.vehicle_id
        ${whereClause}
        ORDER BY r2o.created_at DESC
        LIMIT ? OFFSET ?
      `;
      
      let countQuery = 'SELECT COUNT(*) as total FROM rent_to_own_bookings r2o';
      if (whereClause) {
        countQuery += ` ${whereClause}`;
      }
      
      const [bookings] = await db.query(query, [...queryParams, limit, offset]);
      const [countResult] = await db.query(countQuery, queryParams);
      
      return {
        bookings,
        pagination: {
          page: parseInt(page),
          limit: parseInt(limit),
          total: countResult[0].total,
          pages: Math.ceil(countResult[0].total / limit)
        }
      };
    } catch (error) {
      throw error;
    }
  }

  static async getByStatus(status) {
    try {
      const [rows] = await db.query(
        'SELECT COUNT(*) as total FROM rent_to_own_bookings WHERE status = ?',
        [status]
      );
      return rows[0].total;
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

  static async getByCustomerEmail(email) {
    try {
      const [rows] = await db.query(
        `SELECT 
          r2o.*,
          v.make, v.model, v.year, v.price, v.region, v.city
        FROM rent_to_own_bookings r2o
        LEFT JOIN vehicles v ON r2o.vehicle_id = v.vehicle_id
        WHERE r2o.customer_email = ?
        ORDER BY r2o.created_at DESC`,
        [email]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async updateStatus(id, status) {
    try {
      const [result] = await db.query(
        'UPDATE rent_to_own_bookings SET status = ? WHERE booking_id = ?',
        [status, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getActiveBookings() {
    try {
      const [rows] = await db.query(
        `SELECT 
          r2o.*,
          v.make, v.model, v.year, v.price
        FROM rent_to_own_bookings r2o
        LEFT JOIN vehicles v ON r2o.vehicle_id = v.vehicle_id
        WHERE r2o.status = "active"
        ORDER BY r2o.created_at DESC`
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM rent_to_own_bookings WHERE status = "active"'
      );
      
      return {
        bookings: rows,
        total: countResult[0].total
      };
    } catch (error) {
      throw error;
    }
  }

  static async getPendingBookings() {
    try {
      const [rows] = await db.query(
        `SELECT 
          r2o.*,
          v.make, v.model, v.year, v.price
        FROM rent_to_own_bookings r2o
        LEFT JOIN vehicles v ON r2o.vehicle_id = v.vehicle_id
        WHERE r2o.status = "pending"
        ORDER BY r2o.created_at DESC`
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM rent_to_own_bookings WHERE status = "pending"'
      );
      
      return {
        bookings: rows,
        total: countResult[0].total
      };
    } catch (error) {
      throw error;
    }
  }

  static async getStatistics() {
    try {
      const [totalBookings] = await db.query('SELECT COUNT(*) as total FROM rent_to_own_bookings');
      const [pendingBookings] = await db.query('SELECT COUNT(*) as total FROM rent_to_own_bookings WHERE status = "pending"');
      const [approvedBookings] = await db.query('SELECT COUNT(*) as total FROM rent_to_own_bookings WHERE status = "approved"');
      const [activeBookings] = await db.query('SELECT COUNT(*) as total FROM rent_to_own_bookings WHERE status = "active"');
      const [completedBookings] = await db.query('SELECT COUNT(*) as total FROM rent_to_own_bookings WHERE status = "completed"');
      const [rejectedBookings] = await db.query('SELECT COUNT(*) as total FROM rent_to_own_bookings WHERE status = "rejected"');
      const [avgDownPayment] = await db.query('SELECT AVG(down_payment) as average FROM rent_to_own_bookings WHERE down_payment IS NOT NULL');
      const [avgTerm] = await db.query('SELECT AVG(preferred_term) as average FROM rent_to_own_bookings WHERE preferred_term IS NOT NULL');
      
      return {
        total: totalBookings[0].total,
        pending: pendingBookings[0].total,
        approved: approvedBookings[0].total,
        active: activeBookings[0].total,
        completed: completedBookings[0].total,
        rejected: rejectedBookings[0].total,
        avgDownPayment: parseFloat(avgDownPayment[0].average) || 0,
        avgTerm: parseFloat(avgTerm[0].average) || 0
      };
    } catch (error) {
      throw error;
    }
  }

  static async getRecentBookings(limit = 10) {
    try {
      const [rows] = await db.query(
        `SELECT 
          r2o.*,
          v.make, v.model, v.year, v.price
        FROM rent_to_own_bookings r2o
        LEFT JOIN vehicles v ON r2o.vehicle_id = v.vehicle_id
        ORDER BY r2o.created_at DESC
        LIMIT ?`,
        [limit]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async searchBookings(searchTerm) {
    try {
      const [rows] = await db.query(
        `SELECT 
          r2o.*,
          v.make, v.model, v.year, v.price
        FROM rent_to_own_bookings r2o
        LEFT JOIN vehicles v ON r2o.vehicle_id = v.vehicle_id
        WHERE r2o.customer_name LIKE ? 
           OR r2o.customer_email LIKE ?
           OR v.make LIKE ?
           OR v.model LIKE ?
        ORDER BY r2o.created_at DESC`,
        [`%${searchTerm}%`, `%${searchTerm}%`, `%${searchTerm}%`, `%${searchTerm}%`]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = Rent2Own;