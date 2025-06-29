const HireBooking = require('../models/HireBooking');
const Vehicle = require('../models/Vehicle');
const { validationResult } = require('express-validator');

// Get all hire bookings
exports.getAllBookings = async (req, res) => {
  try {
    const { 
      status, category, dealer_id, page = 1, limit = 10 
    } = req.query;

    const filters = {};
    if (status) filters.status = status;
    if (category) filters.category = category;
    if (dealer_id) filters.dealer_id = dealer_id;

    const result = await HireBooking.getAll(filters, page, limit);

    res.json(result);
  } catch (error) {
    console.error('Get all bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching hire bookings' });
  }
};

// Get hire booking by ID
exports.getBookingById = async (req, res) => {
  try {
    const { id } = req.params;
    
    const booking = await HireBooking.findById(id);
    if (!booking) {
      return res.status(404).json({ message: 'Hire booking not found' });
    }
    
    // Get vehicle details
    const vehicle = await Vehicle.findById(booking.vehicle_id);
    booking.vehicle = vehicle;
    
    res.json({ booking });
  } catch (error) {
    console.error('Get booking by ID error:', error);
    res.status(500).json({ message: 'Server error while fetching hire booking' });
  }
};

// Create new hire booking
exports.createBooking = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { vehicle_id, start_date, end_date } = req.body;
    
    // Check if vehicle exists
    const vehicle = await Vehicle.findById(vehicle_id);
    if (!vehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    if (vehicle.status !== 'available') {
      return res.status(400).json({ message: 'Vehicle is not available for hire' });
    }
    
    // Check vehicle availability for the requested dates
    const isAvailable = await HireBooking.checkVehicleAvailability(vehicle_id, start_date, end_date);
    if (!isAvailable) {
      return res.status(400).json({ message: 'Vehicle is not available for the selected dates' });
    }
    
    // Calculate total cost if daily_rate is provided
    if (req.body.daily_rate) {
      const startDateObj = new Date(start_date);
      const endDateObj = new Date(end_date);
      const days = Math.ceil((endDateObj - startDateObj) / (1000 * 60 * 60 * 24));
      req.body.total_cost = req.body.daily_rate * days;
    }
    
    // Create hire booking
    const booking = await HireBooking.create(req.body);
    
    res.status(201).json({
      message: 'Hire booking created successfully',
      booking
    });
  } catch (error) {
    console.error('Create booking error:', error);
    res.status(500).json({ message: 'Server error while creating hire booking' });
  }
};

// Update hire booking
exports.updateBooking = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    
    // Check if booking exists
    const existingBooking = await HireBooking.findById(id);
    if (!existingBooking) {
      return res.status(404).json({ message: 'Hire booking not found' });
    }
    
    // Check authorization (dealers can only update their own vehicle bookings, admins can update any)
    if (req.user.user_type !== 'admin') {
      const vehicle = await Vehicle.findById(existingBooking.vehicle_id);
      if (vehicle.dealer_id !== req.user.user_id) {
        return res.status(403).json({ message: 'Not authorized to update this booking' });
      }
    }
    
    // If updating dates, check availability
    if (req.body.start_date || req.body.end_date) {
      const startDate = req.body.start_date || existingBooking.start_date;
      const endDate = req.body.end_date || existingBooking.end_date;
      
      // Check availability (excluding current booking)
      const isAvailable = await HireBooking.checkVehicleAvailability(
        existingBooking.vehicle_id, 
        startDate, 
        endDate
      );
      if (!isAvailable) {
        return res.status(400).json({ message: 'Vehicle is not available for the selected dates' });
      }
      
      // Recalculate total cost if daily_rate exists
      if (existingBooking.daily_rate || req.body.daily_rate) {
        const dailyRate = req.body.daily_rate || existingBooking.daily_rate;
        const startDateObj = new Date(startDate);
        const endDateObj = new Date(endDate);
        const days = Math.ceil((endDateObj - startDateObj) / (1000 * 60 * 60 * 24));
        req.body.total_cost = dailyRate * days;
      }
    }
    
    // Update booking
    const updated = await HireBooking.update(id, req.body);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update hire booking' });
    }
    
    // Get updated booking
    const updatedBooking = await HireBooking.findById(id);
    
    res.json({
      message: 'Hire booking updated successfully',
      booking: updatedBooking
    });
  } catch (error) {
    console.error('Update booking error:', error);
    res.status(500).json({ message: 'Server error while updating hire booking' });
  }
};

// Delete hire booking
exports.deleteBooking = async (req, res) => {
  try {
    const { id } = req.params;
    
    // Check if booking exists
    const existingBooking = await HireBooking.findById(id);
    if (!existingBooking) {
      return res.status(404).json({ message: 'Hire booking not found' });
    }
    
    // Check authorization
    if (req.user.user_type !== 'admin') {
      const vehicle = await Vehicle.findById(existingBooking.vehicle_id);
      if (vehicle.dealer_id !== req.user.user_id) {
        return res.status(403).json({ message: 'Not authorized to delete this booking' });
      }
    }
    
    // Don't allow deletion of active bookings
    if (existingBooking.status === 'active') {
      return res.status(400).json({ message: 'Cannot delete active booking' });
    }
    
    // Delete booking
    const deleted = await HireBooking.delete(id);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete hire booking' });
    }
    
    res.json({ message: 'Hire booking deleted successfully' });
  } catch (error) {
    console.error('Delete booking error:', error);
    res.status(500).json({ message: 'Server error while deleting hire booking' });
  }
};

// Update booking status
exports.updateBookingStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;
    
    // Validate status
    if (!['pending', 'confirmed', 'active', 'completed', 'cancelled'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status value' });
    }
    
    // Check if booking exists
    const existingBooking = await HireBooking.findById(id);
    if (!existingBooking) {
      return res.status(404).json({ message: 'Hire booking not found' });
    }
    
    // Check authorization
    if (req.user.user_type !== 'admin') {
      const vehicle = await Vehicle.findById(existingBooking.vehicle_id);
      if (vehicle.dealer_id !== req.user.user_id) {
        return res.status(403).json({ message: 'Not authorized to update this booking status' });
      }
    }
    
    // Update status
    const updated = await HireBooking.updateStatus(id, status);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update booking status' });
    }
    
    res.json({ message: `Booking status updated to ${status}` });
  } catch (error) {
    console.error('Update booking status error:', error);
    res.status(500).json({ message: 'Server error while updating booking status' });
  }
};

// Get bookings by status
exports.getBookingsByStatus = async (req, res) => {
  try {
    const { status } = req.params;
    const { page = 1, limit = 10 } = req.query;
    
    // Validate status
    if (!['pending', 'confirmed', 'active', 'completed', 'cancelled'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status value' });
    }
    
    const result = await HireBooking.getByStatus(status, page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get bookings by status error:', error);
    res.status(500).json({ message: 'Server error while fetching bookings by status' });
  }
};

// Get active bookings
exports.getActiveBookings = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    
    const result = await HireBooking.getActiveBookings(page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get active bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching active bookings' });
  }
};

// Get upcoming bookings
exports.getUpcomingBookings = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    
    const result = await HireBooking.getUpcomingBookings(page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get upcoming bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching upcoming bookings' });
  }
};

// Get bookings by vehicle
exports.getBookingsByVehicle = async (req, res) => {
  try {
    const { vehicleId } = req.params;
    
    // Check if vehicle exists
    const vehicle = await Vehicle.findById(vehicleId);
    if (!vehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    const bookings = await HireBooking.getByVehicle(vehicleId);
    
    res.json({ bookings });
  } catch (error) {
    console.error('Get bookings by vehicle error:', error);
    res.status(500).json({ message: 'Server error while fetching bookings by vehicle' });
  }
};

// Get bookings by email
exports.getBookingsByEmail = async (req, res) => {
  try {
    const { email } = req.params;
    
    const bookings = await HireBooking.getByEmail(email);
    
    res.json({ bookings });
  } catch (error) {
    console.error('Get bookings by email error:', error);
    res.status(500).json({ message: 'Server error while fetching bookings by email' });
  }
};

// Get dealer bookings
exports.getDealerBookings = async (req, res) => {
  try {
    const { dealerId } = req.params;
    const { page = 1, limit = 10 } = req.query;
    
    const result = await HireBooking.getByDealer(dealerId, page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get dealer bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching dealer bookings' });
  }
};

// Get hire booking statistics
exports.getBookingStatistics = async (req, res) => {
  try {
    const stats = await HireBooking.getStatistics();
    res.json({ stats });
  } catch (error) {
    console.error('Get booking statistics error:', error);
    res.status(500).json({ message: 'Server error while fetching booking statistics' });
  }
};

// Check vehicle availability
exports.checkVehicleAvailability = async (req, res) => {
  try {
    const { vehicleId } = req.params;
    const { start_date, end_date } = req.query;
    
    if (!start_date || !end_date) {
      return res.status(400).json({ message: 'Start date and end date are required' });
    }
    
    // Check if vehicle exists
    const vehicle = await Vehicle.findById(vehicleId);
    if (!vehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    const isAvailable = await HireBooking.checkVehicleAvailability(vehicleId, start_date, end_date);
    
    res.json({ available: isAvailable });
  } catch (error) {
    console.error('Check vehicle availability error:', error);
    res.status(500).json({ message: 'Server error while checking vehicle availability' });
  }
};
