const express = require('express');
const router = express.Router();
const {
  getAllActiveAds,
  getAdsByType,
  getAdsByPosition,
  getAdsByTypeAndPosition,
  trackImpression,
  trackClick,
  getHomepageBannerAds,
  getHomepageBoxAds
} = require('../controllers/premiumAdController');

// Get all active premium ads
router.get('/', getAllActiveAds);

// Get premium ads by type (banner, box)
router.get('/type/:type', getAdsByType);

// Get premium ads by position (homepage, listing, etc.)
router.get('/position/:position', getAdsByPosition);

// Get premium ads by type and position
router.get('/type/:type/position/:position', getAdsByTypeAndPosition);

// Specific homepage endpoints for convenience
router.get('/homepage/banners', getHomepageBannerAds);
router.get('/homepage/boxes', getHomepageBoxAds);

// Track ad impression
router.post('/:id/impression', trackImpression);

// Track ad click
router.post('/:id/click', trackClick);

module.exports = router;