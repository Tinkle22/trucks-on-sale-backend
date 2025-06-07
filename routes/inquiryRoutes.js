const express = require('express');
const router = express.Router();
const inquiryController = require('../controllers/inquiryController');
const { check } = require('express-validator');

// All routes are now public
router.get('/vehicle/:vehicleId', inquiryController.getInquiriesByVehicle);
router.get('/user/:userId', inquiryController.getInquiriesByUser); 
router.get('/dealer/:dealerId', inquiryController.getInquiriesByDealer);
router.get('/:id', inquiryController.getInquiryById);

router.post('/', 
  [
    check('vehicle_id').isNumeric().withMessage('Vehicle ID is required'),
    check('user_id').isNumeric().withMessage('User ID is required'),
    check('message').notEmpty().withMessage('Message is required')
  ],
  inquiryController.createInquiry
);

router.put('/:id/status', inquiryController.updateInquiryStatus);
router.delete('/:id', inquiryController.deleteInquiry);

// Reply routes - Updated to match controller function names
router.post('/:id/replies', 
  [
    check('message').notEmpty().withMessage('Reply message is required'),
    check('user_id').isNumeric().withMessage('User ID is required')
  ],
  inquiryController.createReply
);

router.delete('/:id/replies/:replyId', inquiryController.deleteReply);

module.exports = router;