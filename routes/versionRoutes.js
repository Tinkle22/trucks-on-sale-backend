const express = require('express');
const router = express.Router();
const versionController = require('../controllers/versionController');

// Public routes for version checking
router.post('/check', versionController.checkVersion);
router.get('/', versionController.checkVersion);

// Admin routes for version management (uncomment when auth is implemented)
// router.get('/config', authenticateToken, requireAdmin, versionController.getVersionConfig);
// router.put('/config', authenticateToken, requireAdmin, versionController.updateVersionConfig);
// router.get('/stats', authenticateToken, requireAdmin, versionController.getVersionStats);

// Temporary public routes for testing (remove in production)
router.get('/config', versionController.getVersionConfig);
router.put('/config', versionController.updateVersionConfig);
router.get('/stats', versionController.getVersionStats);

module.exports = router;
