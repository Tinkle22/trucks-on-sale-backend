const db = require('../config/db');

class VehicleImage {
  static async findByVehicleId(vehicleId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM vehicle_images WHERE vehicle_id = ? ORDER BY is_primary DESC',
        [vehicleId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async create(imageData) {
    try {
      const { vehicle_id, image_path, is_primary } = imageData;
      
      const [result] = await db.query(
        'INSERT INTO vehicle_images (vehicle_id, image_path, is_primary) VALUES (?, ?, ?)',
        [vehicle_id, image_path, is_primary || 0]
      );
      
      return { image_id: result.insertId, ...imageData };
    } catch (error) {
      throw error;
    }
  }

  static async delete(imageId) {
    try {
      const [result] = await db.query('DELETE FROM vehicle_images WHERE image_id = ?', [imageId]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async setPrimary(imageId, vehicleId) {
    try {
      // First, set all images for this vehicle to non-primary
      await db.query(
        'UPDATE vehicle_images SET is_primary = 0 WHERE vehicle_id = ?',
        [vehicleId]
      );
      
      // Then, set the selected image as primary
      const [result] = await db.query(
        'UPDATE vehicle_images SET is_primary = 1 WHERE image_id = ?',
        [imageId]
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async deleteByVehicleId(vehicleId) {
    try {
      const [result] = await db.query('DELETE FROM vehicle_images WHERE vehicle_id = ?', [vehicleId]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = VehicleImage;