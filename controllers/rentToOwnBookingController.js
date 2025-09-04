const RentToOwnBooking = require('../models/RentToOwnBooking');
const Vehicle = require('../models/Vehicle');
const { validationResult } = require('express-validator');

// Get all rent-to-own bookings
exports.getAllBookings = async (req, res) => {
  try {
    const { 
      status, category, dealer_id, page = 1, limit = 10 
    } = req.query;

    const filters = {};
    if (status) filters.status = status;
    if (category) filters.category = category;
    if (dealer_id) filters.dealer_id = dealer_id;

    const result = await RentToOwnBooking.getAll(filters, page, limit);

    res.json(result);
  } catch (error) {
    console.error('Get all rent-to-own bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching rent-to-own bookings' });
  }
};

// Get rent-to-own booking by ID
exports.getBookingById = async (req, res) => {
  try {
    const { id } = req.params;
    
    const booking = await RentToOwnBooking.findById(id);
    if (!booking) {
      return res.status(404).json({ message: 'Rent-to-own booking not found' });
    }
    
    // Get vehicle details
    const vehicle = await Vehicle.findById(booking.vehicle_id);
    booking.vehicle = vehicle;
    
    res.json({ booking });
  } catch (error) {
    console.error('Get rent-to-own booking by ID error:', error);
    res.status(500).json({ message: 'Server error while fetching rent-to-own booking' });
  }
};

// Create new rent-to-own booking
exports.createBooking = async (req, res) => {
  try {
    console.log('Received rent-to-own booking request:', req.body);
    
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      console.log('Validation errors:', errors.array());
      return res.status(400).json({ errors: errors.array() });
    }

    const { vehicle_id } = req.body;
    console.log('Looking for vehicle with ID:', vehicle_id);
    
    // Check if vehicle exists
    const vehicle = await Vehicle.findById(vehicle_id);
    console.log('Found vehicle:', vehicle);
    if (!vehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    if (vehicle.status !== 'available') {
      console.log('Vehicle status is not available:', vehicle.status);
      return res.status(400).json({ message: 'Vehicle is not available for rent-to-own' });
    }
    
    // Check if vehicle is available for rent-to-own (no active bookings)
    console.log('Checking vehicle availability...');
    const isAvailable = await RentToOwnBooking.checkVehicleAvailability(vehicle_id);
    console.log('Vehicle availability result:', isAvailable);
    if (!isAvailable) {
      return res.status(400).json({ message: 'Vehicle is not available for rent-to-own' });
    }
    
    // Add created_at timestamp
    req.body.created_at = new Date();
    console.log('Creating booking with data:', req.body);
    
    // Create rent-to-own booking
    const booking = await RentToOwnBooking.create(req.body);
    console.log('Booking created successfully:', booking);
    
    res.status(201).json({
      message: 'Rent-to-own application submitted successfully',
      booking
    });
  } catch (error) {
    console.error('Create rent-to-own booking error:', error);
    console.error('Error stack:', error.stack);
    res.status(500).json({ message: 'Server error while creating rent-to-own booking', error: error.message });
  }
};

// Update rent-to-own booking
exports.updateBooking = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    
    // Check if booking exists
    const existingBooking = await RentToOwnBooking.findById(id);
    if (!existingBooking) {
      return res.status(404).json({ message: 'Rent-to-own booking not found' });
    }
    
    // Check authorization (dealers can only update their own vehicle bookings, admins can update any)
    if (req.user.user_type !== 'admin') {
      const vehicle = await Vehicle.findById(existingBooking.vehicle_id);
      if (vehicle.dealer_id !== req.user.user_id) {
        return res.status(403).json({ message: 'Not authorized to update this booking' });
      }
    }
    
    // Add updated_at timestamp
    req.body.updated_at = new Date();
    
    // Update booking
    const updated = await RentToOwnBooking.update(id, req.body);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update rent-to-own booking' });
    }
    
    // Get updated booking
    const updatedBooking = await RentToOwnBooking.findById(id);
    
    res.json({
      message: 'Rent-to-own booking updated successfully',
      booking: updatedBooking
    });
  } catch (error) {
    console.error('Update rent-to-own booking error:', error);
    res.status(500).json({ message: 'Server error while updating rent-to-own booking' });
  }
};

// Update booking status
exports.updateBookingStatus = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    const { status } = req.body;
    
    // Check if booking exists
    const existingBooking = await RentToOwnBooking.findById(id);
    if (!existingBooking) {
      return res.status(404).json({ message: 'Rent-to-own booking not found' });
    }
    
    // Check authorization
    if (req.user.user_type !== 'admin') {
      const vehicle = await Vehicle.findById(existingBooking.vehicle_id);
      if (vehicle.dealer_id !== req.user.user_id) {
        return res.status(403).json({ message: 'Not authorized to update this booking' });
      }
    }
    
    // Update status with timestamp
    const updated = await RentToOwnBooking.update(id, { 
      status, 
      updated_at: new Date() 
    });
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update booking status' });
    }
    
    // Get updated booking
    const updatedBooking = await RentToOwnBooking.findById(id);
    
    res.json({
      message: 'Booking status updated successfully',
      booking: updatedBooking
    });
  } catch (error) {
    console.error('Update booking status error:', error);
    res.status(500).json({ message: 'Server error while updating booking status' });
  }
};

// Delete rent-to-own booking
exports.deleteBooking = async (req, res) => {
  try {
    const { id } = req.params;
    
    // Check if booking exists
    const existingBooking = await RentToOwnBooking.findById(id);
    if (!existingBooking) {
      return res.status(404).json({ message: 'Rent-to-own booking not found' });
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
    const deleted = await RentToOwnBooking.delete(id);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete rent-to-own booking' });
    }
    
    res.json({ message: 'Rent-to-own booking deleted successfully' });
  } catch (error) {
    console.error('Delete rent-to-own booking error:', error);
    res.status(500).json({ message: 'Server error while deleting rent-to-own booking' });
  }
};

// Get bookings by status
exports.getBookingsByStatus = async (req, res) => {
  try {
    const { status } = req.params;
    const { page = 1, limit = 10 } = req.query;
    
    const result = await RentToOwnBooking.getByStatus(status, page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get bookings by status error:', error);
    res.status(500).json({ message: 'Server error while fetching bookings by status' });
  }
};

// Get bookings by vehicle
exports.getBookingsByVehicle = async (req, res) => {
  try {
    const { vehicleId } = req.params;
    
    const bookings = await RentToOwnBooking.getByVehicle(vehicleId);
    
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
    
    const bookings = await RentToOwnBooking.getByEmail(email);
    
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
    
    const result = await RentToOwnBooking.getByDealer(dealerId, page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get dealer bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching dealer bookings' });
  }
};

// Check vehicle availability
exports.checkVehicleAvailability = async (req, res) => {
  try {
    const { vehicleId } = req.params;
    
    const isAvailable = await RentToOwnBooking.checkVehicleAvailability(vehicleId);
    
    res.json({ available: isAvailable });
  } catch (error) {
    console.error('Check vehicle availability error:', error);
    res.status(500).json({ message: 'Server error while checking vehicle availability' });
  }
};

// Get active bookings
exports.getActiveBookings = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    
    const result = await RentToOwnBooking.getByStatus('active', page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get active bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching active bookings' });
  }
};

// Get pending bookings
exports.getPendingBookings = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    
    const result = await RentToOwnBooking.getByStatus('pending', page, limit);
    
    res.json(result);
  } catch (error) {
    console.error('Get pending bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching pending bookings' });
  }
};

// Get booking statistics
exports.getBookingStatistics = async (req, res) => {
  try {
    const statistics = await RentToOwnBooking.getStatistics();
    
    res.json({ statistics });
  } catch (error) {
    console.error('Get booking statistics error:', error);
    res.status(500).json({ message: 'Server error while fetching booking statistics' });
  }
};