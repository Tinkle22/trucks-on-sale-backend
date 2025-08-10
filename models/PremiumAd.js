const db = require('../config/db');

class PremiumAd {
  constructor(data) {
    this.id = data.id;
    this.title = data.title;
    this.image_url = data.image_url;
    this.link_url = data.link_url;
    this.ad_type = data.ad_type;
    this.position = data.position;
    this.status = data.status;
    this.display_order = data.display_order;
    this.start_date = data.start_date;
    this.end_date = data.end_date;
    this.click_count = data.click_count;
    this.impression_count = data.impression_count;
    this.created_by = data.created_by;
    this.created_at = data.created_at;
    this.updated_at = data.updated_at;
  }

  // Get all active premium ads
  static async getActiveAds() {
    try {
      const query = `
        SELECT * FROM premium_ads 
        WHERE status = 'active' 
        AND (start_date IS NULL OR start_date <= CURDATE()) 
        AND (end_date IS NULL OR end_date >= CURDATE())
        ORDER BY display_order ASC, created_at DESC
      `;
      
      const [rows] = await db.execute(query);
      return rows.map(row => new PremiumAd(row));
    } catch (error) {
      console.error('Error fetching active premium ads:', error);
      throw error;
    }
  }

  // Get premium ads by type (banner, box)
  static async getAdsByType(adType) {
    try {
      const query = `
        SELECT * FROM premium_ads 
        WHERE status = 'active' 
        AND ad_type = ?
        AND (start_date IS NULL OR start_date <= CURDATE()) 
        AND (end_date IS NULL OR end_date >= CURDATE())
        ORDER BY display_order ASC, created_at DESC
      `;
      
      const [rows] = await db.execute(query, [adType]);
      return rows.map(row => new PremiumAd(row));
    } catch (error) {
      console.error('Error fetching premium ads by type:', error);
      throw error;
    }
  }

  // Get premium ads by position (homepage, listing, etc.)
  static async getAdsByPosition(position) {
    try {
      const query = `
        SELECT * FROM premium_ads 
        WHERE status = 'active' 
        AND position = ?
        AND (start_date IS NULL OR start_date <= CURDATE()) 
        AND (end_date IS NULL OR end_date >= CURDATE())
        ORDER BY display_order ASC, created_at DESC
      `;
      
      const [rows] = await db.execute(query, [position]);
      return rows.map(row => new PremiumAd(row));
    } catch (error) {
      console.error('Error fetching premium ads by position:', error);
      throw error;
    }
  }

  // Get premium ads by type and position
  static async getAdsByTypeAndPosition(adType, position) {
    try {
      const query = `
        SELECT * FROM premium_ads 
        WHERE status = 'active' 
        AND ad_type = ?
        AND position = ?
        AND (start_date IS NULL OR start_date <= CURDATE()) 
        AND (end_date IS NULL OR end_date >= CURDATE())
        ORDER BY display_order ASC, created_at DESC
      `;
      
      const [rows] = await db.execute(query, [adType, position]);
      return rows.map(row => new PremiumAd(row));
    } catch (error) {
      console.error('Error fetching premium ads by type and position:', error);
      throw error;
    }
  }

  // Increment impression count
  static async incrementImpression(adId) {
    try {
      const query = `
        UPDATE premium_ads 
        SET impression_count = impression_count + 1 
        WHERE id = ?
      `;
      
      await db.execute(query, [adId]);
      return true;
    } catch (error) {
      console.error('Error incrementing impression count:', error);
      throw error;
    }
  }

  // Increment click count
  static async incrementClick(adId) {
    try {
      const query = `
        UPDATE premium_ads 
        SET click_count = click_count + 1 
        WHERE id = ?
      `;
      
      await db.execute(query, [adId]);
      return true;
    } catch (error) {
      console.error('Error incrementing click count:', error);
      throw error;
    }
  }

  // Get ad by ID
  static async getById(id) {
    try {
      const query = 'SELECT * FROM premium_ads WHERE id = ?';
      const [rows] = await db.execute(query, [id]);
      
      if (rows.length === 0) {
        return null;
      }
      
      return new PremiumAd(rows[0]);
    } catch (error) {
      console.error('Error fetching premium ad by ID:', error);
      throw error;
    }
  }

  // Transform to frontend format
  toFrontendFormat() {
    // Construct full image URL if image_url exists
    let imageUrl = null;
    if (this.image_url) {
      // If it's already a full URL, use as is
      if (this.image_url.startsWith('http://') || this.image_url.startsWith('https://')) {
        imageUrl = this.image_url;
      } else {
        // Otherwise, prepend the trucks24.co.za domain
        imageUrl = `https://trucks24.co.za/listings/${this.image_url.replace(/^\//, '')}`;
      }
    }

    return {
      id: this.id.toString(),
      title: this.title,
      subtitle: null, // Can be added to database later if needed
      imageUrl: imageUrl,
      backgroundColor: '#bb1010', // Default color, can be added to database later
      icon: null, // Can be added to database later if needed
      ctaText: 'Learn More', // Default CTA, can be added to database later
      url: this.link_url,
      advertiser: 'Premium Advertiser', // Can be added to database later
      type: this.ad_type,
      position: this.position,
      displayOrder: this.display_order,
      clickCount: this.click_count,
      impressionCount: this.impression_count
    };
  }
}

module.exports = PremiumAd;