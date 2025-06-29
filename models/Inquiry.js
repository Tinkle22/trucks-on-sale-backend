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
      const { vehicle_id, dealer_id, full_name, email, phone, message } = inquiryData;

      const [result] = await db.query(
        'INSERT INTO inquiries (vehicle_id, dealer_id, full_name, email, phone, message) VALUES (?, ?, ?, ?, ?, ?)',
        [vehicle_id, dealer_id, full_name, email, phone, message]
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
        'SELECT * FROM inquiries WHERE vehicle_id = ? ORDER BY created_at DESC',
        [vehicleId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByUserId(userId) {
    try {
      // Since we don't have user_id, we'll search by email or full_name
      // This method might not be very useful without proper user management
      const [rows] = await db.query(
        `SELECT i.*, v.make, v.model, v.year
         FROM inquiries i
         JOIN vehicles v ON i.vehicle_id = v.vehicle_id
         WHERE i.email = ? OR i.full_name = ?
         ORDER BY i.created_at DESC`,
        [userId, userId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByDealerId(dealerId) {
    try {
      const [rows] = await db.query(
        `SELECT i.*, v.make, v.model, v.year
         FROM inquiries i
         JOIN vehicles v ON i.vehicle_id = v.vehicle_id
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