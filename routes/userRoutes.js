const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const { body } = require('express-validator');
const { authenticateToken, requireAdmin } = require('../middleware/auth');
const upload = require('../middleware/upload');

// Validation middleware
const registerValidation = [
  body('username').notEmpty().withMessage('Username is required'),
  body('email').isEmail().withMessage('Valid email is required'),
  body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
  body('phone').notEmpty().withMessage('Phone number is required'),
  body('user_type').optional().isIn(['customer', 'dealer', 'admin']).withMessage('Invalid user type')
];

const loginValidation = [
  body('email').isEmail().withMessage('Valid email is required'),
  body('password').notEmpty().withMessage('Password is required')
];

const updateProfileValidation = [
  body('username').optional().notEmpty().withMessage('Username cannot be empty'),
  body('email').optional().isEmail().withMessage('Valid email is required'),
  body('phone').optional().notEmpty().withMessage('Phone number cannot be empty')
];

const changePasswordValidation = [
  body('current_password').notEmpty().withMessage('Current password is required'),
  body('new_password').isLength({ min: 6 }).withMessage('New password must be at least 6 characters')
];



// Public routes
router.post('/register', registerValidation, userController.register);
router.post('/login', loginValidation, userController.login);
router.get('/dealers/public', userController.getDealershipsWithLogos); // Public endpoint for mobile app with logos
router.get('/:id/logo', userController.getLogo); // Public endpoint to get user logo

// Protected routes (require authentication)
router.get('/profile', authenticateToken, userController.getProfile);
router.put('/profile', authenticateToken, updateProfileValidation, userController.updateProfile);
router.put('/change-password', authenticateToken, changePasswordValidation, userController.changePassword);
router.post('/logo', authenticateToken, upload.single('logo'), userController.uploadLogo);
router.delete('/logo', authenticateToken, userController.removeLogo);

// Admin routes
router.get('/', authenticateToken, requireAdmin, userController.getAllUsers);
router.get('/dealers', authenticateToken, requireAdmin, userController.getDealers);
router.get('/statistics', authenticateToken, requireAdmin, userController.getUserStatistics);
router.get('/:id', authenticateToken, requireAdmin, userController.getUserById);
router.put('/:id/status', authenticateToken, requireAdmin, userController.updateUserStatus);
router.delete('/:id', authenticateToken, requireAdmin, userController.deleteUser);

module.exports = router;
