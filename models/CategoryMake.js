const db = require('../config/db');

class CategoryMake {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM category_makes WHERE make_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async findByCategory(categoryId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM category_makes WHERE category_id = ? AND status = "active" ORDER BY make_name ASC',
        [categoryId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async findByCategoryAndName(categoryId, makeName) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM category_makes WHERE category_id = ? AND make_name = ?',
        [categoryId, makeName]
      );
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async create(makeData) {
    try {
      const columns = Object.keys(makeData).join(', ');
      const placeholders = Object.keys(makeData).map(() => '?').join(', ');
      const values = Object.values(makeData);
      
      const [result] = await db.query(
        `INSERT INTO category_makes (${columns}) VALUES (${placeholders})`,
        values
      );
      
      return { make_id: result.insertId, ...makeData };
    } catch (error) {
      throw error;
    }
  }

  static async update(id, makeData) {
    try {
      const entries = Object.entries(makeData);
      const setClause = entries.map(([key]) => `${key} = ?`).join(', ');
      const values = [...entries.map(([_, value]) => value), id];
      
      const [result] = await db.query(
        `UPDATE category_makes SET ${setClause} WHERE make_id = ?`,
        values
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM category_makes WHERE make_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getAll(filters = {}, page = 1, limit = 10) {
    try {
      let query = `
        SELECT cm.*, c.category_name 
        FROM category_makes cm 
        LEFT JOIN categories c ON cm.category_id = c.category_id
      `;
      let countQuery = 'SELECT COUNT(*) as total FROM category_makes cm';
      let queryParams = [];
      
      // Build WHERE clause based on filters
      if (Object.keys(filters).length > 0) {
        const whereConditions = [];
        
        for (const [key, value] of Object.entries(filters)) {
          if (value !== undefined && value !== null && value !== '') {
            if (key === 'category_id') {
              whereConditions.push('cm.category_id = ?');
            } else {
              whereConditions.push(`cm.${key} = ?`);
            }
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
      query += ' ORDER BY cm.make_name ASC LIMIT ? OFFSET ?';
      queryParams.push(parseInt(limit), parseInt(offset));
      
      // Execute queries
      const [rows] = await db.query(query, queryParams);
      const [countResult] = await db.query(countQuery, queryParams.slice(0, -2));
      
      return {
        makes: rows,
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
        'UPDATE category_makes SET status = ? WHERE make_id = ?',
        [status, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getByCategory(categoryId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM category_makes WHERE category_id = ? ORDER BY make_name ASC',
        [categoryId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getActive() {
    try {
      const [rows] = await db.query(
        `SELECT cm.*, c.category_name 
         FROM category_makes cm 
         LEFT JOIN categories c ON cm.category_id = c.category_id 
         WHERE cm.status = "active" 
         ORDER BY c.category_name ASC, cm.make_name ASC`
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async bulkCreate(categoryId, makeNames) {
    try {
      const values = makeNames.map(makeName => [categoryId, makeName, 'active']);
      const placeholders = values.map(() => '(?, ?, ?)').join(', ');
      const flatValues = values.flat();
      
      const [result] = await db.query(
        `INSERT INTO category_makes (category_id, make_name, status) VALUES ${placeholders}`,
        flatValues
      );
      
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  }

  static async deleteByCategory(categoryId) {
    try {
      const [result] = await db.query('DELETE FROM category_makes WHERE category_id = ?', [categoryId]);
      return result.affectedRows;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = CategoryMake;
