const db = require('../config/db');

class VehicleVideo {
  // Helper function to map video URLs
  static mapVideoUrl(videoPath) {
    if (!videoPath) return null;

    // If it's already a full URL, return as is
    if (videoPath.startsWith('http://') || videoPath.startsWith('https://')) {
      return videoPath;
    }

    // Get the image domain from environment or use default
    const imageDomain = process.env.IMAGE_DOMAIN || 'https://trucksonsale.co.za';

    // Clean up the path to avoid double /uploads/
    let cleanPath = videoPath;

    // If it starts with /uploads/, use it as is
    if (cleanPath.startsWith('/uploads/')) {
      return `${imageDomain}${cleanPath}`;
    }

    // If it starts with uploads/ (without leading slash), add the slash
    if (cleanPath.startsWith('uploads/')) {
      return `${imageDomain}/${cleanPath}`;
    }

    // If it's just a filename or relative path, assume it's in uploads
    if (!cleanPath.startsWith('/')) {
      return `${imageDomain}/uploads/${cleanPath}`;
    }

    // Default case - prepend the domain
    return `${imageDomain}${cleanPath}`;
  }

  static async findByVehicleId(vehicleId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM vehicle_videos WHERE vehicle_id = ?',
        [vehicleId]
      );

      // Map video URLs for each row
      return rows.map(row => ({
        ...row,
        video_path: this.mapVideoUrl(row.video_path),
        thumbnail_path: this.mapVideoUrl(row.thumbnail_path),
        original_video_path: row.video_path,
        original_thumbnail_path: row.thumbnail_path
      }));
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