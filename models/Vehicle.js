const db = require('../config/db');

class Vehicle {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM vehicles WHERE vehicle_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async create(vehicleData) {
    try {
      const columns = Object.keys(vehicleData).join(', ');
      const placeholders = Object.keys(vehicleData).map(() => '?').join(', ');
      const values = Object.values(vehicleData);
      
      const [result] = await db.query(
        `INSERT INTO vehicles (${columns}) VALUES (${placeholders})`,
        values
      );
      
      return { vehicle_id: result.insertId, ...vehicleData };
    } catch (error) {
      throw error;
    }
  }

  static async update(id, vehicleData) {
    try {
      const entries = Object.entries(vehicleData);
      const setClause = entries.map(([key]) => `${key} = ?`).join(', ');
      const values = [...entries.map(([_, value]) => value), id];
      
      const [result] = await db.query(
        `UPDATE vehicles SET ${setClause} WHERE vehicle_id = ?`,
        values
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM vehicles WHERE vehicle_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getAll(filters = {}, page = 1, limit = 10) {
    try {
      let query = 'SELECT * FROM vehicles';
      let countQuery = 'SELECT COUNT(*) as total FROM vehicles';
      let queryParams = [];
      
      // Build WHERE clause based on filters
      if (Object.keys(filters).length > 0) {
        const whereConditions = [];
        
        for (const [key, value] of Object.entries(filters)) {
          if (value !== undefined && value !== null && value !== '') {
            whereConditions.push(`${key} = ?`);
            queryParams.push(value);
          }
        }
        
        if (whereConditions.length > 0) {
          const whereClause = whereConditions.join(' AND ');
          query += ` WHERE ${whereClause}`;
          countQuery += ` WHERE ${whereClause}`;
        }
      }
      
      // Add pagination
      const offset = (page - 1) * limit;
      query += ' ORDER BY created_at DESC LIMIT ? OFFSET ?';
      queryParams.push(parseInt(limit), parseInt(offset));
      
      // Execute queries
      const [rows] = await db.query(query, queryParams);
      const [countResult] = await db.query(countQuery, queryParams.slice(0, -2));
      
      return {
        vehicles: rows,
        pagination: {
          total: countResult[0].total,
          page: parseInt(page),
          limit: parseInt(limit),
          pages: Math.ceil(countResult[0].total / limit)
        }
      };
    } catch (error) {
      throw error;
    }
  }

  static async getByDealer(dealerId, page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      
      const [rows] = await db.query(
        'SELECT * FROM vehicles WHERE dealer_id = ? ORDER BY created_at DESC LIMIT ? OFFSET ?',
        [dealerId, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM vehicles WHERE dealer_id = ?',
        [dealerId]
      );
      
      return {
        vehicles: rows,
        pagination: {
          total: countResult[0].total,
          page: parseInt(page),
          limit: parseInt(limit),
          pages: Math.ceil(countResult[0].total / limit)
        }
      };
    } catch (error) {
      throw error;
    }
  }

  static async search(searchParams, page = 1, limit = 10) {
    try {
      let query = 'SELECT * FROM vehicles';
      let countQuery = 'SELECT COUNT(*) as total FROM vehicles';
      let whereConditions = [];
      let queryParams = [];
      
      // Build WHERE clause based on search parameters
      for (const [key, value] of Object.entries(searchParams)) {
        if (value !== undefined && value !== null && value !== '') {
          if (key === 'price_min') {
            whereConditions.push('price >= ?');
            queryParams.push(parseFloat(value));
          } else if (key === 'price_max') {
            whereConditions.push('price <= ?');
            queryParams.push(parseFloat(value));
          } else if (key === 'year_min') {
            whereConditions.push('year >= ?');
            queryParams.push(parseInt(value));
          } else if (key === 'year_max') {
            whereConditions.push('year <= ?');
            queryParams.push(parseInt(value));
          } else if (key === 'mileage_min') {
            whereConditions.push('mileage >= ?');
            queryParams.push(parseInt(value));
          } else if (key === 'mileage_max') {
            whereConditions.push('mileage <= ?');
            queryParams.push(parseInt(value));
          } else if (key === 'search_term') {
            whereConditions.push('(make LIKE ? OR model LIKE ? OR description LIKE ?)');
            const searchTerm = `%${value}%`;
            queryParams.push(searchTerm, searchTerm, searchTerm);
          } else if (key === 'make' && Array.isArray(value)) {
            // Handle multiple makes using IN clause
            const placeholders = value.map(() => '?').join(',');
            whereConditions.push(`make IN (${placeholders})`);
            queryParams.push(...value);
          } else {
            whereConditions.push(`${key} = ?`);
            queryParams.push(value);
          }
        }
      }
      
      if (whereConditions.length > 0) {
        const whereClause = whereConditions.join(' AND ');
        query += ` WHERE ${whereClause}`;
        countQuery += ` WHERE ${whereClause}`;
      }
      
      // Add pagination
      const offset = (page - 1) * limit;
      query += ' ORDER BY created_at DESC LIMIT ? OFFSET ?';
      queryParams.push(parseInt(limit), parseInt(offset));
      
      // Execute queries
      const [rows] = await db.query(query, queryParams);
      const [countResult] = await db.query(countQuery, queryParams.slice(0, -2));
      
      return {
        vehicles: rows,
        pagination: {
          total: countResult[0].total,
          page: parseInt(page),
          limit: parseInt(limit),
          pages: Math.ceil(countResult[0].total / limit)
        }
      };
    } catch (error) {
      throw error;
    }
  }

  static async getFeatured(limit = 6) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM vehicles WHERE featured = 1 AND status = "available" ORDER BY created_at DESC LIMIT ?',
        [parseInt(limit)]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getMakesByCategory(category) {
    try {
      const [rows] = await db.query(
        'SELECT DISTINCT make FROM vehicles WHERE category = ? AND make IS NOT NULL AND make != "" ORDER BY make ASC',
        [category]
      );
      return rows.map(row => row.make);
    } catch (error) {
      throw error;
    }
  }

  static async getModelsByMake(make, category) {
    try {
      const [rows] = await db.query(
        'SELECT DISTINCT model FROM vehicles WHERE make = ? AND category = ? AND model IS NOT NULL AND model != "" ORDER BY model ASC',
        [make, category]
      );
      return rows.map(row => row.model);
    } catch (error) {
      throw error;
    }
  }
}

module.exports = Vehicle;