const db = require('../config/db');

class VehicleDocument {
  // Helper function to map document URLs
  static mapDocumentUrl(documentPath) {
    if (!documentPath) return null;

    // If it's already a full URL, return as is
    if (documentPath.startsWith('http://') || documentPath.startsWith('https://')) {
      return documentPath;
    }

    // Get the image domain from environment or use default
    const imageDomain = process.env.IMAGE_DOMAIN || 'https://trucksonsale.co.za';

    // Clean up the path to avoid double /uploads/
    let cleanPath = documentPath;

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
        'SELECT * FROM vehicle_documents WHERE vehicle_id = ?',
        [vehicleId]
      );

      // Map document URLs for each row
      return rows.map(row => ({
        ...row,
        document_path: this.mapDocumentUrl(row.document_path),
        original_document_path: row.document_path
      }));
    } catch (error) {
      throw error;
    }
  }

  static async create(documentData) {
    try {
      const { vehicle_id, document_name, document_path, document_type } = documentData;
      
      const [result] = await db.query(
        'INSERT INTO vehicle_documents (vehicle_id, document_name, document_path, document_type) VALUES (?, ?, ?, ?)',
        [vehicle_id, document_name, document_path, document_type]
      );
      
      return { document_id: result.insertId, ...documentData };
    } catch (error) {
      throw error;
    }
  }

  static async delete(documentId) {
    try {
      const [result] = await db.query('DELETE FROM vehicle_documents WHERE document_id = ?', [documentId]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async deleteByVehicleId(vehicleId) {
    try {
      const [result] = await db.query('DELETE FROM vehicle_documents WHERE vehicle_id = ?', [vehicleId]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = VehicleDocument;