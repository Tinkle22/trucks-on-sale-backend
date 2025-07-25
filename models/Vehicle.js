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

  static async getAll(filters = {}, page = 1, limit = 10, sort = 'created_at', order = 'desc') {
    try {
      let query = 'SELECT * FROM vehicles';
      let countQuery = 'SELECT COUNT(*) as total FROM vehicles';
      let queryParams = [];

      // Build WHERE clause based on filters
      if (Object.keys(filters).length > 0) {
        const whereConditions = [];

        for (const [key, value] of Object.entries(filters)) {
          if (value !== undefined && value !== null && value !== '') {
            if (key === 'category') {
              if (value === 'others') {
                // Others: exclude trucks, commercial, and buses (include machinery, spares, trailers, etc.)
                whereConditions.push('category NOT IN (?, ?, ?)');
                queryParams.push('trucks', 'commercial', 'buses');
              } else {
                whereConditions.push(`${key} = ?`);
                queryParams.push(value);
              }
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
      }

      // Add sorting - check for random order first
      if (sort === 'random') {
        query += ' ORDER BY RAND()';
      } else {
        const validSortColumns = ['created_at', 'price', 'year', 'mileage', 'make', 'model'];
        const validOrders = ['asc', 'desc'];

        if (validSortColumns.includes(sort) && validOrders.includes(order.toLowerCase())) {
          query += ` ORDER BY ${sort} ${order.toUpperCase()}`;
        } else {
          query += ' ORDER BY created_at DESC';
        }
      }

      // Add pagination
      const offset = (page - 1) * limit;
      query += ' LIMIT ? OFFSET ?';
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
      console.log('Vehicle.search called with params:', JSON.stringify(searchParams, null, 2));

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
          } else if (key === 'hours_min') {
            whereConditions.push('hours_used >= ?');
            queryParams.push(parseInt(value));
          } else if (key === 'hours_max') {
            whereConditions.push('hours_used <= ?');
            queryParams.push(parseInt(value));
          } else if (key === 'horsepower_min') {
            whereConditions.push('horsepower >= ?');
            queryParams.push(parseInt(value));
          } else if (key === 'horsepower_max') {
            whereConditions.push('horsepower <= ?');
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
          } else if (key === 'category') {
            if (value === 'others') {
              // Others: exclude trucks, commercial, and buses (include machinery, spares, trailers, etc.)
              whereConditions.push('category NOT IN (?, ?, ?)');
              queryParams.push('trucks', 'commercial', 'buses');
            } else {
              whereConditions.push(`${key} = ?`);
              queryParams.push(value);
            }
          } else if (key === 'listing_type' && value !== 'all') {
            // Handle listing type filter
            whereConditions.push('listing_type = ?');
            queryParams.push(value);
          } else if (key === 'condition_type' && value !== 'all') {
            // Handle condition type filter
            whereConditions.push('condition_type = ?');
            queryParams.push(value);
          } else if (key === 'condition_rating' && value !== 'all') {
            // Handle condition rating filter
            whereConditions.push('condition_rating = ?');
            queryParams.push(value);
          } else if (key === 'color' && value !== 'All Colors') {
            // Handle color filter
            whereConditions.push('color = ?');
            queryParams.push(value);
          } else if (key === 'engine_type' && value !== 'all') {
            // Handle engine type filter
            whereConditions.push('engine_type = ?');
            queryParams.push(value);
          } else if (key === 'transmission' && value !== 'all') {
            // Handle transmission filter
            whereConditions.push('transmission = ?');
            queryParams.push(value);
          } else if (key === 'fuel_type' && value !== 'all') {
            // Handle fuel type filter
            whereConditions.push('fuel_type = ?');
            queryParams.push(value);
          } else if (key === 'no_accidents' && value === 1) {
            // Handle boolean filter - only add when true
            whereConditions.push('no_accidents = 1');
          } else if (key === 'warranty' && value === 1) {
            // Handle boolean filter - only add when true
            whereConditions.push('warranty = 1');
          } else if (key === 'finance_available' && value === 1) {
            // Handle boolean filter - only add when true
            whereConditions.push('finance_available = 1');
          } else if (key === 'trade_in' && value === 1) {
            // Handle boolean filter - only add when true
            whereConditions.push('trade_in = 1');
          } else if (key === 'service_history' && value === 1) {
            // Handle boolean filter - only add when true
            whereConditions.push('service_history = 1');
          } else if (key === 'roadworthy' && value === 1) {
            // Handle boolean filter - only add when true
            whereConditions.push('roadworthy = 1');
          } else if (key === 'featured' && value === 1) {
            // Handle boolean filter - only add when true
            whereConditions.push('featured = 1');
          } else if (['region', 'city', 'model', 'variant'].includes(key)) {
            // Handle other standard string filters
            whereConditions.push(`${key} = ?`);
            queryParams.push(value);
          }
          // Note: Removed the generic else clause to prevent unhandled parameters from being processed
        }
      }

      if (whereConditions.length > 0) {
        const whereClause = whereConditions.join(' AND ');
        query += ` WHERE ${whereClause}`;
        countQuery += ` WHERE ${whereClause}`;
      }

      console.log('Generated SQL query:', query);
      console.log('Query parameters:', queryParams);

      // Add pagination
      const offset = (page - 1) * limit;
      query += ' ORDER BY created_at DESC LIMIT ? OFFSET ?';
      queryParams.push(parseInt(limit), parseInt(offset));

      // Execute queries
      const [rows] = await db.query(query, queryParams);
      const [countResult] = await db.query(countQuery, queryParams.slice(0, -2));

      console.log(`Vehicle.search found ${rows.length} vehicles out of ${countResult[0].total} total`);

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

  static async getFeatured(limit = 6, random = false, category = 'trucks') {
    try {
      let query = 'SELECT * FROM vehicles WHERE featured = 1 AND status = "available"';
      let queryParams = [];

      // Add category filter
      if (category && category !== 'others') {
        query += ' AND category = ?';
        queryParams.push(category);
      } else if (category === 'others') {
        // Others: exclude trucks, commercial, and buses (include machinery, spares, trailers, etc.)
        query += ' AND category NOT IN (?, ?, ?)';
        queryParams.push('trucks', 'commercial', 'buses');
      }

      if (random) {
        query += ' ORDER BY RAND()';
      } else {
        query += ' ORDER BY created_at DESC';
      }

      query += ' LIMIT ?';
      queryParams.push(parseInt(limit));

      const [rows] = await db.query(query, queryParams);
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

  static async getAllCategories() {
    try {
      const [rows] = await db.query(
        'SELECT DISTINCT category FROM vehicles WHERE category IS NOT NULL AND category != "" ORDER BY category ASC'
      );
      return rows.map(row => row.category);
    } catch (error) {
      throw error;
    }
  }
}

module.exports = Vehicle;