const db = require('./config/db');

async function testConnection() {
  try {
    // Try to execute a simple query
    const [result] = await db.query('SELECT 1');
    console.log('Database connection successful!');
    console.log('Test query result:', result);
    process.exit(0);
  } catch (error) {
    console.error('Database connection failed!');
    console.error(error);
    process.exit(1);
  }
}

testConnection();