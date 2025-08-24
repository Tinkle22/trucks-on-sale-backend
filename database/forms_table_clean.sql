-- SQL commands to create the forms table for contact form submissions and financing applications
-- This version has no foreign key constraints to avoid dependency issues

CREATE TABLE IF NOT EXISTS forms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Form type and basic info
    form_type ENUM('contact', 'finance') NOT NULL DEFAULT 'contact',
    
    -- Personal information (common to both forms)
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    name VARCHAR(255) NOT NULL, -- For backward compatibility with contact forms
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    
    -- Contact form specific fields
    subject VARCHAR(255),
    message TEXT,
    
    -- Finance application specific fields
    id_number VARCHAR(50), -- ID document number
    monthly_income DECIMAL(15,2), -- Monthly income amount
    employment_status ENUM('employed', 'self_employed', 'pensioner', 'other'),
    employer_name VARCHAR(255),
    years_employed DECIMAL(4,1), -- Years employed (can be decimal like 2.5)
    deposit_amount DECIMAL(15,2), -- Deposit amount
    loan_term INT, -- Loan term in months
    vehicle_id INT, -- Reference to specific vehicle
    additional_info TEXT, -- Additional information
    
    -- Common fields
    dealership_id INT,
    dealership_name VARCHAR(255),
    status ENUM('new', 'read', 'replied', 'approved', 'rejected', 'closed') DEFAULT 'new',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Add foreign key constraints
ALTER TABLE forms 
ADD CONSTRAINT fk_forms_dealership 
FOREIGN KEY (dealership_id) REFERENCES users(user_id) 
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE forms 
ADD CONSTRAINT fk_forms_vehicle 
FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) 
ON DELETE SET NULL ON UPDATE CASCADE;

-- Create indexes separately for better compatibility
CREATE INDEX IF NOT EXISTS idx_form_type ON forms(form_type);
CREATE INDEX IF NOT EXISTS idx_dealership_id ON forms(dealership_id);
CREATE INDEX IF NOT EXISTS idx_vehicle_id ON forms(vehicle_id);
CREATE INDEX IF NOT EXISTS idx_status ON forms(status);
CREATE INDEX IF NOT EXISTS idx_created_at ON forms(created_at);
CREATE INDEX IF NOT EXISTS idx_email ON forms(email);
CREATE INDEX IF NOT EXISTS idx_employment_status ON forms(employment_status);