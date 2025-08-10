const PremiumAd = require('../models/PremiumAd');

// Get all active premium ads
const getAllActiveAds = async (req, res) => {
  try {
    const ads = await PremiumAd.getActiveAds();
    const formattedAds = ads.map(ad => ad.toFrontendFormat());
    
    res.json({
      success: true,
      ads: formattedAds,
      count: formattedAds.length
    });
  } catch (error) {
    console.error('Error in getAllActiveAds:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch premium ads',
      error: error.message
    });
  }
};

// Get premium ads by type (banner, box)
const getAdsByType = async (req, res) => {
  try {
    const { type } = req.params;
    
    if (!type) {
      return res.status(400).json({
        success: false,
        message: 'Ad type is required'
      });
    }

    const ads = await PremiumAd.getAdsByType(type);
    const formattedAds = ads.map(ad => ad.toFrontendFormat());
    
    res.json({
      success: true,
      data: formattedAds,
      count: formattedAds.length,
      type: type
    });
  } catch (error) {
    console.error('Error in getAdsByType:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch premium ads by type',
      error: error.message
    });
  }
};

// Get premium ads by position (homepage, listing, etc.)
const getAdsByPosition = async (req, res) => {
  try {
    const { position } = req.params;
    
    if (!position) {
      return res.status(400).json({
        success: false,
        message: 'Position is required'
      });
    }

    const ads = await PremiumAd.getAdsByPosition(position);
    const formattedAds = ads.map(ad => ad.toFrontendFormat());
    
    res.json({
      success: true,
      data: formattedAds,
      count: formattedAds.length,
      position: position
    });
  } catch (error) {
    console.error('Error in getAdsByPosition:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch premium ads by position',
      error: error.message
    });
  }
};

// Get premium ads by type and position
const getAdsByTypeAndPosition = async (req, res) => {
  try {
    const { type, position } = req.params;
    
    if (!type || !position) {
      return res.status(400).json({
        success: false,
        message: 'Both type and position are required'
      });
    }

    const ads = await PremiumAd.getAdsByTypeAndPosition(type, position);
    const formattedAds = ads.map(ad => ad.toFrontendFormat());
    
    res.json({
      success: true,
      data: formattedAds,
      count: formattedAds.length,
      type: type,
      position: position
    });
  } catch (error) {
    console.error('Error in getAdsByTypeAndPosition:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch premium ads by type and position',
      error: error.message
    });
  }
};

// Track ad impression
const trackImpression = async (req, res) => {
  try {
    const { id } = req.params;
    
    if (!id) {
      return res.status(400).json({
        success: false,
        message: 'Ad ID is required'
      });
    }

    // Check if ad exists
    const ad = await PremiumAd.getById(id);
    if (!ad) {
      return res.status(404).json({
        success: false,
        message: 'Premium ad not found'
      });
    }

    await PremiumAd.incrementImpression(id);
    
    res.json({
      success: true,
      message: 'Impression tracked successfully',
      adId: id
    });
  } catch (error) {
    console.error('Error in trackImpression:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to track impression',
      error: error.message
    });
  }
};

// Track ad click
const trackClick = async (req, res) => {
  try {
    const { id } = req.params;
    
    if (!id) {
      return res.status(400).json({
        success: false,
        message: 'Ad ID is required'
      });
    }

    // Check if ad exists
    const ad = await PremiumAd.getById(id);
    if (!ad) {
      return res.status(404).json({
        success: false,
        message: 'Premium ad not found'
      });
    }

    await PremiumAd.incrementClick(id);
    
    res.json({
      success: true,
      message: 'Click tracked successfully',
      adId: id,
      redirectUrl: ad.link_url
    });
  } catch (error) {
    console.error('Error in trackClick:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to track click',
      error: error.message
    });
  }
};

// Get homepage banner ads (full-width type)
const getHomepageBannerAds = async (req, res) => {
  try {
    const ads = await PremiumAd.getAdsByTypeAndPosition('banner', 'homepage');
    const formattedAds = ads.map(ad => ad.toFrontendFormat());
    
    res.json({
      success: true,
      ads: formattedAds,
      count: formattedAds.length
    });
  } catch (error) {
    console.error('Error in getHomepageBannerAds:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch homepage banner ads',
      error: error.message
    });
  }
};

// Get homepage box ads
const getHomepageBoxAds = async (req, res) => {
  try {
    const ads = await PremiumAd.getAdsByTypeAndPosition('box', 'homepage');
    const formattedAds = ads.map(ad => ad.toFrontendFormat());
    
    res.json({
      success: true,
      data: formattedAds,
      count: formattedAds.length
    });
  } catch (error) {
    console.error('Error in getHomepageBoxAds:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch homepage box ads',
      error: error.message
    });
  }
};

module.exports = {
  getAllActiveAds,
  getAdsByType,
  getAdsByPosition,
  getAdsByTypeAndPosition,
  trackImpression,
  trackClick,
  getHomepageBannerAds,
  getHomepageBoxAds
};