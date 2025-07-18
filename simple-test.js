console.log('Testing filter logic...');

// Simple test of the filter parameters
const testParams = {
  listing_type: 'hire',
  condition_type: 'used',
  condition_rating: 'excellent',
  color: 'White',
  engine_type: 'v8',
  no_accidents: 1,
  warranty: 1
};

console.log('Test parameters:', testParams);

let whereConditions = [];
let queryParams = [];

for (const [key, value] of Object.entries(testParams)) {
  if (value !== undefined && value !== null && value !== '') {
    console.log(`Processing: ${key} = ${value}`);
    
    if (key === 'listing_type' && value !== 'all') {
      whereConditions.push('listing_type = ?');
      queryParams.push(value);
      console.log('✓ Added listing_type filter');
    } else if (key === 'condition_type' && value !== 'all') {
      whereConditions.push('condition_type = ?');
      queryParams.push(value);
      console.log('✓ Added condition_type filter');
    } else if (key === 'condition_rating' && value !== 'all') {
      whereConditions.push('condition_rating = ?');
      queryParams.push(value);
      console.log('✓ Added condition_rating filter');
    } else if (key === 'color' && value !== 'All Colors') {
      whereConditions.push('color = ?');
      queryParams.push(value);
      console.log('✓ Added color filter');
    } else if (key === 'engine_type' && value !== 'all') {
      whereConditions.push('engine_type = ?');
      queryParams.push(value);
      console.log('✓ Added engine_type filter');
    } else if (key === 'no_accidents' && value === 1) {
      whereConditions.push('no_accidents = 1');
      console.log('✓ Added no_accidents filter');
    } else if (key === 'warranty' && value === 1) {
      whereConditions.push('warranty = 1');
      console.log('✓ Added warranty filter');
    }
  }
}

console.log('\nGenerated conditions:', whereConditions);
console.log('Parameters:', queryParams);

const query = 'SELECT * FROM vehicles WHERE ' + whereConditions.join(' AND ');
console.log('\nFinal query:', query);

console.log('\n✅ Filter logic test completed successfully!');
