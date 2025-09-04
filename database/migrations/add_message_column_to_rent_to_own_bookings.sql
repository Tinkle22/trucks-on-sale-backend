-- Add message column to rent_to_own_bookings table
ALTER TABLE rent_to_own_bookings 
ADD COLUMN message TEXT AFTER down_payment;

-- Grant permissions for the updated table
GRANT SELECT, INSERT, UPDATE, DELETE ON rent_to_own_bookings TO 'anon'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON rent_to_own_bookings TO 'authenticated'@'%';