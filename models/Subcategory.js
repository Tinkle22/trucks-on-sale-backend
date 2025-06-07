const db = require('../config/db');

class Subcategory {
  static async getAll() {
    try {
      const [rows] = await db.query('SELECT * FROM subcategories ORDER BY category, name');
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByCategory(category) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM subcategories WHERE category = ? ORDER BY name',
        [category]
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
}

module.exports = Subcategory;