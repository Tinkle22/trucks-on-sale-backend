const multer = require('multer');
const path = require('path');

// Configure storage
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    if (file.fieldname === 'logo') {
      cb(null, 'uploads/logos/');
    } else {
      cb(null, 'uploads/');
    }
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now().toString(16)}_${file.originalname}`);
  }
});

// File filter
const fileFilter = (req, file, cb) => {
  // Check file type
  if (file.fieldname === 'images') {
    if (
      file.mimetype === 'image/jpeg' ||
      file.mimetype === 'image/png' ||
      file.mimetype === 'image/jpg'
    ) {
      cb(null, true);
    } else {
      cb(new Error('Only JPEG, JPG and PNG image files are allowed!'), false);
    }
  } else if (file.fieldname === 'logo') {
    if (
      file.mimetype === 'image/jpeg' ||
      file.mimetype === 'image/png' ||
      file.mimetype === 'image/jpg' ||
      file.mimetype === 'image/svg+xml'
    ) {
      cb(null, true);
    } else {
      cb(new Error('Only JPEG, JPG, PNG and SVG logo files are allowed!'), false);
    }
  } else if (file.fieldname === 'videos') {
    if (
      file.mimetype === 'video/mp4' ||
      file.mimetype === 'video/mpeg' ||
      file.mimetype === 'video/quicktime'
    ) {
      cb(null, true);
    } else {
      cb(new Error('Only MP4, MPEG and MOV video files are allowed!'), false);
    }
  } else if (file.fieldname === 'documents') {
    if (
      file.mimetype === 'application/pdf' ||
      file.mimetype === 'application/msword' ||
      file.mimetype === 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
    ) {
      cb(null, true);
    } else {
      cb(new Error('Only PDF, DOC and DOCX document files are allowed!'), false);
    }
  } else {
    cb(null, true);
  }
};

// Initialize upload
const upload = multer({
  storage: storage,
  limits: {
    fileSize: 10 * 1024 * 1024 // 10MB max file size
  },
  fileFilter: fileFilter
});

module.exports = upload;