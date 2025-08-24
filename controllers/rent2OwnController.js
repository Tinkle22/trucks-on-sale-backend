const Rent2Own = require('../models/Rent2Own');
const Vehicle = require('../models/Vehicle');
const { validationResult } = require('express-validator');

// Get all rent-to-own bookings
exports.getAllBookings = async (req, res) => {
  try {
    const { 
      status, customer_email, vehicle_id, page = 1, limit = 10 
    } = req.query;

    const filters = {};
    if (status) filters.status = status;
    if (customer_email) filters.customer_email = customer_email;
    if (vehicle_id) filters.vehicle_id = vehicle_id;

    const result = await Rent2Own.getAll(filters, page, limit);

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
    
    const booking = await Rent2Own.findById(id);
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
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ 
        message: 'Validation failed', 
        errors: errors.array() 
      });
    }

    const {
      vehicle_id,
      customer_name,
      customer_email,
      customer_phone,
      monthly_income,
      employment_status,
      employer_name,
      preferred_term,
      down_payment
    } = req.body;

    // Verify vehicle exists and is available for rent-to-own
    const vehicle = await Vehicle.findById(vehicle_id);
    if (!vehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }

    if (vehicle.listing_type !== 'rent-to-own') {
      return res.status(400).json({ message: 'Vehicle is not available for rent-to-own' });
    }

    // Check if customer already has a pending/active booking for this vehicle
    const existingBookings = await Rent2Own.getByVehicle(vehicle_id);
    const activeBooking = existingBookings.find(booking => 
      booking.customer_email === customer_email && 
      ['pending', 'approved', 'active'].includes(booking.status)
    );

    if (activeBooking) {
      return res.status(400).json({ 
        message: 'You already have an active rent-to-own request for this vehicle' 
      });
    }

    const bookingData = {
      vehicle_id,
      customer_name,
      customer_email,
      customer_phone,
      monthly_income,
      employment_status,
      employer_name,
      preferred_term,
      down_payment,
      status: 'pending'
    };

    const newBooking = await Rent2Own.create(bookingData);

    // Include vehicle details in response
    newBooking.vehicle = vehicle;

    res.status(201).json({
      message: 'Rent-to-own booking created successfully',
      booking: newBooking
    });

  } catch (error) {
    console.error('Create rent-to-own booking error:', error);
    res.status(500).json({ message: 'Server error while creating rent-to-own booking' });
  }
};

// Update rent-to-own booking
exports.updateBooking = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ 
        message: 'Validation failed', 
        errors: errors.array() 
      });
    }

    const { id } = req.params;
    const updateData = req.body;

    // Remove fields that shouldn't be updated directly
    delete updateData.booking_id;
    delete updateData.created_at;
    delete updateData.updated_at;

    const updated = await Rent2Own.update(id, updateData);
    
    if (!updated) {
      return res.status(404).json({ message: 'Rent-to-own booking not found' });
    }

    const updatedBooking = await Rent2Own.findById(id);
    res.json({
      message: 'Rent-to-own booking updated successfully',
      booking: updatedBooking
    });

  } catch (error) {
    console.error('Update rent-to-own booking error:', error);
    res.status(500).json({ message: 'Server error while updating rent-to-own booking' });
  }
};

// Delete rent-to-own booking
exports.deleteBooking = async (req, res) => {
  try {
    const { id } = req.params;
    
    const deleted = await Rent2Own.delete(id);
    
    if (!deleted) {
      return res.status(404).json({ message: 'Rent-to-own booking not found' });
    }

    res.json({ message: 'Rent-to-own booking deleted successfully' });

  } catch (error) {
    console.error('Delete rent-to-own booking error:', error);
    res.status(500).json({ message: 'Server error while deleting rent-to-own booking' });
  }
};

// Update booking status
exports.updateBookingStatus = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ 
        message: 'Validation failed', 
        errors: errors.array() 
      });
    }

    const { id } = req.params;
    const { status } = req.body;

    const updated = await Rent2Own.updateStatus(id, status);
    
    if (!updated) {
      return res.status(404).json({ message: 'Rent-to-own booking not found' });
    }

    const updatedBooking = await Rent2Own.findById(id);
    res.json({
      message: `Rent-to-own booking status updated to ${status}`,
      booking: updatedBooking
    });

  } catch (error) {
    console.error('Update rent-to-own booking status error:', error);
    res.status(500).json({ message: 'Server error while updating booking status' });
  }
};

// Get bookings by customer email
exports.getBookingsByEmail = async (req, res) => {
  try {
    const { email } = req.params;
    
    if (!email) {
      return res.status(400).json({ message: 'Email parameter is required' });
    }

    const bookings = await Rent2Own.getByCustomerEmail(email);
    
    res.json({ bookings });

  } catch (error) {
    console.error('Get bookings by email error:', error);
    res.status(500).json({ message: 'Server error while fetching customer bookings' });
  }
};

// Get bookings by vehicle ID
exports.getBookingsByVehicle = async (req, res) => {
  try {
    const { vehicleId } = req.params;
    
    if (!vehicleId) {
      return res.status(400).json({ message: 'Vehicle ID parameter is required' });
    }

    const bookings = await Rent2Own.getByVehicle(vehicleId);
    
    res.json({ bookings });

  } catch (error) {
    console.error('Get bookings by vehicle error:', error);
    res.status(500).json({ message: 'Server error while fetching vehicle bookings' });
  }
};

// Get active bookings
exports.getActiveBookings = async (req, res) => {
  try {
    const result = await Rent2Own.getActiveBookings();
    res.json(result);
  } catch (error) {
    console.error('Get active bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching active bookings' });
  }
};

// Get pending bookings
exports.getPendingBookings = async (req, res) => {
  try {
    const result = await Rent2Own.getPendingBookings();
    res.json(result);
  } catch (error) {
    console.error('Get pending bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching pending bookings' });
  }
};

// Get booking statistics
exports.getStatistics = async (req, res) => {
  try {
    const stats = await Rent2Own.getStatistics();
    res.json({ statistics: stats });
  } catch (error) {
    console.error('Get statistics error:', error);
    res.status(500).json({ message: 'Server error while fetching statistics' });
  }
};

// Get recent bookings
exports.getRecentBookings = async (req, res) => {
  try {
    const { limit = 10 } = req.query;
    const bookings = await Rent2Own.getRecentBookings(parseInt(limit));
    res.json({ bookings });
  } catch (error) {
    console.error('Get recent bookings error:', error);
    res.status(500).json({ message: 'Server error while fetching recent bookings' });
  }
};

// Search bookings
exports.searchBookings = async (req, res) => {
  try {
    const { q } = req.query;
    
    if (!q || q.trim().length < 2) {
      return res.status(400).json({ message: 'Search term must be at least 2 characters long' });
    }

    const bookings = await Rent2Own.searchBookings(q.trim());
    res.json({ bookings });

  } catch (error) {
    console.error('Search bookings error:', error);
    res.status(500).json({ message: 'Server error while searching bookings' });
  }
};

// Get available rent-to-own vehicles
exports.getAvailableVehicles = async (req, res) => {
  try {
    const { 
      category, make, model, min_price, max_price, 
      region, city, page = 1, limit = 20 
    } = req.query;

    const filters = {
      listing_type: 'rent-to-own',
      status: 'available'
    };

    if (category) filters.category = category;
    if (make) filters.make = make;
    if (model) filters.model = model;
    if (region) filters.region = region;
    if (city) filters.city = city;
    if (min_price) filters.min_price = parseFloat(min_price);
    if (max_price) filters.max_price = parseFloat(max_price);

    const result = await Vehicle.getAll(filters, page, limit);

    res.json(result);
  } catch (error) {
    console.error('Get available rent-to-own vehicles error:', error);
    res.status(500).json({ message: 'Server error while fetching available vehicles' });
  }
};

// Check if vehicle is available for rent-to-own
exports.checkVehicleAvailability = async (req, res) => {
  try {
    const { vehicleId } = req.params;
    
    const vehicle = await Vehicle.findById(vehicleId);
    if (!vehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }

    const isAvailable = vehicle.listing_type === 'rent-to-own' && vehicle.status === 'available';
    
    // Check for active bookings
    const activeBookings = await Rent2Own.getByVehicle(vehicleId);
    const hasActiveBooking = activeBookings.some(booking => 
      ['approved', 'active'].includes(booking.status)
    );

    res.json({
      available: isAvailable && !hasActiveBooking,
      vehicle: {
        id: vehicle.vehicle_id,
        make: vehicle.make,
        model: vehicle.model,
        year: vehicle.year,
        price: vehicle.price,
        listing_type: vehicle.listing_type,
        status: vehicle.status
      },
      activeBookings: hasActiveBooking
    });

  } catch (error) {
    console.error('Check vehicle availability error:', error);
    res.status(500).json({ message: 'Server error while checking vehicle availability' });
  }
};