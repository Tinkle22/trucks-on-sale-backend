const Inquiry = require('../models/Inquiry');
const InquiryReply = require('../models/InquiryReply');
const { validationResult } = require('express-validator');

// Get all inquiries for a vehicle
exports.getInquiriesByVehicle = async (req, res) => {
  try {
    const { vehicleId } = req.params;
    
    const inquiries = await Inquiry.getByVehicleId(vehicleId);
    
    res.json({ inquiries });
  } catch (error) {
    console.error('Get inquiries by vehicle error:', error);
    res.status(500).json({ message: 'Server error while fetching inquiries' });
  }
};

// Get all inquiries for a user
exports.getInquiriesByUser = async (req, res) => {
  try {
    // Get user ID from authenticated user
    // In getInquiriesByUser function
    // Replace this:
    // const userId = req.user.user_id;
    // With this:
    const userId = req.params.userId;
    
    // In getInquiriesByDealer function
    // Replace this:
    // const dealerId = req.user.user_id;
    // With this:
    const dealerId = req.params.dealerId;
    
    // In createInquiry function
    // Replace this:
    // req.body.user_id = req.user.user_id;
    // With this:
    // Make sure user_id is provided in the request body
    if (!req.body.user_id) {
      return res.status(400).json({ message: 'User ID is required' });
    }
    
    // In deleteInquiry function
    // Remove authorization check:
    // if (req.user.user_type !== 'admin' && req.user.user_id !== inquiry.user_id) {
    //   return res.status(403).json({ message: 'Not authorized to delete this inquiry' });
    // }
    
    // In createInquiryReply function
    // Replace this:
    // req.body.user_id = req.user.user_id;
    // With this:
    // Make sure user_id is provided in the request body
    if (!req.body.user_id) {
      return res.status(400).json({ message: 'User ID is required' });
    }
    
    const inquiries = await Inquiry.getByUserId(userId);
    
    res.json({ inquiries });
  } catch (error) {
    console.error('Get inquiries by user error:', error);
    res.status(500).json({ message: 'Server error while fetching inquiries' });
  }
};

// Get all inquiries for a dealer
exports.getInquiriesByDealer = async (req, res) => {
  try {
    // Get dealer ID from authenticated user
    const dealerId = req.user.user_id;
    
    const inquiries = await Inquiry.getByDealerId(dealerId);
    
    res.json({ inquiries });
  } catch (error) {
    console.error('Get inquiries by dealer error:', error);
    res.status(500).json({ message: 'Server error while fetching inquiries' });
  }
};

// Get inquiry by ID with replies
exports.getInquiryById = async (req, res) => {
  try {
    const { id } = req.params;
    
    const inquiry = await Inquiry.findById(id);
    if (!inquiry) {
      return res.status(404).json({ message: 'Inquiry not found' });
    }
    
    // Get replies
    const replies = await InquiryReply.findByInquiryId(id);
    
    res.json({ inquiry, replies });
  } catch (error) {
    console.error('Get inquiry by ID error:', error);
    res.status(500).json({ message: 'Server error while fetching inquiry' });
  }
};

// Create new inquiry
exports.createInquiry = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    // Set user_id from authenticated user
    req.body.user_id = req.user.user_id;
    
    const inquiry = await Inquiry.create(req.body);
    
    res.status(201).json({ message: 'Inquiry created successfully', inquiry });
  } catch (error) {
    console.error('Create inquiry error:', error);
    res.status(500).json({ message: 'Server error while creating inquiry' });
  }
};

// Update inquiry status
exports.updateInquiryStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;
    
    const inquiry = await Inquiry.findById(id);
    if (!inquiry) {
      return res.status(404).json({ message: 'Inquiry not found' });
    }
    
    const updated = await Inquiry.updateStatus(id, status);
    if (!updated) {
      return res.status(400).json({ message: 'Failed to update inquiry status' });
    }
    
    res.json({ message: 'Inquiry status updated successfully' });
  } catch (error) {
    console.error('Update inquiry status error:', error);
    res.status(500).json({ message: 'Server error while updating inquiry status' });
  }
};

// Delete inquiry
exports.deleteInquiry = async (req, res) => {
  try {
    const { id } = req.params;
    
    const inquiry = await Inquiry.findById(id);
    if (!inquiry) {
      return res.status(404).json({ message: 'Inquiry not found' });
    }
    
    // Check if user is authorized to delete this inquiry
    if (req.user.user_type !== 'admin' && req.user.user_id !== inquiry.user_id) {
      return res.status(403).json({ message: 'Not authorized to delete this inquiry' });
    }
    
    const deleted = await Inquiry.delete(id);
    if (!deleted) {
      return res.status(400).json({ message: 'Failed to delete inquiry' });
    }
    
    res.json({ message: 'Inquiry deleted successfully' });
  } catch (error) {
    console.error('Delete inquiry error:', error);
    res.status(500).json({ message: 'Server error while deleting inquiry' });
  }
};

// Create inquiry reply
exports.createReply = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { inquiryId } = req.params;
    
    // Check if inquiry exists
    const inquiry = await Inquiry.findById(inquiryId);
    if (!inquiry) {
      return res.status(404).json({ message: 'Inquiry not found' });
    }
    
    // Set user_id from authenticated user
    req.body.user_id = req.user.user_id;
    req.body.inquiry_id = inquiryId;
    
    const reply = await InquiryReply.create(req.body);
    
    res.status(201).json({ message: 'Reply created successfully', reply });
  } catch (error) {
    console.error('Create reply error:', error);
    res.status(500).json({ message: 'Server error while creating reply' });
  }
};

// Delete inquiry reply
exports.deleteReply = async (req, res) => {
  try {
    const { replyId } = req.params;
    
    // Delete reply
    const deleted = await InquiryReply.delete(replyId);
    if (!deleted) {
      return res.status(404).json({ message: 'Reply not found or already deleted' });
    }
    
    res.json({ message: 'Reply deleted successfully' });
  } catch (error) {
    console.error('Delete reply error:', error);
    res.status(500).json({ message: 'Server error while deleting reply' });
  }
};