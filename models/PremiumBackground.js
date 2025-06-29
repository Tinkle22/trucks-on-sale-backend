const db = require('../config/db');

class PremiumBackground {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM premium_backgrounds WHERE bg_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async create(backgroundData) {
    try {
      const columns = Object.keys(backgroundData).join(', ');
      const placeholders = Object.keys(backgroundData).map(() => '?').join(', ');
      const values = Object.values(backgroundData);
      
      const [result] = await db.query(
        `INSERT INTO premium_backgrounds (${columns}) VALUES (${placeholders})`,
        values
      );
      
      return { bg_id: result.insertId, ...backgroundData };
    } catch (error) {
      throw error;
    }
  }

  static async update(id, backgroundData) {
    try {
      const entries = Object.entries(backgroundData);
      const setClause = entries.map(([key]) => `${key} = ?`).join(', ');
      const values = [...entries.map(([_, value]) => value), id];
      
      const [result] = await db.query(
        `UPDATE premium_backgrounds SET ${setClause} WHERE bg_id = ?`,
        values
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM premium_backgrounds WHERE bg_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getAll(filters = {}, page = 1, limit = 10) {
    try {
      let query = 'SELECT * FROM premium_backgrounds';
      let countQuery = 'SELECT COUNT(*) as total FROM premium_backgrounds';
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
      query += ' ORDER BY priority ASC, created_at DESC LIMIT ? OFFSET ?';
      queryParams.push(parseInt(limit), parseInt(offset));
      
      // Execute queries
      const [rows] = await db.query(query, queryParams);
      const [countResult] = await db.query(countQuery, queryParams.slice(0, -2));
      
      return {
        backgrounds: rows,
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

  static async getActive() {
    try {
      const currentDate = new Date().toISOString().split('T')[0];
      
      const [rows] = await db.query(
        `SELECT * FROM premium_backgrounds 
         WHERE status = 'active' 
         AND (start_date IS NULL OR start_date <= ?) 
         AND (end_date IS NULL OR end_date >= ?)
         ORDER BY priority ASC, created_at DESC`,
        [currentDate, currentDate]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByStatus(status) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM premium_backgrounds WHERE status = ? ORDER BY priority ASC, created_at DESC',
        [status]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async updateStatus(id, status) {
    try {
      const [result] = await db.query(
        'UPDATE premium_backgrounds SET status = ? WHERE bg_id = ?',
        [status, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async updatePriority(id, priority) {
    try {
      const [result] = await db.query(
        'UPDATE premium_backgrounds SET priority = ? WHERE bg_id = ?',
        [priority, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getByPriority(limit = 5) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM premium_backgrounds WHERE status = "active" ORDER BY priority ASC LIMIT ?',
        [parseInt(limit)]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getExpired() {
    try {
      const currentDate = new Date().toISOString().split('T')[0];
      
      const [rows] = await db.query(
        'SELECT * FROM premium_backgrounds WHERE status = "active" AND end_date < ? ORDER BY end_date DESC',
        [currentDate]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getUpcoming() {
    try {
      const currentDate = new Date().toISOString().split('T')[0];
      
      const [rows] = await db.query(
        'SELECT * FROM premium_backgrounds WHERE status = "active" AND start_date > ? ORDER BY start_date ASC',
        [currentDate]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByAdvertiser(advertiserName) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM premium_backgrounds WHERE advertiser_name = ? ORDER BY created_at DESC',
        [advertiserName]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByDateRange(startDate, endDate) {
    try {
      const [rows] = await db.query(
        `SELECT * FROM premium_backgrounds 
         WHERE (start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?)
         OR (start_date <= ? AND end_date >= ?)
         ORDER BY start_date ASC`,
        [startDate, endDate, startDate, endDate, startDate, endDate]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getStatistics() {
    try {
      const [totalBackgrounds] = await db.query('SELECT COUNT(*) as total FROM premium_backgrounds');
      const [activeBackgrounds] = await db.query('SELECT COUNT(*) as total FROM premium_backgrounds WHERE status = "active"');
      const [inactiveBackgrounds] = await db.query('SELECT COUNT(*) as total FROM premium_backgrounds WHERE status = "inactive"');
      
      const currentDate = new Date().toISOString().split('T')[0];
      const [currentlyActive] = await db.query(
        `SELECT COUNT(*) as total FROM premium_backgrounds 
         WHERE status = 'active' 
         AND (start_date IS NULL OR start_date <= ?) 
         AND (end_date IS NULL OR end_date >= ?)`,
        [currentDate, currentDate]
      );
      
      const [expired] = await db.query(
        'SELECT COUNT(*) as total FROM premium_backgrounds WHERE status = "active" AND end_date < ?',
        [currentDate]
      );
      
      const [upcoming] = await db.query(
        'SELECT COUNT(*) as total FROM premium_backgrounds WHERE status = "active" AND start_date > ?',
        [currentDate]
      );
      
      return {
        total_backgrounds: totalBackgrounds[0].total,
        active_backgrounds: activeBackgrounds[0].total,
        inactive_backgrounds: inactiveBackgrounds[0].total,
        currently_active: currentlyActive[0].total,
        expired_backgrounds: expired[0].total,
        upcoming_backgrounds: upcoming[0].total
      };
    } catch (error) {
      throw error;
    }
  }

  static async reorderPriorities(backgroundIds) {
    try {
      const promises = backgroundIds.map((id, index) => {
        return db.query(
          'UPDATE premium_backgrounds SET priority = ? WHERE bg_id = ?',
          [index + 1, id]
        );
      });
      
      await Promise.all(promises);
      return true;
    } catch (error) {
      throw error;
    }
  }

  static async getMaxPriority() {
    try {
      const [rows] = await db.query('SELECT MAX(priority) as max_priority FROM premium_backgrounds');
      return rows[0].max_priority || 0;
    } catch (error) {
      throw error;
    }
  }

  static async getRandomActive(limit = 1) {
    try {
      const currentDate = new Date().toISOString().split('T')[0];
      
      const [rows] = await db.query(
        `SELECT * FROM premium_backgrounds 
         WHERE status = 'active' 
         AND (start_date IS NULL OR start_date <= ?) 
         AND (end_date IS NULL OR end_date >= ?)
         ORDER BY RAND() LIMIT ?`,
        [currentDate, currentDate, parseInt(limit)]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async searchBackgrounds(searchTerm, page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      const searchPattern = `%${searchTerm}%`;
      
      const [rows] = await db.query(
        `SELECT * FROM premium_backgrounds 
         WHERE title LIKE ? OR advertiser_name LIKE ? OR advertiser_contact LIKE ?
         ORDER BY priority ASC, created_at DESC
         LIMIT ? OFFSET ?`,
        [searchPattern, searchPattern, searchPattern, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        `SELECT COUNT(*) as total FROM premium_backgrounds 
         WHERE title LIKE ? OR advertiser_name LIKE ? OR advertiser_contact LIKE ?`,
        [searchPattern, searchPattern, searchPattern]
      );
      
      return {
        backgrounds: rows,
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
}

module.exports = PremiumBackground;
