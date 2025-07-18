const Vehicle = require('../models/Vehicle');
const VehicleImage = require('../models/VehicleImage');
const VehicleVideo = require('../models/VehicleVideo');
const VehicleDocument = require('../models/VehicleDocument');
const fs = require('fs');
const path = require('path');
const { validationResult } = require('express-validator');

// Get all vehicles with filtering and pagination
exports.getAllVehicles = async (req, res) => {
  try {
    console.log('getAllVehicles called with query params:', JSON.stringify(req.query, null, 2));

    const {
      category, subcategory_id, make, model, variant, year_min, year_max,
      price_min, price_max, mileage_min, mileage_max, hours_min, hours_max,
      region, city, condition, condition_type, condition_rating,
      fuel_type, transmission, engine_type, color, horsepower_min, horsepower_max,
      listing_type, no_accidents, warranty, finance_available, trade_in,
      service_history, roadworthy, featured, search_term,
      page = 1, limit = 15, sort = 'created_at', order = 'desc', random = 'false'
    } = req.query;

    // Build filter object
    const filters = {};
    if (category) filters.category = category;
    if (subcategory_id) filters.subcategory_id = subcategory_id;
    if (make) {
      // Handle comma-separated makes
      const makes = make.split(',');
      if (makes.length > 1) {
        filters.make = makes;
      } else {
        filters.make = make;
      }
    }
    if (model) filters.model = model;
    if (variant) filters.variant = variant;
    if (region) filters.region = region;
    if (city) filters.city = city;
    if (condition) filters.condition_type = condition;
    if (condition_type) filters.condition_type = condition_type;
    if (condition_rating) filters.condition_rating = condition_rating;
    if (fuel_type) filters.fuel_type = fuel_type;
    if (transmission) filters.transmission = transmission;
    if (engine_type) filters.engine_type = engine_type;
    if (color) filters.color = color;
    if (listing_type) filters.listing_type = listing_type;

    // Feature filters (boolean values)
    if (no_accidents === 'true' || no_accidents === true) filters.no_accidents = 1;
    if (warranty === 'true' || warranty === true) filters.warranty = 1;
    if (finance_available === 'true' || finance_available === true) filters.finance_available = 1;
    if (trade_in === 'true' || trade_in === true) filters.trade_in = 1;
    if (service_history === 'true' || service_history === true) filters.service_history = 1;
    if (roadworthy === 'true' || roadworthy === true) filters.roadworthy = 1;
    if (featured === 'true' || featured === true) filters.featured = 1;

    // For range filters and search term, we'll handle them in the search method
    const searchParams = {
      ...filters,
      year_min,
      year_max,
      price_min,
      price_max,
      mileage_min,
      mileage_max,
      hours_min,
      hours_max,
      horsepower_min,
      horsepower_max,
      search_term
    };

    // Use random ordering if requested
    const finalSort = random === 'true' ? 'random' : sort;
    const result = await Vehicle.search(searchParams, page, limit, finalSort, order);

    // Get images for each vehicle
    for (const vehicle of result.vehicles) {
      vehicle.images = await VehicleImage.findByVehicleId(vehicle.vehicle_id);
    }

    res.json(result);
  } catch (error) {
    console.error('Get all vehicles error:', error);
    res.status(500).json({ message: 'Server error while fetching vehicles' });
  }
};

// Get vehicle by ID
exports.getVehicleById = async (req, res) => {
  try {
    const { id } = req.params;
    
    const vehicle = await Vehicle.findById(id);
    if (!vehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    // Get related data
    vehicle.images = await VehicleImage.findByVehicleId(id);
    vehicle.videos = await VehicleVideo.findByVehicleId(id);
    vehicle.documents = await VehicleDocument.findByVehicleId(id);
    
    res.json({ vehicle });
  } catch (error) {
    console.error('Get vehicle by ID error:', error);
    res.status(500).json({ message: 'Server error while fetching vehicle' });
  }
};

// Create new vehicle
exports.createVehicle = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    // Set dealer_id from authenticated user
    req.body.dealer_id = req.user.user_id;
    
    // Create vehicle
    const vehicle = await Vehicle.create(req.body);
    
    // Handle file uploads if any
    if (req.files) {
      // Handle images
      if (req.files.images) {
        const images = Array.isArray(req.files.images) ? req.files.images : [req.files.images];
        
        for (let i = 0; i < images.length; i++) {
          const image = images[i];
          const imagePath = '/uploads/' + image.filename;
          
          await VehicleImage.create({
            vehicle_id: vehicle.vehicle_id,
            image_path: imagePath,
            is_primary: i === 0 ? 1 : 0 // First image is primary
          });
        }
      }
      
      // Handle videos
      if (req.files.videos) {
        const videos = Array.isArray(req.files.videos) ? req.files.videos : [req.files.videos];
        
        for (const video of videos) {
          const videoPath = '/uploads/' + video.filename;
          
          await VehicleVideo.create({
            vehicle_id: vehicle.vehicle_id,
            video_path: videoPath
          });
        }
      }
      
      // Handle documents
      if (req.files.documents) {
        const documents = Array.isArray(req.files.documents) ? req.files.documents : [req.files.documents];
        
        for (const document of documents) {
          const documentPath = '/uploads/' + document.filename;
          
          await VehicleDocument.create({
            vehicle_id: vehicle.vehicle_id,
            document_name: document.originalname,
            document_path: documentPath,
            document_type: path.extname(document.originalname).substring(1)
          });
        }
      }
    }
    
    // Get the created vehicle with all related data
    const createdVehicle = await Vehicle.findById(vehicle.vehicle_id);
    createdVehicle.images = await VehicleImage.findByVehicleId(vehicle.vehicle_id);
    createdVehicle.videos = await VehicleVideo.findByVehicleId(vehicle.vehicle_id);
    createdVehicle.documents = await VehicleDocument.findByVehicleId(vehicle.vehicle_id);
    
    res.status(201).json({
      message: 'Vehicle created successfully',
      vehicle: createdVehicle
    });
  } catch (error) {
    console.error('Create vehicle error:', error);
    res.status(500).json({ message: 'Server error while creating vehicle' });
  }
};

// Update vehicle
exports.updateVehicle = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    
    // Check if vehicle exists and belongs to the dealer
    const existingVehicle = await Vehicle.findById(id);
    if (!existingVehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    if (existingVehicle.dealer_id !== req.user.user_id && req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to update this vehicle' });
    }
    
    // Update vehicle
    const updated = await Vehicle.update(id, req.body);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update vehicle' });
    }
    
    // Handle file uploads if any
    if (req.files) {
      // Handle images
      if (req.files.images) {
        const images = Array.isArray(req.files.images) ? req.files.images : [req.files.images];
        
        for (const image of images) {
          const imagePath = '/uploads/' + image.filename;
          
          await VehicleImage.create({
            vehicle_id: id,
            image_path: imagePath,
            is_primary: 0 // New images are not primary by default
          });
        }
      }
      
      // Handle videos
      if (req.files.videos) {
        const videos = Array.isArray(req.files.videos) ? req.files.videos : [req.files.videos];
        
        for (const video of videos) {
          const videoPath = '/uploads/' + video.filename;
          
          await VehicleVideo.create({
            vehicle_id: id,
            video_path: videoPath
          });
        }
      }
      
      // Handle documents
      if (req.files.documents) {
        const documents = Array.isArray(req.files.documents) ? req.files.documents : [req.files.documents];
        
        for (const document of documents) {
          const documentPath = '/uploads/' + document.filename;
          
          await VehicleDocument.create({
            vehicle_id: id,
            document_name: document.originalname,
            document_path: documentPath,
            document_type: path.extname(document.originalname).substring(1)
          });
        }
      }
    }
    
    // Get the updated vehicle with all related data
    const updatedVehicle = await Vehicle.findById(id);
    updatedVehicle.images = await VehicleImage.findByVehicleId(id);
    updatedVehicle.videos = await VehicleVideo.findByVehicleId(id);
    updatedVehicle.documents = await VehicleDocument.findByVehicleId(id);
    
    res.json({
      message: 'Vehicle updated successfully',
      vehicle: updatedVehicle
    });
  } catch (error) {
    console.error('Update vehicle error:', error);
    res.status(500).json({ message: 'Server error while updating vehicle' });
  }
};

// Delete vehicle
exports.deleteVehicle = async (req, res) => {
  try {
    const { id } = req.params;
    
    // Check if vehicle exists and belongs to the dealer
    const existingVehicle = await Vehicle.findById(id);
    if (!existingVehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    if (existingVehicle.dealer_id !== req.user.user_id && req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to delete this vehicle' });
    }
    
    // Get all files to delete
    const images = await VehicleImage.findByVehicleId(id);
    const videos = await VehicleVideo.findByVehicleId(id);
    const documents = await VehicleDocument.findByVehicleId(id);
    
    // Delete files from storage
    const deleteFile = (filePath) => {
      const fullPath = path.join(__dirname, '..', filePath);
      if (fs.existsSync(fullPath)) {
        fs.unlinkSync(fullPath);
      }
    };
    
    images.forEach(image => deleteFile(image.image_path));
    videos.forEach(video => deleteFile(video.video_path));
    documents.forEach(document => deleteFile(document.document_path));
    
    // Delete related records from database
    await VehicleImage.deleteByVehicleId(id);
    await VehicleVideo.deleteByVehicleId(id);
    await VehicleDocument.deleteByVehicleId(id);
    
    // Delete vehicle
    const deleted = await Vehicle.delete(id);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete vehicle' });
    }
    
    res.json({ message: 'Vehicle deleted successfully' });
  } catch (error) {
    console.error('Delete vehicle error:', error);
    res.status(500).json({ message: 'Server error while deleting vehicle' });
  }
};

// Delete vehicle image
exports.deleteVehicleImage = async (req, res) => {
  try {
    const { id, imageId } = req.params;
    
    // Check if vehicle exists and belongs to the dealer
    const existingVehicle = await Vehicle.findById(id);
    if (!existingVehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    if (existingVehicle.dealer_id !== req.user.user_id && req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to modify this vehicle' });
    }
    
    // Get image to delete
    const [image] = await db.query('SELECT * FROM vehicle_images WHERE image_id = ?', [imageId]);
    
    if (!image || image.length === 0) {
      return res.status(404).json({ message: 'Image not found' });
    }
    
    // Delete file from storage
    const fullPath = path.join(__dirname, '..', image[0].image_path);
    if (fs.existsSync(fullPath)) {
      fs.unlinkSync(fullPath);
    }
    
    // Delete image record
    const deleted = await VehicleImage.delete(imageId);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete image' });
    }
    
    // If deleted image was primary, set another image as primary
    if (image[0].is_primary) {
      const remainingImages = await VehicleImage.findByVehicleId(id);
      if (remainingImages.length > 0) {
        await VehicleImage.setPrimary(remainingImages[0].image_id, id);
      }
    }
    
    res.json({ message: 'Image deleted successfully' });
  } catch (error) {
    console.error('Delete vehicle image error:', error);
    res.status(500).json({ message: 'Server error while deleting image' });
  }
};

// Set primary image
exports.setPrimaryImage = async (req, res) => {
  try {
    const { id, imageId } = req.params;
    
    // Check if vehicle exists and belongs to the dealer
    const existingVehicle = await Vehicle.findById(id);
    if (!existingVehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    if (existingVehicle.dealer_id !== req.user.user_id && req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to modify this vehicle' });
    }
    
    // Set primary image
    const updated = await VehicleImage.setPrimary(imageId, id);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to set primary image' });
    }
    
    res.json({ message: 'Primary image set successfully' });
  } catch (error) {
    console.error('Set primary image error:', error);
    res.status(500).json({ message: 'Server error while setting primary image' });
  }
};

// Get dealer vehicles
exports.getDealerVehicles = async (req, res) => {
  try {
    const { dealer_id } = req.params;
    const { page = 1, limit = 10 } = req.query;

    console.log('getDealerVehicles called with params:', { dealer_id, page, limit });

    // Check if dealer exists
    // This would require a User model, but we'll assume it exists
    // const dealer = await User.findById(dealer_id);
    // if (!dealer) {
    //   return res.status(404).json({ message: 'Dealer not found' });
    // }

    // Get dealer vehicles with pagination
    const result = await Vehicle.getByDealer(dealer_id, page, limit);
    
    // Get images for each vehicle
    for (const vehicle of result.vehicles) {
      vehicle.images = await VehicleImage.findByVehicleId(vehicle.vehicle_id);
    }

    console.log(`Found ${result.vehicles.length} vehicles for dealer ${dealer_id}`);
    res.json(result);
  } catch (error) {
    console.error('Get dealer vehicles error:', error);
    res.status(500).json({ message: 'Server error while fetching dealer vehicles' });
  }
};

// Get featured vehicles
exports.getFeaturedVehicles = async (req, res) => {
  try {
    const { limit = 15, random = 'false', category = 'trucks' } = req.query;
    const isRandom = random === 'true';

    // Get featured vehicles
    const vehicles = await Vehicle.getFeatured(limit, isRandom, category);

    // Get images for each vehicle
    for (const vehicle of vehicles) {
      vehicle.images = await VehicleImage.findByVehicleId(vehicle.vehicle_id);
    }

    res.json({ vehicles });
  } catch (error) {
    console.error('Get featured vehicles error:', error);
    res.status(500).json({ message: 'Server error while fetching featured vehicles' });
  }
};

// Set vehicle as featured
exports.setFeatured = async (req, res) => {
  try {
    const { id } = req.params;
    const { featured } = req.body;
    
    // Check if vehicle exists
    const existingVehicle = await Vehicle.findById(id);
    if (!existingVehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    // Only admin can set featured status
    if (req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to set featured status' });
    }
    
    // Update featured status
    const updated = await Vehicle.setFeatured(id, featured);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update featured status' });
    }
    
    res.json({ message: `Vehicle ${featured ? 'set as featured' : 'removed from featured'}` });
  } catch (error) {
    console.error('Set featured error:', error);
    res.status(500).json({ message: 'Server error while setting featured status' });
  }
};

// Set vehicle status (available, sold, reserved)
exports.setStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;
    
    // Validate status
    if (!['available', 'sold', 'reserved'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status value' });
    }
    
    // Check if vehicle exists and belongs to the dealer
    const existingVehicle = await Vehicle.findById(id);
    if (!existingVehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    if (existingVehicle.dealer_id !== req.user.user_id && req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to update this vehicle' });
    }
    
    // Update status
    const updated = await Vehicle.updateStatus(id, status);
    
    if (!updated) {
      return res.status(500).json({ message: 'Failed to update status' });
    }
    
    res.json({ message: `Vehicle status updated to ${status}` });
  } catch (error) {
    console.error('Set status error:', error);
    res.status(500).json({ message: 'Server error while setting status' });
  }
};

// Get vehicle statistics
exports.getVehicleStats = async (req, res) => {
  try {
    // Only admin can access statistics
    if (req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to access statistics' });
    }
    
    const stats = await Vehicle.getStatistics();
    res.json({ stats });
  } catch (error) {
    console.error('Get vehicle stats error:', error);
    res.status(500).json({ message: 'Server error while fetching statistics' });
  }
};

// Delete vehicle video
exports.deleteVehicleVideo = async (req, res) => {
  try {
    const { id, videoId } = req.params;
    
    // Check if vehicle exists and belongs to the dealer
    const existingVehicle = await Vehicle.findById(id);
    if (!existingVehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    if (existingVehicle.dealer_id !== req.user.user_id && req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to modify this vehicle' });
    }
    
    // Get video to delete
    const video = await VehicleVideo.findById(videoId);
    
    if (!video) {
      return res.status(404).json({ message: 'Video not found' });
    }
    
    // Delete file from storage
    const fullPath = path.join(__dirname, '..', video.video_path);
    if (fs.existsSync(fullPath)) {
      fs.unlinkSync(fullPath);
    }
    
    // Delete video record
    const deleted = await VehicleVideo.delete(videoId);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete video' });
    }
    
    res.json({ message: 'Video deleted successfully' });
  } catch (error) {
    console.error('Delete vehicle video error:', error);
    res.status(500).json({ message: 'Server error while deleting video' });
  }
};

// Delete vehicle document
exports.deleteVehicleDocument = async (req, res) => {
  try {
    const { id, documentId } = req.params;
    
    // Check if vehicle exists and belongs to the dealer
    const existingVehicle = await Vehicle.findById(id);
    if (!existingVehicle) {
      return res.status(404).json({ message: 'Vehicle not found' });
    }
    
    if (existingVehicle.dealer_id !== req.user.user_id && req.user.user_type !== 'admin') {
      return res.status(403).json({ message: 'Not authorized to modify this vehicle' });
    }
    
    // Get document to delete
    const document = await VehicleDocument.findById(documentId);
    
    if (!document) {
      return res.status(404).json({ message: 'Document not found' });
    }
    
    // Delete file from storage
    const fullPath = path.join(__dirname, '..', document.document_path);
    if (fs.existsSync(fullPath)) {
      fs.unlinkSync(fullPath);
    }
    
    // Delete document record
    const deleted = await VehicleDocument.delete(documentId);
    
    if (!deleted) {
      return res.status(500).json({ message: 'Failed to delete document' });
    }
    
    res.json({ message: 'Document deleted successfully' });
  } catch (error) {
    console.error('Delete vehicle document error:', error);
    res.status(500).json({ message: 'Server error while deleting document' });
  }
};

// Get makes by category
exports.getMakesByCategory = async (req, res) => {
  try {
    const { category } = req.query;
    
    if (!category) {
      return res.status(400).json({ message: 'Category is required' });
    }

    const makes = await Vehicle.getMakesByCategory(category);
    res.json(makes);
  } catch (error) {
    console.error('Get makes by category error:', error);
    res.status(500).json({ message: 'Server error while fetching makes' });
  }
};

// Get models by make and category
exports.getModelsByMake = async (req, res) => {
  try {
    const { make, category } = req.query;

    if (!make || !category) {
      return res.status(400).json({ message: 'Make and category are required' });
    }

    const models = await Vehicle.getModelsByMake(make, category);
    res.json(models);
  } catch (error) {
    console.error('Get models by make error:', error);
    res.status(500).json({ message: 'Server error while fetching models' });
  }
};

// Get all unique categories
exports.getAllCategories = async (req, res) => {
  try {
    const categories = await Vehicle.getAllCategories();
    res.json({ categories });
  } catch (error) {
    console.error('Get all categories error:', error);
    res.status(500).json({ message: 'Server error while fetching categories' });
  }
};