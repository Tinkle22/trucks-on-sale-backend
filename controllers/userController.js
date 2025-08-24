const User = require('../models/User');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { validationResult } = require('express-validator');

// Register a new user
exports.register = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { username, email, password, phone, company_name, user_type } = req.body;

    // Check if user already exists
    const existingUser = await User.findByEmail(email);
    if (existingUser) {
      return res.status(400).json({ message: 'User already exists with this email' });
    }

    const existingUsername = await User.findByUsername(username);
    if (existingUsername) {
      return res.status(400).json({ message: 'Username is already taken' });
    }

    // Create new user
    const newUser = await User.create({
      username,
      email,
      password,
      phone,
      company_name,
      user_type: user_type || 'customer'
    });

    // Generate JWT token
    const token = jwt.sign(
      { 
        user_id: newUser.user_id,
        username: newUser.username,
        email: newUser.email,
        user_type: newUser.user_type
      },
      process.env.JWT_SECRET,
      { expiresIn: '7d' }
    );

    res.status(201).json({
      message: 'User registered successfully',
      token,
      user: {
        user_id: newUser.user_id,
        username: newUser.username,
        email: newUser.email,
        phone: newUser.phone,
        company_name: newUser.company_name,
        user_type: newUser.user_type
      }
    });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ message: 'Server error during registration' });
  }
};

// Login user
exports.login = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { email, password } = req.body;

    // Find user by email
    const user = await User.findByEmail(email);
    if (!user) {
      return res.status(400).json({ message: 'Invalid credentials' });
    }

    // Compare passwords
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: 'Invalid credentials' });
    }

    // Generate JWT token
    const token = jwt.sign(
      { 
        user_id: user.user_id,
        username: user.username,
        email: user.email,
        user_type: user.user_type
      },
      process.env.JWT_SECRET,
      { expiresIn: '7d' }
    );

    res.json({
      message: 'Login successful',
      token,
      user: {
        user_id: user.user_id,
        username: user.username,
        email: user.email,
        phone: user.phone,
        company_name: user.company_name,
        user_type: user.user_type
      }
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ message: 'Server error during login' });
  }
};

// Get current user profile
exports.getProfile = async (req, res) => {
  try {
    const user = await User.findById(req.user.user_id);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.json({ user });
  } catch (error) {
    console.error('Get profile error:', error);
    res.status(500).json({ message: 'Server error while fetching profile' });
  }
};

// Update user profile
exports.updateProfile = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { username, email, phone, company_name } = req.body;

    // Check if email is already taken by another user
    if (email) {
      const existingUser = await User.findByEmail(email);
      if (existingUser && existingUser.user_id !== req.user.user_id) {
        return res.status(400).json({ message: 'Email is already in use' });
      }
    }

    // Check if username is already taken by another user
    if (username) {
      const existingUser = await User.findByUsername(username);
      if (existingUser && existingUser.user_id !== req.user.user_id) {
        return res.status(400).json({ message: 'Username is already taken' });
      }
    }

    // Update user profile
    const updated = await User.update(req.user.user_id, {
      username,
      email,
      phone,
      company_name
    });

    if (!updated) {
      return res.status(404).json({ message: 'User not found or no changes made' });
    }

    // Get updated user data
    const updatedUser = await User.findById(req.user.user_id);

    res.json({
      message: 'Profile updated successfully',
      user: updatedUser
    });
  } catch (error) {
    console.error('Update profile error:', error);
    res.status(500).json({ message: 'Server error while updating profile' });
  }
};

// Change password
exports.changePassword = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { current_password, new_password } = req.body;

    // Get user with password
    const user = await User.findByEmail(req.user.email);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Verify current password
    const isMatch = await bcrypt.compare(current_password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: 'Current password is incorrect' });
    }

    // Update password
    const updated = await User.updatePassword(req.user.user_id, new_password);

    if (!updated) {
      return res.status(500).json({ message: 'Failed to update password' });
    }

    res.json({ message: 'Password updated successfully' });
  } catch (error) {
    console.error('Change password error:', error);
    res.status(500).json({ message: 'Server error while changing password' });
  }
};

// Admin: Get all users
exports.getAllUsers = async (req, res) => {
  try {
    const users = await User.getAll();
    res.json({ users });
  } catch (error) {
    console.error('Get all users error:', error);
    res.status(500).json({ message: 'Server error while fetching users' });
  }
};

// Admin: Delete user
exports.deleteUser = async (req, res) => {
  try {
    const { id } = req.params;

    const deleted = await User.delete(id);
    if (!deleted) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.json({ message: 'User deleted successfully' });
  } catch (error) {
    console.error('Delete user error:', error);
    res.status(500).json({ message: 'Server error while deleting user' });
  }
};

// Get user by ID
exports.getUserById = async (req, res) => {
  try {
    const { id } = req.params;

    const user = await User.findById(id);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Remove password from response
    delete user.password;

    res.json({ user });
  } catch (error) {
    console.error('Get user by ID error:', error);
    res.status(500).json({ message: 'Server error while fetching user' });
  }
};

// Update user status (admin only)
exports.updateUserStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    // Validate status
    if (!['pending', 'active', 'suspended', 'rejected'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status value' });
    }

    // Check if user exists
    const existingUser = await User.findById(id);
    if (!existingUser) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Update status
    const updated = await User.updateStatus(id, status);

    if (!updated) {
      return res.status(500).json({ message: 'Failed to update user status' });
    }

    res.json({ message: `User status updated to ${status}` });
  } catch (error) {
    console.error('Update user status error:', error);
    res.status(500).json({ message: 'Server error while updating user status' });
  }
};

// Get dealers
exports.getDealers = async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;

    const result = await User.getDealers(page, limit);

    res.json(result);
  } catch (error) {
    console.error('Get dealers error:', error);
    res.status(500).json({ message: 'Server error while fetching dealers' });
  }
};

// Get user statistics (admin only)
exports.getUserStatistics = async (req, res) => {
  try {
    const stats = await User.getStatistics();
    res.json({ stats });
  } catch (error) {
    console.error('Get user statistics error:', error);
    res.status(500).json({ message: 'Server error while fetching user statistics' });
  }
};

// Upload user logo
exports.uploadLogo = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ message: 'No logo file provided' });
    }

    const logoPath = req.file.path.replace(/\\/g, '/');
    const updated = await User.updateLogo(req.user.user_id, logoPath);

    if (!updated) {
      return res.status(500).json({ message: 'Failed to update logo' });
    }

    res.json({
      message: 'Logo uploaded successfully',
      logo: logoPath
    });
  } catch (error) {
    console.error('Upload logo error:', error);
    res.status(500).json({ message: 'Server error while uploading logo' });
  }
};

// Get user logo
exports.getLogo = async (req, res) => {
  try {
    const { id } = req.params;
    const logo = await User.getLogo(id);

    if (!logo) {
      return res.status(404).json({ message: 'No logo found for this user' });
    }

    res.json({ logo });
  } catch (error) {
    console.error('Get logo error:', error);
    res.status(500).json({ message: 'Server error while fetching logo' });
  }
};

// Remove user logo
exports.removeLogo = async (req, res) => {
  try {
    const updated = await User.removeLogo(req.user.user_id);

    if (!updated) {
      return res.status(500).json({ message: 'Failed to remove logo' });
    }

    res.json({ message: 'Logo removed successfully' });
  } catch (error) {
    console.error('Remove logo error:', error);
    res.status(500).json({ message: 'Server error while removing logo' });
  }
};

// Get dealerships with logos (public endpoint)
exports.getDealershipsWithLogos = async (req, res) => {
  try {
    const { page = 1, limit = 20 } = req.query;
    const result = await User.getDealers(page, limit);
    
    res.json({
      success: true,
      dealerships: result.dealers,
      pagination: result.pagination
    });
  } catch (error) {
    console.error('Get dealerships with logos error:', error);
    res.status(500).json({ 
      success: false,
      error: 'Server error while fetching dealerships' 
    });
  }
};