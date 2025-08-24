-- SQL script to add logo column to users table for dealership logos
-- Execute this command in your MySQL/MariaDB database

-- Add logo column to users table
ALTER TABLE `users` 
ADD COLUMN `logo` VARCHAR(255) DEFAULT NULL 
AFTER `profile_image`;

-- Optional: Add comment to the column for documentation
ALTER TABLE `users` 
MODIFY COLUMN `logo` VARCHAR(255) DEFAULT NULL COMMENT 'Dealership logo file path/URL';

-- Verify the column was added successfully
-- DESCRIBE users;

-- Example usage after adding the column:
-- UPDATE users SET logo = 'uploads/logos/dealership_logo.jpg' WHERE user_id = 2 AND user_type = 'dealer';

/*
Notes:
- The logo column is added after profile_image column
- It accepts VARCHAR(255) to store file paths or URLs
- Default value is NULL (no logo)
- This column is intended for dealerships to store their company logos
- You can store either relative file paths (e.g., 'uploads/logos/company.jpg') or full URLs
*/