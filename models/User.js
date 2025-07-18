const db = require('../config/db');
const bcrypt = require('bcrypt');

class User {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM users WHERE user_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async findByEmail(email) {
    try {
      const [rows] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async findByUsername(username) {
    try {
      const [rows] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async create(userData) {
    try {
      // Hash password before storing
      if (userData.password) {
        const saltRounds = 10;
        userData.password = await bcrypt.hash(userData.password, saltRounds);
      }

      const columns = Object.keys(userData).join(', ');
      const placeholders = Object.keys(userData).map(() => '?').join(', ');
      const values = Object.values(userData);
      
      const [result] = await db.query(
        `INSERT INTO users (${columns}) VALUES (${placeholders})`,
        values
      );
      
      // Return user without password
      const newUser = { user_id: result.insertId, ...userData };
      delete newUser.password;
      return newUser;
    } catch (error) {
      throw error;
    }
  }

  static async update(id, userData) {
    try {
      // Hash password if it's being updated
      if (userData.password) {
        const saltRounds = 10;
        userData.password = await bcrypt.hash(userData.password, saltRounds);
      }

      const entries = Object.entries(userData);
      const setClause = entries.map(([key]) => `${key} = ?`).join(', ');
      const values = [...entries.map(([_, value]) => value), id];
      
      const [result] = await db.query(
        `UPDATE users SET ${setClause} WHERE user_id = ?`,
        values
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM users WHERE user_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getAll(filters = {}, page = 1, limit = 10) {
    try {
      let query = 'SELECT user_id, username, email, phone, company_name, user_type, status, registered_at FROM users';
      let countQuery = 'SELECT COUNT(*) as total FROM users';
      let queryParams = [];
      
      // Build WHERE clause based on filters
      if (Object.keys(filters).length > 0) {
        const whereConditions = [];
        
        for (const [key, value] of Object.entries(filters)) {
          if (value !== undefined && value !== null && value !== '') {
            whereConditions.push(`${key} = ?`);
            queryParams.push(value);
          }
        }
        
        if (whereConditions.length > 0) {
          const whereClause = whereConditions.join(' AND ');
          query += ` WHERE ${whereClause}`;
          countQuery += ` WHERE ${whereClause}`;
        }
      }
      
      // Add pagination
      const offset = (page - 1) * limit;
      query += ' ORDER BY registered_at DESC LIMIT ? OFFSET ?';
      queryParams.push(parseInt(limit), parseInt(offset));
      
      // Execute queries
      const [rows] = await db.query(query, queryParams);
      const [countResult] = await db.query(countQuery, queryParams.slice(0, -2));
      
      return {
        users: rows,
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

  static async validatePassword(plainPassword, hashedPassword) {
    try {
      return await bcrypt.compare(plainPassword, hashedPassword);
    } catch (error) {
      throw error;
    }
  }

  static async updateStatus(id, status) {
    try {
      const [result] = await db.query(
        'UPDATE users SET status = ? WHERE user_id = ?',
        [status, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getDealers(page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;

      // Get dealers with vehicle count and additional info
      const [rows] = await db.query(`
        SELECT
          u.user_id,
          u.username,
          u.email,
          u.phone,
          u.company_name,
          u.status,
          u.registered_at,
          u.physical_address,
          COUNT(v.vehicle_id) as vehicle_count
        FROM users u
        LEFT JOIN vehicles v ON u.user_id = v.dealer_id AND v.status = 'available'
        WHERE u.user_type = "dealer" AND u.status = "active"
        GROUP BY u.user_id
        ORDER BY u.registered_at DESC
        LIMIT ? OFFSET ?`,
        [parseInt(limit), parseInt(offset)]
      );

      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM users WHERE user_type = "dealer" AND status = "active"'
      );

      return {
        dealers: rows,
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
      const [totalUsers] = await db.query('SELECT COUNT(*) as total FROM users');
      const [totalDealers] = await db.query('SELECT COUNT(*) as total FROM users WHERE user_type = "dealer"');
      const [totalCustomers] = await db.query('SELECT COUNT(*) as total FROM users WHERE user_type = "customer"');
      const [activeDealers] = await db.query('SELECT COUNT(*) as total FROM users WHERE user_type = "dealer" AND status = "active"');
      const [pendingDealers] = await db.query('SELECT COUNT(*) as total FROM users WHERE user_type = "dealer" AND status = "pending"');

      return {
        total_users: totalUsers[0].total,
        total_dealers: totalDealers[0].total,
        total_customers: totalCustomers[0].total,
        active_dealers: activeDealers[0].total,
        pending_dealers: pendingDealers[0].total
      };
    } catch (error) {
      throw error;
    }
  }

  static async updatePassword(id, newPassword) {
    try {
      const saltRounds = 10;
      const hashedPassword = await bcrypt.hash(newPassword, saltRounds);

      const [result] = await db.query(
        'UPDATE users SET password = ? WHERE user_id = ?',
        [hashedPassword, id]
      );

      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = User;
