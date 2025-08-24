const ContactForm = require('../models/ContactForm');
const { validationResult } = require('express-validator');

// Create a new form submission (contact or finance)
const createContactForm = async (req, res) => {
    try {
        // Check for validation errors
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Validation errors',
                errors: errors.array()
            });
        }

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
        } = req.body;

        // Common validation
        if (!email) {
            return res.status(400).json({
                success: false,
                message: 'Email is required'
            });
        }

        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            return res.status(400).json({
                success: false,
                message: 'Please provide a valid email address'
            });
        }

        // Form type specific validation
        if (form_type === 'contact') {
            if (!name || !message) {
                return res.status(400).json({
                    success: false,
                    message: 'Name and message are required for contact forms'
                });
            }
        } else if (form_type === 'finance') {
            if (!first_name || !last_name || !id_number || !monthly_income) {
                return res.status(400).json({
                    success: false,
                    message: 'First name, last name, ID number, and monthly income are required for finance applications'
                });
            }

            // Validate monthly income is a positive number
            if (isNaN(monthly_income) || parseFloat(monthly_income) <= 0) {
                return res.status(400).json({
                    success: false,
                    message: 'Monthly income must be a positive number'
                });
            }
        }

        const formData = {
            form_type,
            first_name: first_name ? first_name.trim() : null,
            last_name: last_name ? last_name.trim() : null,
            name: name ? name.trim() : (first_name && last_name ? `${first_name.trim()} ${last_name.trim()}` : null),
            email: email.trim().toLowerCase(),
            phone: phone ? phone.trim() : null,
            subject: subject ? subject.trim() : null,
            message: message ? message.trim() : null,
            id_number: id_number ? id_number.trim() : null,
            monthly_income: monthly_income ? parseFloat(monthly_income) : null,
            employment_status: employment_status ? employment_status.trim() : null,
            employer_name: employer_name ? employer_name.trim() : null,
            years_employed: years_employed ? parseFloat(years_employed) : null,
            deposit_amount: deposit_amount ? parseFloat(deposit_amount) : null,
            loan_term: loan_term ? parseInt(loan_term) : null,
            vehicle_id: vehicle_id ? parseInt(vehicle_id) : null,
            additional_info: additional_info ? additional_info.trim() : null,
            dealership_id: dealership_id || null,
            dealership_name: dealership_name ? dealership_name.trim() : null
        };

        const newForm = await ContactForm.create(formData);

        res.status(201).json({
            success: true,
            message: `${form_type === 'finance' ? 'Finance application' : 'Contact form'} submitted successfully`,
            data: newForm
        });
    } catch (error) {
        console.error('Error creating form submission:', error);
        res.status(500).json({
            success: false,
            message: 'Internal server error',
            error: error.message
        });
    }
};

// Get all forms with pagination and filtering
const getAllContactForms = async (req, res) => {
    try {
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const status = req.query.status || null;
        const formType = req.query.form_type || null;

        const result = await ContactForm.getAll(page, limit, status, formType);

        res.json({
            success: true,
            data: result.forms,
            pagination: {
                currentPage: result.currentPage,
                totalPages: result.totalPages,
                totalItems: result.totalItems,
                itemsPerPage: result.itemsPerPage
            }
        });
    } catch (error) {
        console.error('Error fetching forms:', error);
        res.status(500).json({
            success: false,
            message: 'Internal server error'
        });
    }
};

// Get finance applications specifically
const getFinanceApplications = async (req, res) => {
    try {
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const status = req.query.status || null;

        const result = await ContactForm.getFinanceApplications(page, limit, status);

        res.json({
            success: true,
            data: result.forms,
            pagination: {
                currentPage: result.currentPage,
                totalPages: result.totalPages,
                totalItems: result.totalItems,
                itemsPerPage: result.itemsPerPage
            }
        });
    } catch (error) {
        console.error('Error fetching finance applications:', error);
        res.status(500).json({
            success: false,
            message: 'Internal server error'
        });
    }
};

// Get contact forms specifically
const getContactFormsOnly = async (req, res) => {
    try {
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const status = req.query.status || null;

        const result = await ContactForm.getContactForms(page, limit, status);

        res.json({
            success: true,
            data: result.forms,
            pagination: {
                currentPage: result.currentPage,
                totalPages: result.totalPages,
                totalItems: result.totalItems,
                itemsPerPage: result.itemsPerPage
            }
        });
    } catch (error) {
        console.error('Error fetching contact forms:', error);
        res.status(500).json({
            success: false,
            message: 'Internal server error'
        });
    }
};

// Get contact forms by dealership (dealer only)
const getContactFormsByDealership = async (req, res) => {
    try {
        const dealershipId = req.params.dealershipId || req.user.id;
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;

        // Check if user is authorized to view these forms
        if (req.user.role !== 'admin' && req.user.id !== parseInt(dealershipId)) {
            return res.status(403).json({
                success: false,
                message: 'Access denied. You can only view your own contact forms.'
            });
        }

        const result = await ContactForm.getByDealership(dealershipId, page, limit);

        res.status(200).json({
            success: true,
            message: 'Dealership contact forms retrieved successfully',
            data: result
        });
    } catch (error) {
        console.error('Error fetching dealership contact forms:', error);
        res.status(500).json({
            success: false,
            message: 'Internal server error',
            error: error.message
        });
    }
};

// Get a single contact form by ID
const getContactFormById = async (req, res) => {
    try {
        const { id } = req.params;

        const form = await ContactForm.getById(id);

        if (!form) {
            return res.status(404).json({
                success: false,
                message: 'Contact form not found'
            });
        }

        // Check if user is authorized to view this form
        if (req.user.role !== 'admin' && req.user.id !== form.dealership_id) {
            return res.status(403).json({
                success: false,
                message: 'Access denied. You can only view your own contact forms.'
            });
        }

        res.status(200).json({
            success: true,
            message: 'Contact form retrieved successfully',
            data: form
        });
    } catch (error) {
        console.error('Error fetching contact form:', error);
        res.status(500).json({
            success: false,
            message: 'Internal server error',
            error: error.message
        });
    }
};

// Update contact form status
const updateContactFormStatus = async (req, res) => {
    try {
        const { id } = req.params;
        const { status } = req.body;

        if (!status) {
            return res.status(400).json({
                success: false,
                message: 'Status is required'
            });
        }

        const validStatuses = ['new', 'read', 'replied', 'closed'];
        if (!validStatuses.includes(status)) {
            return res.status(400).json({
                success: false,
                message: 'Invalid status. Valid statuses are: ' + validStatuses.join(', ')
            });
        }

        // Check if form exists and user has permission
        const existingForm = await ContactForm.getById(id);
        if (!existingForm) {
            return res.status(404).json({
                success: false,
                message: 'Contact form not found'
            });
        }

        if (req.user.role !== 'admin' && req.user.id !== existingForm.dealership_id) {
            return res.status(403).json({
                success: false,
                message: 'Access denied. You can only update your own contact forms.'
            });
        }

        const updatedForm = await ContactForm.updateStatus(id, status);

        res.status(200).json({
            success: true,
            message: 'Contact form status updated successfully',
            data: updatedForm
        });
    } catch (error) {
        console.error('Error updating contact form status:', error);
        res.status(500).json({
            success: false,
            message: 'Internal server error',
            error: error.message
        });
    }
};

// Delete a contact form (admin only)
const deleteContactForm = async (req, res) => {
    try {
        const { id } = req.params;

        // Check if user is admin
        if (req.user.role !== 'admin') {
            return res.status(403).json({
                success: false,
                message: 'Access denied. Only administrators can delete contact forms.'
            });
        }

        const deleted = await ContactForm.delete(id);

        if (!deleted) {
            return res.status(404).json({
                success: false,
                message: 'Contact form not found'
            });
        }

        res.status(200).json({
            success: true,
            message: 'Contact form deleted successfully'
        });
    } catch (error) {
        console.error('Error deleting contact form:', error);
        res.status(500).json({
            success: false,
            message: 'Internal server error',
            error: error.message
        });
    }
};

// Get contact form statistics (admin only)
const getContactFormStatistics = async (req, res) => {
    try {
        // Check if user is admin
        if (req.user.role !== 'admin') {
            return res.status(403).json({
                success: false,
                message: 'Access denied. Only administrators can view statistics.'
            });
        }

        const stats = await ContactForm.getStatistics();

        res.status(200).json({
            success: true,
            message: 'Contact form statistics retrieved successfully',
            data: stats
        });
    } catch (error) {
        console.error('Error fetching contact form statistics:', error);
        res.status(500).json({
            success: false,
            message: 'Internal server error',
            error: error.message
        });
    }
};

module.exports = {
    createContactForm,
    getAllContactForms,
    getFinanceApplications,
    getContactFormsOnly,
    getContactFormsByDealership,
    getContactFormById,
    updateContactFormStatus,
    deleteContactForm,
    getContactFormStatistics
};