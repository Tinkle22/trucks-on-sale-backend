const db = require('../config/db');

class VehicleVideo {
  static async findByVehicleId(vehicleId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM vehicle_videos WHERE vehicle_id = ?',
        [vehicleId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async create(videoData) {
    try {
      const { vehicle_id, video_path, thumbnail_path } = videoData;
      
      const [result] = await db.query(
        'INSERT INTO vehicle_videos (vehicle_id, video_path, thumbnail_path) VALUES (?, ?, ?)',
        [vehicle_id, video_path, thumbnail_path || null]
      );
      
      return { video_id: result.insertId, ...videoData };
    } catch (error) {
      throw error;
    }
  }

  static async delete(videoId) {
    try {
      const [result] = await db.query('DELETE FROM vehicle_videos WHERE video_id = ?', [videoId]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async deleteByVehicleId(vehicleId) {
    try {
      const [result] = await db.query('DELETE FROM vehicle_videos WHERE vehicle_id = ?', [vehicleId]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = VehicleVideo;