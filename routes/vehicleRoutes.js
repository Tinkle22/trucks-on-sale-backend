const express = require('express');
const router = express.Router();
const vehicleController = require('../controllers/vehicleController');
const upload = require('../middleware/upload');
const { check } = require('express-validator');

// All routes are now public
router.get('/', vehicleController.getAllVehicles);
router.get('/featured', vehicleController.getFeaturedVehicles);
router.get('/stats/all', vehicleController.getVehicleStats);

// New routes for makes and models - these must come before /:id route
router.get('/makes', vehicleController.getMakesByCategory);
router.get('/models', vehicleController.getModelsByMake);
router.get('/categories', vehicleController.getAllCategories);

// Routes with parameters
router.get('/:id', vehicleController.getVehicleById);
router.get('/dealer/:dealer_id', vehicleController.getDealerVehicles);

// Routes for creating and updating vehicles
router.post('/', 
  upload.fields([
    { name: 'images', maxCount: 10 },
    { name: 'videos', maxCount: 5 },
    { name: 'documents', maxCount: 5 }
  ]),
  [
    check('title').notEmpty().withMessage('Title is required'),
    check('description').notEmpty().withMessage('Description is required'),
    check('price').isNumeric().withMessage('Price must be a number'),
    check('category').notEmpty().withMessage('Category is required'),
    check('make').notEmpty().withMessage('Make is required'),
    check('model').notEmpty().withMessage('Model is required'),
    check('year').isNumeric().withMessage('Year must be a number'),
    check('dealer_id').notEmpty().withMessage('Dealer ID is required')
  ],
  vehicleController.createVehicle
);

router.put('/:id', 
  upload.fields([
    { name: 'images', maxCount: 10 },
    { name: 'videos', maxCount: 5 },
    { name: 'documents', maxCount: 5 }
  ]),
  vehicleController.updateVehicle
);

router.delete('/:id', vehicleController.deleteVehicle);
router.delete('/:id/images/:imageId', vehicleController.deleteVehicleImage);
router.delete('/:id/videos/:videoId', vehicleController.deleteVehicleVideo);
router.delete('/:id/documents/:documentId', vehicleController.deleteVehicleDocument);

router.put('/:id/images/:imageId/primary', vehicleController.setPrimaryImage);
router.put('/:id/featured', vehicleController.setFeatured);
router.put('/:id/status', vehicleController.setStatus);

module.exports = router;