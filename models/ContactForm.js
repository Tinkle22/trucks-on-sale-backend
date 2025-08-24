const db = require('../config/db');

class ContactForm {
    constructor(data) {
        this.name = data.name;
        this.email = data.email;
        this.phone = data.phone;
        this.subject = data.subject;
        this.message = data.message;
        this.dealership_id = data.dealership_id;
        this.dealership_name = data.dealership_name;
        this.status = data.status || 'new';
    }

    // Create a new form submission (contact or finance)
    static async create(formData) {
        const {
            form_type = 'contact',
            first_name,
            last_name,
            name,
            email,
            phone,
            subject,
            message,
            id_number,
            monthly_income,
            employment_status,
            employer_name,
            years_employed,
            deposit_amount,
            loan_term,
            vehicle_id,
            additional_info,
            dealership_id,
            dealership_name
        } = formData;

        const query = `
            INSERT INTO forms (
                form_type, first_name, last_name, name, email, phone, subject, message,
                id_number, monthly_income, employment_status, employer_name, years_employed,
                deposit_amount, loan_term, vehicle_id, additional_info, dealership_id, dealership_name
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;

        try {
            const [result] = await db.execute(query, [
                form_type,
                first_name,
                last_name,
                name,
                email,
                phone,
                subject,
                message,
                id_number,
                monthly_income,
                employment_status,
                employer_name,
                years_employed,
                deposit_amount,
                loan_term,
                vehicle_id,
                additional_info,
                dealership_id,
                dealership_name
            ]);

            return {
                id: result.insertId,
                ...formData,
                status: 'new',
                created_at: new Date()
            };
        } catch (error) {
            console.error('Error creating form submission:', error);
            throw new Error('Failed to create form submission');
        }
    }

    // Get all forms with pagination and optional filtering by type and status
    static async getAll(page = 1, limit = 10, status = null, formType = null) {
        try {
            const offset = (page - 1) * limit;
            let query = 'SELECT * FROM forms';
            let countQuery = 'SELECT COUNT(*) as total FROM forms';
            const values = [];
            const countValues = [];
            const conditions = [];

            if (status) {
                conditions.push('status = ?');
                values.push(status);
                countValues.push(status);
            }

            if (formType) {
                conditions.push('form_type = ?');
                values.push(formType);
                countValues.push(formType);
            }

            if (conditions.length > 0) {
                const whereClause = ' WHERE ' + conditions.join(' AND ');
                query += whereClause;
                countQuery += whereClause;
            }

            query += ' ORDER BY created_at DESC LIMIT ? OFFSET ?';
            values.push(limit, offset);

            const [forms] = await db.execute(query, values);
            const [countResult] = await db.execute(countQuery, countValues);
            
            return {
                forms,
                total: countResult[0].total,
                page,
                limit,
                totalPages: Math.ceil(countResult[0].total / limit)
            };
        } catch (error) {
            throw new Error(`Error fetching forms: ${error.message}`);
        }
    }

    // Get all finance applications specifically
    static async getFinanceApplications(page = 1, limit = 10, status = null) {
        return this.getAll(page, limit, status, 'finance');
    }

    // Get all contact forms specifically
    static async getContactForms(page = 1, limit = 10, status = null) {
        return this.getAll(page, limit, status, 'contact');
    }

    // Get contact forms by dealership
    static async getByDealership(dealershipId, page = 1, limit = 10) {
        try {
            const offset = (page - 1) * limit;
            const query = `
                SELECT * FROM forms 
                WHERE dealership_id = ? 
                ORDER BY created_at DESC 
                LIMIT ? OFFSET ?
            `;
            
            const countQuery = 'SELECT COUNT(*) as total FROM forms WHERE dealership_id = ?';
            
            const [forms] = await db.execute(query, [dealershipId, limit, offset]);
            const [countResult] = await db.execute(countQuery, [dealershipId]);
            
            return {
                forms,
                total: countResult[0].total,
                page,
                limit,
                totalPages: Math.ceil(countResult[0].total / limit)
            };
        } catch (error) {
            throw new Error(`Error fetching dealership contact forms: ${error.message}`);
        }
    }

    // Get a single contact form by ID
    static async getById(id) {
        try {
            const query = 'SELECT * FROM forms WHERE id = ?';
            const [forms] = await db.execute(query, [id]);
            
            if (forms.length === 0) {
                return null;
            }
            
            return forms[0];
        } catch (error) {
            throw new Error(`Error fetching contact form: ${error.message}`);
        }
    }

    // Update contact form status
    static async updateStatus(id, status) {
        try {
            const validStatuses = ['new', 'read', 'replied', 'closed'];
            if (!validStatuses.includes(status)) {
                throw new Error('Invalid status');
            }

            const query = 'UPDATE forms SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?';
            const [result] = await db.execute(query, [status, id]);
            
            if (result.affectedRows === 0) {
                return null;
            }
            
            return await this.getById(id);
        } catch (error) {
            throw new Error(`Error updating contact form status: ${error.message}`);
        }
    }

    // Delete a contact form
    static async delete(id) {
        try {
            const query = 'DELETE FROM forms WHERE id = ?';
            const [result] = await db.execute(query, [id]);
            
            return result.affectedRows > 0;
        } catch (error) {
            throw new Error(`Error deleting contact form: ${error.message}`);
        }
    }

    // Get contact form statistics
    static async getStatistics() {
        try {
            const query = `
                SELECT 
                    COUNT(*) as total,
                    SUM(CASE WHEN status = 'new' THEN 1 ELSE 0 END) as new_forms,
                    SUM(CASE WHEN status = 'read' THEN 1 ELSE 0 END) as read_forms,
                    SUM(CASE WHEN status = 'replied' THEN 1 ELSE 0 END) as replied_forms,
                    SUM(CASE WHEN status = 'closed' THEN 1 ELSE 0 END) as closed_forms,
                    COUNT(DISTINCT dealership_id) as unique_dealerships
                FROM forms
            `;
            
            const [stats] = await db.execute(query);
            return stats[0];
        } catch (error) {
            throw new Error(`Error fetching contact form statistics: ${error.message}`);
        }
    }
}

module.exports = ContactForm;