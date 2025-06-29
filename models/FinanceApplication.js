const db = require('../config/db');

class FinanceApplication {
  static async findById(id) {
    try {
      const [rows] = await db.query('SELECT * FROM finance_applications WHERE application_id = ?', [id]);
      return rows[0];
    } catch (error) {
      throw error;
    }
  }

  static async create(applicationData) {
    try {
      const columns = Object.keys(applicationData).join(', ');
      const placeholders = Object.keys(applicationData).map(() => '?').join(', ');
      const values = Object.values(applicationData);
      
      const [result] = await db.query(
        `INSERT INTO finance_applications (${columns}) VALUES (${placeholders})`,
        values
      );
      
      return { application_id: result.insertId, ...applicationData };
    } catch (error) {
      throw error;
    }
  }

  static async update(id, applicationData) {
    try {
      const entries = Object.entries(applicationData);
      const setClause = entries.map(([key]) => `${key} = ?`).join(', ');
      const values = [...entries.map(([_, value]) => value), id];
      
      const [result] = await db.query(
        `UPDATE finance_applications SET ${setClause} WHERE application_id = ?`,
        values
      );
      
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async delete(id) {
    try {
      const [result] = await db.query('DELETE FROM finance_applications WHERE application_id = ?', [id]);
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getAll(filters = {}, page = 1, limit = 10) {
    try {
      let query = `
        SELECT fa.*, v.make, v.model, v.year, v.price as vehicle_price
        FROM finance_applications fa
        LEFT JOIN vehicles v ON fa.vehicle_id = v.vehicle_id
      `;
      let countQuery = 'SELECT COUNT(*) as total FROM finance_applications fa';
      let queryParams = [];
      
      // Build WHERE clause based on filters
      if (Object.keys(filters).length > 0) {
        const whereConditions = [];
        
        for (const [key, value] of Object.entries(filters)) {
          if (value !== undefined && value !== null && value !== '') {
            whereConditions.push(`fa.${key} = ?`);
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
      query += ' ORDER BY fa.created_at DESC LIMIT ? OFFSET ?';
      queryParams.push(parseInt(limit), parseInt(offset));
      
      // Execute queries
      const [rows] = await db.query(query, queryParams);
      const [countResult] = await db.query(countQuery, queryParams.slice(0, -2));
      
      return {
        applications: rows,
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

  static async getByStatus(status, page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      
      const [rows] = await db.query(
        `SELECT fa.*, v.make, v.model, v.year, v.price as vehicle_price
         FROM finance_applications fa
         LEFT JOIN vehicles v ON fa.vehicle_id = v.vehicle_id
         WHERE fa.status = ?
         ORDER BY fa.created_at DESC LIMIT ? OFFSET ?`,
        [status, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        'SELECT COUNT(*) as total FROM finance_applications WHERE status = ?',
        [status]
      );
      
      return {
        applications: rows,
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

  static async getByEmail(email) {
    try {
      const [rows] = await db.query(
        `SELECT fa.*, v.make, v.model, v.year, v.price as vehicle_price
         FROM finance_applications fa
         LEFT JOIN vehicles v ON fa.vehicle_id = v.vehicle_id
         WHERE fa.email = ?
         ORDER BY fa.created_at DESC`,
        [email]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getByVehicle(vehicleId) {
    try {
      const [rows] = await db.query(
        'SELECT * FROM finance_applications WHERE vehicle_id = ? ORDER BY created_at DESC',
        [vehicleId]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async updateStatus(id, status) {
    try {
      const [result] = await db.query(
        'UPDATE finance_applications SET status = ? WHERE application_id = ?',
        [status, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      throw error;
    }
  }

  static async getStatistics() {
    try {
      const [totalApplications] = await db.query('SELECT COUNT(*) as total FROM finance_applications');
      const [pendingApplications] = await db.query('SELECT COUNT(*) as total FROM finance_applications WHERE status = "pending"');
      const [approvedApplications] = await db.query('SELECT COUNT(*) as total FROM finance_applications WHERE status = "approved"');
      const [rejectedApplications] = await db.query('SELECT COUNT(*) as total FROM finance_applications WHERE status = "rejected"');
      const [avgLoanAmount] = await db.query('SELECT AVG(loan_amount) as average FROM finance_applications WHERE loan_amount IS NOT NULL');
      const [totalLoanAmount] = await db.query('SELECT SUM(loan_amount) as total FROM finance_applications WHERE status = "approved"');
      
      return {
        total_applications: totalApplications[0].total,
        pending_applications: pendingApplications[0].total,
        approved_applications: approvedApplications[0].total,
        rejected_applications: rejectedApplications[0].total,
        average_loan_amount: parseFloat(avgLoanAmount[0].average || 0).toFixed(2),
        total_approved_loan_amount: parseFloat(totalLoanAmount[0].total || 0).toFixed(2)
      };
    } catch (error) {
      throw error;
    }
  }

  static async getRecentApplications(limit = 10) {
    try {
      const [rows] = await db.query(
        `SELECT fa.*, v.make, v.model, v.year
         FROM finance_applications fa
         LEFT JOIN vehicles v ON fa.vehicle_id = v.vehicle_id
         ORDER BY fa.created_at DESC
         LIMIT ?`,
        [parseInt(limit)]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getApplicationsByDateRange(startDate, endDate) {
    try {
      const [rows] = await db.query(
        `SELECT fa.*, v.make, v.model, v.year
         FROM finance_applications fa
         LEFT JOIN vehicles v ON fa.vehicle_id = v.vehicle_id
         WHERE fa.created_at BETWEEN ? AND ?
         ORDER BY fa.created_at DESC`,
        [startDate, endDate]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getApplicationsByEmploymentStatus(employmentStatus) {
    try {
      const [rows] = await db.query(
        `SELECT fa.*, v.make, v.model, v.year
         FROM finance_applications fa
         LEFT JOIN vehicles v ON fa.vehicle_id = v.vehicle_id
         WHERE fa.employment_status = ?
         ORDER BY fa.created_at DESC`,
        [employmentStatus]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async getApplicationsByCreditScore(creditScoreRange) {
    try {
      const [rows] = await db.query(
        `SELECT fa.*, v.make, v.model, v.year
         FROM finance_applications fa
         LEFT JOIN vehicles v ON fa.vehicle_id = v.vehicle_id
         WHERE fa.credit_score_range = ?
         ORDER BY fa.created_at DESC`,
        [creditScoreRange]
      );
      return rows;
    } catch (error) {
      throw error;
    }
  }

  static async searchApplications(searchTerm, page = 1, limit = 10) {
    try {
      const offset = (page - 1) * limit;
      const searchPattern = `%${searchTerm}%`;
      
      const [rows] = await db.query(
        `SELECT fa.*, v.make, v.model, v.year
         FROM finance_applications fa
         LEFT JOIN vehicles v ON fa.vehicle_id = v.vehicle_id
         WHERE fa.full_name LIKE ? OR fa.email LIKE ? OR fa.phone LIKE ?
         ORDER BY fa.created_at DESC
         LIMIT ? OFFSET ?`,
        [searchPattern, searchPattern, searchPattern, parseInt(limit), parseInt(offset)]
      );
      
      const [countResult] = await db.query(
        `SELECT COUNT(*) as total
         FROM finance_applications fa
         WHERE fa.full_name LIKE ? OR fa.email LIKE ? OR fa.phone LIKE ?`,
        [searchPattern, searchPattern, searchPattern]
      );
      
      return {
        applications: rows,
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
}

module.exports = FinanceApplication;
