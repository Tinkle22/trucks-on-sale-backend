const db = require('../config/db');

class VehicleDocument {
  static async findByVehicleId(vehicleId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM vehicle_documents WHERE vehicle_id = ?',
        [vehicleId]
      );
      return rows;
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