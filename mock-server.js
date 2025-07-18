const express = require('express');
const cors = require('cors');

const app = express();
const PORT = 3001;

// Middleware
app.use(cors());
app.use(express.json());

// Mock vehicle data for testing
const mockVehicles = [
  {
    vehicle_id: 1,
    listing_type: 'sale',
    condition_type: 'used',
    condition_rating: 'excellent',
    color: 'White',
    engine_type: 'v8',
    make: 'Toyota',
    model: 'Hilux',
    year: 2020,
    price: 350000,
    category: 'trucks',
    no_accidents: 1,
    warranty: 1,
    finance_available: 1
  },
  {
    vehicle_id: 2,
    listing_type: 'hire',
    condition_type: 'used',
    condition_rating: 'good',
    color: 'Black',
    engine_type: 'v6',
    make: 'Ford',
    model: 'Ranger',
    year: 2019,
    price: 280000,
    category: 'trucks',
    no_accidents: 0,
    warranty: 0,
    finance_available: 1
  },
  {
    vehicle_id: 3,
    listing_type: 'sale',
    condition_type: 'new',
    condition_rating: 'excellent',
    color: 'Silver',
    engine_type: 'v8 turbo',
    make: 'Isuzu',
    model: 'D-Max',
    year: 2023,
    price: 450000,
    category: 'trucks',
    no_accidents: 1,
    warranty: 1,
    finance_available: 1
  },
  {
    vehicle_id: 4,
    listing_type: 'rent-to-own',
    condition_type: 'used',
    condition_rating: 'very_good',
    color: 'Red',
    engine_type: 'v6',
    make: 'Nissan',
    model: 'Navara',
    year: 2021,
    price: 320000,
    category: 'trucks',
    no_accidents: 1,
    warranty: 0,
    finance_available: 1
  },
  {
    vehicle_id: 5,
    listing_type: 'hire',
    condition_type: 'new',
    condition_rating: 'excellent',
    color: 'Blue',
    engine_type: 'v8',
    make: 'Mercedes',
    model: 'Actros',
    year: 2022,
    price: 850000,
    category: 'trucks',
    no_accidents: 1,
    warranty: 1,
    finance_available: 0
  },
  {
    vehicle_id: 6,
    listing_type: 'auction',
    condition_type: 'used',
    condition_rating: 'fair',
    color: 'White',
    engine_type: 'other',
    make: 'Volvo',
    model: 'FH',
    year: 2018,
    price: 650000,
    category: 'trucks',
    no_accidents: 0,
    warranty: 0,
    finance_available: 1
  }
];

// Mock the Vehicle.search method logic
function filterVehicles(vehicles, searchParams) {
  console.log('Mock server filtering with params:', JSON.stringify(searchParams, null, 2));
  
  let filtered = [...vehicles];
  
  for (const [key, value] of Object.entries(searchParams)) {
    if (value !== undefined && value !== null && value !== '') {
      console.log(`Applying filter: ${key} = ${value}`);
      
      if (key === 'listing_type' && value !== 'all') {
        filtered = filtered.filter(v => v.listing_type === value);
        console.log(`After listing_type filter: ${filtered.length} vehicles`);
      } else if (key === 'condition_type' && value !== 'all') {
        filtered = filtered.filter(v => v.condition_type === value);
        console.log(`After condition_type filter: ${filtered.length} vehicles`);
      } else if (key === 'condition_rating' && value !== 'all') {
        filtered = filtered.filter(v => v.condition_rating === value);
        console.log(`After condition_rating filter: ${filtered.length} vehicles`);
      } else if (key === 'color' && value !== 'All Colors') {
        filtered = filtered.filter(v => v.color === value);
        console.log(`After color filter: ${filtered.length} vehicles`);
      } else if (key === 'engine_type' && value !== 'all') {
        filtered = filtered.filter(v => v.engine_type === value);
        console.log(`After engine_type filter: ${filtered.length} vehicles`);
      } else if (key === 'no_accidents' && value == 1) {
        filtered = filtered.filter(v => v.no_accidents === 1);
        console.log(`After no_accidents filter: ${filtered.length} vehicles`);
      } else if (key === 'warranty' && value == 1) {
        filtered = filtered.filter(v => v.warranty === 1);
        console.log(`After warranty filter: ${filtered.length} vehicles`);
      } else if (key === 'finance_available' && value == 1) {
        filtered = filtered.filter(v => v.finance_available === 1);
        console.log(`After finance_available filter: ${filtered.length} vehicles`);
      } else if (key === 'category') {
        filtered = filtered.filter(v => v.category === value);
        console.log(`After category filter: ${filtered.length} vehicles`);
      }
    }
  }
  
  console.log(`Final filtered result: ${filtered.length} vehicles`);
  return filtered;
}

// Mock vehicles endpoint
app.get('/api/vehicles', (req, res) => {
  console.log('\n=== Mock API Request ===');
  console.log('Query params:', req.query);
  
  try {
    const { limit = 10, page = 1, ...filters } = req.query;
    
    // Apply filters
    const filteredVehicles = filterVehicles(mockVehicles, filters);
    
    // Apply pagination
    const startIndex = (page - 1) * limit;
    const endIndex = startIndex + parseInt(limit);
    const paginatedVehicles = filteredVehicles.slice(startIndex, endIndex);
    
    const response = {
      vehicles: paginatedVehicles,
      pagination: {
        total: filteredVehicles.length,
        page: parseInt(page),
        limit: parseInt(limit),
        pages: Math.ceil(filteredVehicles.length / limit)
      }
    };
    
    console.log(`Returning ${paginatedVehicles.length} vehicles out of ${filteredVehicles.length} total`);
    res.json(response);
  } catch (error) {
    console.error('Mock server error:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Root route
app.get('/', (req, res) => {
  res.json({ message: 'Mock Trucks on Sale API Server' });
});

app.listen(PORT, () => {
  console.log(`Mock server running on port ${PORT}`);
  console.log('Available mock vehicles:');
  mockVehicles.forEach(v => {
    console.log(`  ID: ${v.vehicle_id}, listing_type: ${v.listing_type}, condition_type: ${v.condition_type}, make: ${v.make} ${v.model}`);
  });
});
