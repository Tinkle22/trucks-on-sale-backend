const db = require('../config/db');

class Subcategory {
  static async getAll() {
    try {
      const [rows] = await db.query(
        `SELECT s.*, c.category_name
         FROM subcategories s
         LEFT JOIN categories c ON s.category_id = c.category_id
         ORDER BY c.category_name, s.subcategory_name`
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByCategory(categoryId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM subcategories WHERE category_id = ? AND status = "active" ORDER BY subcategory_name',
        [categoryId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM subcategories WHERE subcategory_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async findByCategory(categoryId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM subcategories WHERE category_id = ? AND status = "active" ORDER BY subcategory_name',
        [categoryId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async create(subcategoryData) {
    try {
      const columns = Object.keys(subcategoryData).join(', ');
      const placeholders = Object.keys(subcategoryData).map(() => '?').join(', ');
      const values = Object.values(subcategoryData);

      const [result] = await db.query(
        `INSERT INTO subcategories (${columns}) VALUES (${placeholders})`,
        values
      );

      return { subcategory_id: result.insertId, ...subcategoryData };
    } catch (error) {
      throw error;
    }
  }

  static async update(id, subcategoryData) {
    try {
      const entries = Object.entries(subcategoryData);
      const setClause = entries.map(([key]) => `${key} = ?`).join(', ');
      const values = [...entries.map(([_, value]) => value), id];

      const [result] = await db.query(
        `UPDATE subcategories SET ${setClause} WHERE subcategory_id = ?`,
        values
      );

      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM subcategories WHERE subcategory_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async updateStatus(id, status) {
    try {
      const [result] = await db.query(
        'UPDATE subcategories SET status = ? WHERE subcategory_id = ?',
        [status, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = Subcategory;