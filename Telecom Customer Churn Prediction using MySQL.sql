-- Create a database
CREATE DATABASE TelecomDB;

-- Use the created database
USE TelecomDB;

-- Create customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    tenure INT, -- number of months the customer has been with the company
    monthly_charges DECIMAL(10, 2),
    total_charges DECIMAL(10, 2)
);

-- Insert sample data into customers table
INSERT INTO customers (customer_name, gender, age, tenure, monthly_charges, total_charges)
VALUES 
('John Doe', 'Male', 30, 12, 29.85, 358.20),
('Jane Smith', 'Female', 45, 24, 56.95, 1366.80),
('Alice Johnson', 'Female', 28, 5, 19.75, 98.75);

-- Create services table
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    service_type VARCHAR(50),
    usage DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert sample data into services table
INSERT INTO services (customer_id, service_type, usage)
VALUES 
(1, 'Internet', 200.50),
(1, 'Phone', 100.25),
(2, 'Internet', 300.75),
(2, 'Phone', 150.00),
(3, 'Internet', 120.50),
(3, 'Phone', 80.25);

-- Create churn table
CREATE TABLE churn (
    customer_id INT,
    churn BOOLEAN,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert sample data into churn table
INSERT INTO churn (customer_id, churn)
VALUES 
(1, FALSE),
(2, TRUE),
(3, FALSE);

SELECT 
    c.churn,
    AVG(cu.monthly_charges) AS avg_monthly_charges
FROM 
    churn c
JOIN 
    customers cu ON c.customer_id = cu.customer_id
GROUP BY 
    c.churn;
    
SELECT 
    c.churn,
    SUM(s.usage) AS total_usage
FROM 
    churn c
JOIN 
    services s ON c.customer_id = s.customer_id
GROUP BY 
    c.churn;
    
SELECT 
    customer_name, 
    monthly_charges, 
    tenure
FROM 
    customers
WHERE 
    monthly_charges > 50 AND tenure > 12;

