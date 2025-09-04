const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const path = require('path');
require('dotenv').config();

// Import routes
const userRoutes = require('./routes/userRoutes');
const vehicleRoutes = require('./routes/vehicleRoutes');
const inquiryRoutes = require('./routes/inquiryRoutes');
const subcategoryRoutes = require('./routes/subcategoryRoutes');
const categoryRoutes = require('./routes/categoryRoutes');
const auctionRoutes = require('./routes/auctionRoutes');
const vehicleAuctionRoutes = require('./routes/vehicleAuctionRoutes');
const financeApplicationRoutes = require('./routes/financeApplicationRoutes');
const hireBookingRoutes = require('./routes/hireBookingRoutes');
const rentToOwnBookingRoutes = require('./routes/rentToOwnBookingRoutes');
const premiumBackgroundRoutes = require('./routes/premiumBackgroundRoutes');
const premiumAdRoutes = require('./routes/premiumAdRoutes');
const versionRoutes = require('./routes/versionRoutes');
const contactFormRoutes = require('./routes/contactFormRoutes');

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(morgan('dev'));

// Static files
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Routes
app.use('/api/users', userRoutes);
app.use('/api/vehicles', vehicleRoutes);
app.use('/api/inquiries', inquiryRoutes);
app.use('/api/subcategories', subcategoryRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api/auctions', auctionRoutes);
app.use('/api/vehicle-auctions', vehicleAuctionRoutes);
app.use('/api/finance-applications', financeApplicationRoutes);
app.use('/api/hire-bookings', hireBookingRoutes);
app.use('/api/rent-to-own-bookings', rentToOwnBookingRoutes);
app.use('/api/premium-backgrounds', premiumBackgroundRoutes);
app.use('/api/premium-ads', premiumAdRoutes);
app.use('/api/version', versionRoutes);
app.use('/api/contact-forms', contactFormRoutes);

// Root route
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to Trucks on Sale API' });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    message: 'Something went wrong!',
    error: process.env.NODE_ENV === 'development' ? err.message : {}
  });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
