const FinanceApplication = require('../models/FinanceApplication');
const Vehicle = require('../models/Vehicle');
const { validationResult } = require('express-validator');

// Get all finance applications (admin only)
exports.getAllApplications = async (req, res) => {
  try {
    const { 
      status, employment_status, credit_score_range, search,
      page = 1, limit = 10 
    } = req.query;

    let result;

    if (search) {
      result = await FinanceApplication.searchApplications(search, page, limit);
    } else {
      const filters = {};
      if (status) filters.status = status;
      if (employment_status) filters.employment_status = employment_status;
      if (credit_score_range) filters.credit_score_range = credit_score_range;

      result = await FinanceApplication.getAll(filters, page, limit);
    }

    res.json(result);
  } catch (error) {
    console.error('Get all applications error:', error);
    res.status(500).json({ message: 'Server error while fetching finance applications' });
  }
};

// Get finance application by ID
exports.getApplicationById = async (req, res) => {
  try {
    const { id } = req.params;
    
    const application = await FinanceApplication.findById(id);
    if (!application) {
      return res.status(404).json({ message: 'Finance application not found' });
    }
    
    // Get vehicle details if vehicle_id exists
    if (application.vehicle_id) {
      const vehicle = await Vehicle.findById(application.vehicle_id);
      application.vehicle = vehicle;
    }
    
    res.json({ application });
  } catch (error) {
    console.error('Get application by ID error:', error);
    res.status(500).json({ message: 'Server error while fetching finance application' });
  }
};

// Create new finance application
exports.createApplication = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { vehicle_id } = req.body;
    
    // Check if vehicle exists (if vehicle_id is provided)
    if (vehicle_id) {
      const vehicle = await Vehicle.findById(vehicle_id);
      if (!vehicle) {
        return res.status(404).json({ message: 'Vehicle not found' });
      }
      
      if (vehicle.status !== 'available') {
        return res.status(400).json({ message: 'Vehicle is not available for finance' });
      }
    }
    
    // Create finance application
    const application = await FinanceApplication.create(req.body);
    
    res.status(201).json({
      message: 'Finance application submitted successfully',
      application
    });
  } catch (error) {
    console.error('Create application error:', error);
    res.status(500).json({ message: 'Server error while creating finance application' });
  }
};

// Update finance application (admin only)
exports.updateApplication = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    
    // Check if application exists
    const existingApplication = await FinanceApplication.findById(id);
    if (!existingApplication) {
      return res.status(404).json({ message: 'Finance application not found' });
    }
    
    // Update application
    const updated = await FinanceApplication.update(id, req.body);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update finance application' });
    }
    
    // Get updated application
    const updatedApplication = await FinanceApplication.findById(id);
    
    res.json({
      message: 'Finance application updated successfully',
      application: updatedApplication
    });
  } catch (error) {
    console.error('Update application error:', error);
    res.status(500).json({ message: 'Server error while updating finance application' });
  }
};

// Delete finance application (admin only)
exports.deleteApplication = async (req, res) => {
  try {
    const { id } = req.params;
    
    // Check if application exists
    const existingApplication = await FinanceApplication.findById(id);
    if (!existingApplication) {
      return res.status(404).json({ message: 'Finance application not found' });
    }
    
    // Delete application
    const deleted = await FinanceApplication.delete(id);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete finance application' });
    }
    
    res.json({ message: 'Finance application deleted successfully' });
  } catch (error) {
    console.error('Delete application error:', error);
    res.status(500).json({ message: 'Server error while deleting finance application' });
  }
};

// Update application status (admin only)
exports.updateApplicationStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;
    
    // Validate status
    if (!['pending', 'approved', 'rejected'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status value' });
    }
    
    // Check if application exists
    const existingApplication = await FinanceApplication.findById(id);
    if (!existingApplication) {
      return res.status(404).json({ message: 'Finance application not found' });
    }
    
    // Update status
    const updated = await FinanceApplication.updateStatus(id, status);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update application status' });
    }
    
    res.json({ message: `Finance application status updated to ${status}` });
  } catch (error) {
    console.error('Update application status error:', error);
    res.status(500).json({ message: 'Server error while updating application status' });
  }
};

// Get applications by status
exports.getApplicationsByStatus = async (req, res) => {
  try {
    const { status } = req.params;
    const { page = 1, limit = 10 } = req.query;
    
    // Validate status
    if (!['pending', 'approved', 'rejected'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status value' });
    }
    
    const result = await FinanceApplication.getByStatus(status, page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get applications by status error:', error);
    res.status(500).json({ message: 'Server error while fetching applications by status' });
  }
};

// Get applications by email
exports.getApplicationsByEmail = async (req, res) => {
  try {
    const { email } = req.params;
    
    const applications = await FinanceApplication.getByEmail(email);
    
    res.json({ applications });
  } catch (error) {
    console.error('Get applications by email error:', error);
    res.status(500).json({ message: 'Server error while fetching applications by email' });
  }
};

// Get applications for a specific vehicle
exports.getApplicationsByVehicle = async (req, res) => {
  try {
    const { vehicleId } = req.params;
    
    // Check if vehicle exists
    const vehicle = await Vehicle.findById(vehicleId);
    if (!vehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    const applications = await FinanceApplication.getByVehicle(vehicleId);
    
    res.json({ applications });
  } catch (error) {
    console.error('Get applications by vehicle error:', error);
    res.status(500).json({ message: 'Server error while fetching applications by vehicle' });
  }
};

// Get finance application statistics (admin only)
exports.getApplicationStatistics = async (req, res) => {
  try {
    const stats = await FinanceApplication.getStatistics();
    res.json({ stats });
  } catch (error) {
    console.error('Get application statistics error:', error);
    res.status(500).json({ message: 'Server error while fetching application statistics' });
  }
};

// Get recent applications (admin only)
exports.getRecentApplications = async (req, res) => {
  try {
    const { limit = 10 } = req.query;
    
    const applications = await FinanceApplication.getRecentApplications(limit);
    
    res.json({ applications });
  } catch (error) {
    console.error('Get recent applications error:', error);
    res.status(500).json({ message: 'Server error while fetching recent applications' });
  }
};

// Get applications by date range (admin only)
exports.getApplicationsByDateRange = async (req, res) => {
  try {
    const { start_date, end_date } = req.query;
    
    if (!start_date || !end_date) {
      return res.status(400).json({ message: 'Start date and end date are required' });
    }
    
    const applications = await FinanceApplication.getApplicationsByDateRange(start_date, end_date);
    
    res.json({ applications });
  } catch (error) {
    console.error('Get applications by date range error:', error);
    res.status(500).json({ message: 'Server error while fetching applications by date range' });
  }
};

// Get applications by employment status (admin only)
exports.getApplicationsByEmploymentStatus = async (req, res) => {
  try {
    const { employmentStatus } = req.params;
    
    const applications = await FinanceApplication.getApplicationsByEmploymentStatus(employmentStatus);
    
    res.json({ applications });
  } catch (error) {
    console.error('Get applications by employment status error:', error);
    res.status(500).json({ message: 'Server error while fetching applications by employment status' });
  }
};

// Get applications by credit score range (admin only)
exports.getApplicationsByCreditScore = async (req, res) => {
  try {
    const { creditScoreRange } = req.params;
    
    const applications = await FinanceApplication.getApplicationsByCreditScore(creditScoreRange);
    
    res.json({ applications });
  } catch (error) {
    console.error('Get applications by credit score error:', error);
    res.status(500).json({ message: 'Server error while fetching applications by credit score' });
  }
};
