const db = require('../config/db');

class Category {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM categories WHERE category_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async findByKey(key) {
    try {
      const [rows] = await db.query('SELECT * FROM categories WHERE category_key = ?', [key]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async create(categoryData) {
    try {
      const columns = Object.keys(categoryData).join(', ');
      const placeholders = Object.keys(categoryData).map(() => '?').join(', ');
      const values = Object.values(categoryData);
      
      const [result] = await db.query(
        `INSERT INTO categories (${columns}) VALUES (${placeholders})`,
        values
      );
      
      return { category_id: result.insertId, ...categoryData };
    } catch (error) {
      throw error;
    }
  }

  static async update(id, categoryData) {
    try {
      const entries = Object.entries(categoryData);
      const setClause = entries.map(([key]) => `${key} = ?`).join(', ');
      const values = [...entries.map(([_, value]) => value), id];
      
      const [result] = await db.query(
        `UPDATE categories SET ${setClause} WHERE category_id = ?`,
        values
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM categories WHERE category_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getAll(filters = {}) {
    try {
      let query = 'SELECT * FROM categories';
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
        }
      }
      
      query += ' ORDER BY category_name ASC';
      
      const [rows] = await db.query(query, queryParams);
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getActive() {
    try {
      const [rows] = await db.query(
        'SELECT * FROM categories WHERE status = "active" ORDER BY category_name ASC'
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async updateStatus(id, status) {
    try {
      const [result] = await db.query(
        'UPDATE categories SET status = ? WHERE category_id = ?',
        [status, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getWithSubcategories() {
    try {
      const [categories] = await db.query(
        'SELECT * FROM categories WHERE status = "active" ORDER BY category_name ASC'
      );
      
      for (const category of categories) {
        const [subcategories] = await db.query(
          'SELECT * FROM subcategories WHERE category_id = ? AND status = "active" ORDER BY subcategory_name ASC',
          [category.category_id]
        );
        category.subcategories = subcategories;
      }
      
      return categories;
    } catch (error) {
      throw error;
    }
  }

  static async getWithMakes() {
    try {
      const [categories] = await db.query(
        'SELECT * FROM categories WHERE status = "active" ORDER BY category_name ASC'
      );
      
      for (const category of categories) {
        const [makes] = await db.query(
          'SELECT * FROM category_makes WHERE category_id = ? AND status = "active" ORDER BY make_name ASC',
          [category.category_id]
        );
        category.makes = makes;
      }
      
      return categories;
    } catch (error) {
      throw error;
    }
  }

  static async getStatistics() {
    try {
      const [totalCategories] = await db.query('SELECT COUNT(*) as total FROM categories');
      const [activeCategories] = await db.query('SELECT COUNT(*) as total FROM categories WHERE status = "active"');
      const [totalSubcategories] = await db.query('SELECT COUNT(*) as total FROM subcategories');
      const [totalMakes] = await db.query('SELECT COUNT(*) as total FROM category_makes');
      
      return {
        total_categories: totalCategories[0].total,
        active_categories: activeCategories[0].total,
        total_subcategories: totalSubcategories[0].total,
        total_makes: totalMakes[0].total
      };
    } catch (error) {
      throw error;
    }
  }
}

module.exports = Category;
