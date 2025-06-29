const db = require('../config/db');

class VehicleImage {
  // Helper function to map image URLs
  static mapImageUrl(imagePath) {
    if (!imagePath) return null;

    // If it's already a full URL, return as is
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }

    // Get the image domain from environment or use default
    const imageDomain = process.env.IMAGE_DOMAIN || 'https://trucksonsale.co.za';

    // Clean up the path to avoid double /uploads/
    let cleanPath = imagePath;

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
        'SELECT * FROM vehicle_images WHERE vehicle_id = ? ORDER BY is_primary DESC',
        [vehicleId]
      );

      // Map image URLs for each row
      return rows.map(row => ({
        ...row,
        image_path: this.mapImageUrl(row.image_path),
        original_path: row.image_path // Keep original for reference
      }));
    } catch (error) {
      throw error;
    }
  }

  static async findById(imageId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM vehicle_images WHERE image_id = ?',
        [imageId]
      );

      if (rows.length === 0) return null;

      const row = rows[0];
      return {
        ...row,
        image_path: this.mapImageUrl(row.image_path),
        original_path: row.image_path
      };
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

      return {
        image_id: result.insertId,
        ...imageData,
        image_path: this.mapImageUrl(image_path),
        original_path: image_path
      };
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