const jwt = require('jsonwebtoken');
const User = require('../models/User');

// Middleware to authenticate JWT token
const authenticateToken = async (req, res, next) => {
  try {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Bearer TOKEN

    if (!token) {
      return res.status(401).json({ message: 'Access token required' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key');
    
    // Get user details from database
    const user = await User.findById(decoded.user_id);
    if (!user) {
      return res.status(401).json({ message: 'Invalid token - user not found' });
    }

    if (user.status !== 'active') {
      return res.status(401).json({ message: 'Account is not active' });
    }

    req.user = {
      user_id: user.user_id,
      email: user.email,
      username: user.username,
      user_type: user.user_type,
      status: user.status
    };

    next();
  } catch (error) {
    if (error.name === 'JsonWebTokenError') {
      return res.status(401).json({ message: 'Invalid token' });
    }
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({ message: 'Token expired' });
    }
    console.error('Authentication error:', error);
    return res.status(500).json({ message: 'Server error during authentication' });
  }
};

// Middleware to require admin access
const requireAdmin = (req, res, next) => {
  if (req.user && req.user.user_type === 'admin') {
    next();
  } else {
    res.status(403).json({ message: 'Admin access required' });
  }
};

// Middleware to require dealer or admin access
const requireDealerOrAdmin = (req, res, next) => {
  if (req.user && (req.user.user_type === 'dealer' || req.user.user_type === 'admin')) {
    next();
  } else {
    res.status(403).json({ message: 'Dealer or admin access required' });
  }
};

// Middleware to require customer, dealer, or admin access (any authenticated user)
const requireAuthenticated = (req, res, next) => {
  if (req.user) {
    next();
  } else {
    res.status(401).json({ message: 'Authentication required' });
  }
};

// Optional authentication middleware (doesn't fail if no token)
const optionalAuth = async (req, res, next) => {
  try {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (token) {
      const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key');
      const user = await User.findById(decoded.user_id);
      
      if (user && user.status === 'active') {
        req.user = {
          user_id: user.user_id,
          email: user.email,
          username: user.username,
          user_type: user.user_type,
          status: user.status
        };
      }
    }

    next();
  } catch (error) {
    // Ignore authentication errors for optional auth
    next();
  }
};

module.exports = {
  authenticateToken,
  requireAdmin,
  requireDealerOrAdmin,
  requireAuthenticated,
  optionalAuth
};
