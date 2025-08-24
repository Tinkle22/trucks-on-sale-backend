const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3001;

// Basic middleware
app.use(cors());
app.use(express.json());

// Test route
app.get('/', (req, res) => {
  res.json({ message: 'Test server is running!' });
});

// Finance application test route
app.post('/api/finance-applications', (req, res) => {
  console.log('Received finance application:', req.body);
  res.json({ 
    success: true, 
    message: 'Finance application received successfully',
    application: { id: 1, ...req.body }
  });
});

const server = app.listen(PORT, () => {
  console.log(`Test server is running on port ${PORT}`);
});

// Keep alive
setInterval(() => {
  console.log('Server is alive on port', PORT);
}, 30000);

process.on('SIGTERM', () => {
  console.log('SIGTERM received');
  server.close();
});

process.on('SIGINT', () => {
  console.log('SIGINT received');
  server.close();
});