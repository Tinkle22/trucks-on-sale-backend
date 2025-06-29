const PremiumBackground = require('../models/PremiumBackground');
const { validationResult } = require('express-validator');
const fs = require('fs');
const path = require('path');

// Get all premium backgrounds
exports.getAllBackgrounds = async (req, res) => {
  try {
    const { 
      status, search, page = 1, limit = 10 
    } = req.query;

    let result;

    if (search) {
      result = await PremiumBackground.searchBackgrounds(search, page, limit);
    } else {
      const filters = {};
      if (status) filters.status = status;

      result = await PremiumBackground.getAll(filters, page, limit);
    }

    res.json(result);
  } catch (error) {
    console.error('Get all backgrounds error:', error);
    res.status(500).json({ message: 'Server error while fetching premium backgrounds' });
  }
};

// Get premium background by ID
exports.getBackgroundById = async (req, res) => {
  try {
    const { id } = req.params;
    
    const background = await PremiumBackground.findById(id);
    if (!background) {
      return res.status(404).json({ message: 'Premium background not found' });
    }
    
    res.json({ background });
  } catch (error) {
    console.error('Get background by ID error:', error);
    res.status(500).json({ message: 'Server error while fetching premium background' });
  }
};

// Create new premium background (admin only)
exports.createBackground = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    // Set priority if not provided
    if (!req.body.priority) {
      const maxPriority = await PremiumBackground.getMaxPriority();
      req.body.priority = maxPriority + 1;
    }
    
    // Create premium background
    const background = await PremiumBackground.create(req.body);
    
    res.status(201).json({
      message: 'Premium background created successfully',
      background
    });
  } catch (error) {
    console.error('Create background error:', error);
    res.status(500).json({ message: 'Server error while creating premium background' });
  }
};

// Update premium background (admin only)
exports.updateBackground = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    
    // Check if background exists
    const existingBackground = await PremiumBackground.findById(id);
    if (!existingBackground) {
      return res.status(404).json({ message: 'Premium background not found' });
    }
    
    // Update background
    const updated = await PremiumBackground.update(id, req.body);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update premium background' });
    }
    
    // Get updated background
    const updatedBackground = await PremiumBackground.findById(id);
    
    res.json({
      message: 'Premium background updated successfully',
      background: updatedBackground
    });
  } catch (error) {
    console.error('Update background error:', error);
    res.status(500).json({ message: 'Server error while updating premium background' });
  }
};

// Delete premium background (admin only)
exports.deleteBackground = async (req, res) => {
  try {
    const { id } = req.params;
    
    // Check if background exists
    const existingBackground = await PremiumBackground.findById(id);
    if (!existingBackground) {
      return res.status(404).json({ message: 'Premium background not found' });
    }
    
    // Delete image file if it exists locally
    if (existingBackground.image_path && existingBackground.image_path.startsWith('/uploads/')) {
      const fullPath = path.join(__dirname, '..', existingBackground.image_path);
      if (fs.existsSync(fullPath)) {
        fs.unlinkSync(fullPath);
      }
    }
    
    // Delete background
    const deleted = await PremiumBackground.delete(id);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete premium background' });
    }
    
    res.json({ message: 'Premium background deleted successfully' });
  } catch (error) {
    console.error('Delete background error:', error);
    res.status(500).json({ message: 'Server error while deleting premium background' });
  }
};

// Update background status (admin only)
exports.updateBackgroundStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;
    
    // Validate status
    if (!['active', 'inactive'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status value' });
    }
    
    // Check if background exists
    const existingBackground = await PremiumBackground.findById(id);
    if (!existingBackground) {
      return res.status(404).json({ message: 'Premium background not found' });
    }
    
    // Update status
    const updated = await PremiumBackground.updateStatus(id, status);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update background status' });
    }
    
    res.json({ message: `Premium background status updated to ${status}` });
  } catch (error) {
    console.error('Update background status error:', error);
    res.status(500).json({ message: 'Server error while updating background status' });
  }
};

// Update background priority (admin only)
exports.updateBackgroundPriority = async (req, res) => {
  try {
    const { id } = req.params;
    const { priority } = req.body;
    
    // Validate priority
    if (!Number.isInteger(priority) || priority < 0) {
      return res.status(400).json({ message: 'Priority must be a non-negative integer' });
    }
    
    // Check if background exists
    const existingBackground = await PremiumBackground.findById(id);
    if (!existingBackground) {
      return res.status(404).json({ message: 'Premium background not found' });
    }
    
    // Update priority
    const updated = await PremiumBackground.updatePriority(id, priority);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update background priority' });
    }
    
    res.json({ message: `Premium background priority updated to ${priority}` });
  } catch (error) {
    console.error('Update background priority error:', error);
    res.status(500).json({ message: 'Server error while updating background priority' });
  }
};

// Reorder background priorities (admin only)
exports.reorderBackgrounds = async (req, res) => {
  try {
    const { background_ids } = req.body;
    
    if (!Array.isArray(background_ids) || background_ids.length === 0) {
      return res.status(400).json({ message: 'Background IDs array is required' });
    }
    
    // Reorder priorities
    const updated = await PremiumBackground.reorderPriorities(background_ids);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to reorder backgrounds' });
    }
    
    res.json({ message: 'Background priorities updated successfully' });
  } catch (error) {
    console.error('Reorder backgrounds error:', error);
    res.status(500).json({ message: 'Server error while reordering backgrounds' });
  }
};

// Get active backgrounds
exports.getActiveBackgrounds = async (req, res) => {
  try {
    const backgrounds = await PremiumBackground.getActive();
    res.json({ backgrounds });
  } catch (error) {
    console.error('Get active backgrounds error:', error);
    res.status(500).json({ message: 'Server error while fetching active backgrounds' });
  }
};

// Get backgrounds by status
exports.getBackgroundsByStatus = async (req, res) => {
  try {
    const { status } = req.params;
    
    // Validate status
    if (!['active', 'inactive'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status value' });
    }
    
    const backgrounds = await PremiumBackground.getByStatus(status);
    res.json({ backgrounds });
  } catch (error) {
    console.error('Get backgrounds by status error:', error);
    res.status(500).json({ message: 'Server error while fetching backgrounds by status' });
  }
};

// Get backgrounds by priority
exports.getBackgroundsByPriority = async (req, res) => {
  try {
    const { limit = 5 } = req.query;
    
    const backgrounds = await PremiumBackground.getByPriority(limit);
    res.json({ backgrounds });
  } catch (error) {
    console.error('Get backgrounds by priority error:', error);
    res.status(500).json({ message: 'Server error while fetching backgrounds by priority' });
  }
};

// Get expired backgrounds (admin only)
exports.getExpiredBackgrounds = async (req, res) => {
  try {
    const backgrounds = await PremiumBackground.getExpired();
    res.json({ backgrounds });
  } catch (error) {
    console.error('Get expired backgrounds error:', error);
    res.status(500).json({ message: 'Server error while fetching expired backgrounds' });
  }
};

// Get upcoming backgrounds (admin only)
exports.getUpcomingBackgrounds = async (req, res) => {
  try {
    const backgrounds = await PremiumBackground.getUpcoming();
    res.json({ backgrounds });
  } catch (error) {
    console.error('Get upcoming backgrounds error:', error);
    res.status(500).json({ message: 'Server error while fetching upcoming backgrounds' });
  }
};

// Get backgrounds by advertiser (admin only)
exports.getBackgroundsByAdvertiser = async (req, res) => {
  try {
    const { advertiserName } = req.params;
    
    const backgrounds = await PremiumBackground.getByAdvertiser(advertiserName);
    res.json({ backgrounds });
  } catch (error) {
    console.error('Get backgrounds by advertiser error:', error);
    res.status(500).json({ message: 'Server error while fetching backgrounds by advertiser' });
  }
};

// Get backgrounds by date range (admin only)
exports.getBackgroundsByDateRange = async (req, res) => {
  try {
    const { start_date, end_date } = req.query;
    
    if (!start_date || !end_date) {
      return res.status(400).json({ message: 'Start date and end date are required' });
    }
    
    const backgrounds = await PremiumBackground.getByDateRange(start_date, end_date);
    res.json({ backgrounds });
  } catch (error) {
    console.error('Get backgrounds by date range error:', error);
    res.status(500).json({ message: 'Server error while fetching backgrounds by date range' });
  }
};

// Get premium background statistics (admin only)
exports.getBackgroundStatistics = async (req, res) => {
  try {
    const stats = await PremiumBackground.getStatistics();
    res.json({ stats });
  } catch (error) {
    console.error('Get background statistics error:', error);
    res.status(500).json({ message: 'Server error while fetching background statistics' });
  }
};

// Get random active background (for public display)
exports.getRandomActiveBackground = async (req, res) => {
  try {
    const { limit = 1 } = req.query;
    
    const backgrounds = await PremiumBackground.getRandomActive(limit);
    res.json({ backgrounds });
  } catch (error) {
    console.error('Get random active background error:', error);
    res.status(500).json({ message: 'Server error while fetching random active background' });
  }
};
