const db = require('../config/db');

class Inquiry {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM inquiries WHERE inquiry_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async create(inquiryData) {
    try {
      const { vehicle_id, user_id, message, contact_number } = inquiryData;
      
      const [result] = await db.query(
        'INSERT INTO inquiries (vehicle_id, user_id, message, contact_number) VALUES (?, ?, ?, ?)',
        [vehicle_id, user_id, message, contact_number]
      );
      
      return { inquiry_id: result.insertId, ...inquiryData, status: 'new', created_at: new Date() };
    } catch (error) {
      throw error;
    }
  }

  static async updateStatus(id, status) {
    try {
      const [result] = await db.query(
        'UPDATE inquiries SET status = ? WHERE inquiry_id = ?',
        [status, id]
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getByVehicleId(vehicleId) {
    try {
      const [rows] = await db.query(
        'SELECT i.*, u.username, u.email FROM inquiries i JOIN users u ON i.user_id = u.user_id WHERE i.vehicle_id = ? ORDER BY i.created_at DESC',
        [vehicleId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByUserId(userId) {
    try {
      const [rows] = await db.query(
        `SELECT i.*, v.make, v.model, v.year, u.username as dealer_name 
         FROM inquiries i 
         JOIN vehicles v ON i.vehicle_id = v.vehicle_id 
         JOIN users u ON v.dealer_id = u.user_id 
         WHERE i.user_id = ? 
         ORDER BY i.created_at DESC`,
        [userId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByDealerId(dealerId) {
    try {
      const [rows] = await db.query(
        `SELECT i.*, v.make, v.model, v.year, u.username, u.email, u.phone 
         FROM inquiries i 
         JOIN vehicles v ON i.vehicle_id = v.vehicle_id 
         JOIN users u ON i.user_id = u.user_id 
         WHERE v.dealer_id = ? 
         ORDER BY i.created_at DESC`,
        [dealerId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM inquiries WHERE inquiry_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = Inquiry;