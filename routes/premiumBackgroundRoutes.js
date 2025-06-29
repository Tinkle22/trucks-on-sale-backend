const express = require('express');
const router = express.Router();
const premiumBackgroundController = require('../controllers/premiumBackgroundController');
const { body } = require('express-validator');

// Validation middleware
const backgroundValidation = [
  body('image_path').notEmpty().withMessage('Image path is required'),
  body('title').optional().notEmpty().withMessage('Title cannot be empty'),
  body('advertiser_name').optional().notEmpty().withMessage('Advertiser name cannot be empty'),
  body('start_date').optional().isISO8601().withMessage('Valid start date is required'),
  body('end_date').optional().isISO8601().withMessage('Valid end date is required'),
  body('priority').optional().isInt({ min: 0 }).withMessage('Priority must be a non-negative integer')
];

const statusValidation = [
  body('status').isIn(['active', 'inactive']).withMessage('Invalid status value')
];

const priorityValidation = [
  body('priority').isInt({ min: 0 }).withMessage('Priority must be a non-negative integer')
];

const reorderValidation = [
  body('background_ids').isArray().withMessage('Background IDs must be an array')
];

// Authentication middleware (placeholder)
const authenticateToken = (req, res, next) => {
  // This should verify JWT token and set req.user
  next();
};

const requireAdmin = (req, res, next) => {
  if (req.user && req.user.user_type === 'admin') {
    next();
  } else {
    res.status(403).json({ message: 'Admin access required' });
  }
};

// Public routes
router.get('/active', premiumBackgroundController.getActiveBackgrounds);
router.get('/random', premiumBackgroundController.getRandomActiveBackground);
router.get('/priority', premiumBackgroundController.getBackgroundsByPriority);

// Admin routes
router.get('/', authenticateToken, requireAdmin, premiumBackgroundController.getAllBackgrounds);
router.get('/statistics', authenticateToken, requireAdmin, premiumBackgroundController.getBackgroundStatistics);
router.get('/expired', authenticateToken, requireAdmin, premiumBackgroundController.getExpiredBackgrounds);
router.get('/upcoming', authenticateToken, requireAdmin, premiumBackgroundController.getUpcomingBackgrounds);
router.get('/date-range', authenticateToken, requireAdmin, premiumBackgroundController.getBackgroundsByDateRange);
router.get('/status/:status', authenticateToken, requireAdmin, premiumBackgroundController.getBackgroundsByStatus);
router.get('/advertiser/:advertiserName', authenticateToken, requireAdmin, premiumBackgroundController.getBackgroundsByAdvertiser);
router.get('/:id', authenticateToken, requireAdmin, premiumBackgroundController.getBackgroundById);
router.post('/', authenticateToken, requireAdmin, backgroundValidation, premiumBackgroundController.createBackground);
router.put('/:id', authenticateToken, requireAdmin, backgroundValidation, premiumBackgroundController.updateBackground);
router.put('/:id/status', authenticateToken, requireAdmin, statusValidation, premiumBackgroundController.updateBackgroundStatus);
router.put('/:id/priority', authenticateToken, requireAdmin, priorityValidation, premiumBackgroundController.updateBackgroundPriority);
router.put('/reorder', authenticateToken, requireAdmin, reorderValidation, premiumBackgroundController.reorderBackgrounds);
router.delete('/:id', authenticateToken, requireAdmin, premiumBackgroundController.deleteBackground);

module.exports = router;
