// Version controller for handling app version checks
const fs = require('fs');
const path = require('path');

// Version configuration - update these when releasing new versions
const versionConfig = {
  latest_version: '1.0.2',
  minimum_version: '1.0.0',
  release_notes: 'Bug fixes and performance improvements. Enhanced vehicle search and improved user experience.',
  ios_url: 'https://apps.apple.com/app/trucks-on-sale/id123456789', // Replace with actual App Store URL
  android_url: 'https://play.google.com/store/apps/details?id=com.lesa2022.trucks24',
  // Removed force_update_below - all updates are now optional
  update_url: 'https://play.google.com/store/apps/details?id=com.lesa2022.trucks24' // Generic download page
};

// Function to compare version strings (semantic versioning)
const compareVersions = (version1, version2) => {
  const v1parts = version1.split('.').map(Number);
  const v2parts = version2.split('.').map(Number);
  
  // Ensure both arrays have the same length
  const maxLength = Math.max(v1parts.length, v2parts.length);
  while (v1parts.length < maxLength) v1parts.push(0);
  while (v2parts.length < maxLength) v2parts.push(0);
  
  for (let i = 0; i < maxLength; i++) {
    if (v1parts[i] > v2parts[i]) return 1;
    if (v1parts[i] < v2parts[i]) return -1;
  }
  return 0;
};

// Log version check for analytics (optional)
const logVersionCheck = (data) => {
  try {
    const logEntry = {
      timestamp: new Date().toISOString(),
      ...data
    };
    
    // You can log to file, database, or analytics service
    console.log('Version check:', logEntry);
    
    // Optional: Log to file
    // const logFile = path.join(__dirname, '../logs/version_checks.log');
    // fs.appendFileSync(logFile, JSON.stringify(logEntry) + '\n');
  } catch (error) {
    console.error('Error logging version check:', error);
  }
};

// Check app version
exports.checkVersion = async (req, res) => {
  try {
    // Handle both GET (query params) and POST (body) requests
    const data = req.method === 'GET' ? req.query : req.body;
    const {
      current_version = '1.0.0',
      build_number = '1',
      platform = 'unknown',
      app_id = 'trucks-on-sale'
    } = data;

    console.log('Version check request:', {
      current_version,
      build_number,
      platform,
      app_id,
      ip: req.ip
    });

    // Check if update is available
    const updateAvailable = compareVersions(versionConfig.latest_version, current_version) > 0;

    // All updates are now optional - no force updates
    const forceUpdate = false;

    // Log the version check
    logVersionCheck({
      current_version,
      build_number,
      platform,
      app_id,
      update_available: updateAvailable,
      force_update: forceUpdate,
      ip_address: req.ip,
      user_agent: req.get('User-Agent')
    });

    // Prepare response
    const response = {
      success: true,
      current_version,
      latest_version: versionConfig.latest_version,
      needs_update: updateAvailable,
      force_update: forceUpdate,
      release_notes: versionConfig.release_notes,
      update_url: versionConfig.update_url,
      ios_url: versionConfig.ios_url,
      android_url: versionConfig.android_url,
      minimum_version: versionConfig.minimum_version,
      platform,
      check_timestamp: Math.floor(Date.now() / 1000)
    };

    // Add platform-specific download URL
    if (platform === 'ios') {
      response.download_url = versionConfig.ios_url;
    } else if (platform === 'android') {
      response.download_url = versionConfig.android_url;
    } else {
      response.download_url = versionConfig.update_url;
    }

    res.json(response);

  } catch (error) {
    console.error('Version check error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error',
      message: 'Failed to check version'
    });
  }
};

// Get current version configuration (admin only)
exports.getVersionConfig = async (req, res) => {
  try {
    // In a real app, you'd check if user is admin
    // if (req.user?.user_type !== 'admin') {
    //   return res.status(403).json({ message: 'Admin access required' });
    // }

    res.json({
      success: true,
      config: versionConfig
    });
  } catch (error) {
    console.error('Get version config error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
};

// Update version configuration (admin only)
exports.updateVersionConfig = async (req, res) => {
  try {
    // In a real app, you'd check if user is admin
    // if (req.user?.user_type !== 'admin') {
    //   return res.status(403).json({ message: 'Admin access required' });
    // }

    const {
      latest_version,
      minimum_version,
      release_notes,
      ios_url,
      android_url,
      update_url
    } = req.body;

    // Validate version format
    const versionRegex = /^\d+\.\d+\.\d+$/;
    if (latest_version && !versionRegex.test(latest_version)) {
      return res.status(400).json({
        success: false,
        error: 'Invalid version format. Use semantic versioning (e.g., 1.0.0)'
      });
    }

    // Update configuration
    if (latest_version) versionConfig.latest_version = latest_version;
    if (minimum_version) versionConfig.minimum_version = minimum_version;
    if (release_notes) versionConfig.release_notes = release_notes;
    if (ios_url) versionConfig.ios_url = ios_url;
    if (android_url) versionConfig.android_url = android_url;
    if (update_url) versionConfig.update_url = update_url;

    console.log('Version configuration updated:', versionConfig);

    res.json({
      success: true,
      message: 'Version configuration updated successfully',
      config: versionConfig
    });

  } catch (error) {
    console.error('Update version config error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
};

// Get version check statistics (admin only)
exports.getVersionStats = async (req, res) => {
  try {
    // In a real app, you'd check if user is admin and fetch from database
    // This is a placeholder for version check analytics
    
    const stats = {
      total_checks: 0,
      unique_users: 0,
      platform_breakdown: {
        ios: 0,
        android: 0,
        other: 0
      },
      version_breakdown: {},
      recent_checks: []
    };

    res.json({
      success: true,
      stats
    });

  } catch (error) {
    console.error('Get version stats error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
};

module.exports = {
  checkVersion: exports.checkVersion,
  getVersionConfig: exports.getVersionConfig,
  updateVersionConfig: exports.updateVersionConfig,
  getVersionStats: exports.getVersionStats,
  compareVersions
};
