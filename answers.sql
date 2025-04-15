-- Create and use the database
DROP DATABASE IF EXISTS business_data;
CREATE DATABASE business_data;
USE business_data;

-- Drop tables if they exist to avoid Error 1050 or 1062
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orderdetails;

-- Create payments table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    check_number VARCHAR(20),
    payment_date DATE,
    amount DECIMAL(10, 2)
);

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    country VARCHAR(50),
    credit_limit DECIMAL(10, 2)
);

-- Create orderdetails table
CREATE TABLE orderdetails (
    order_id INT,
    product_code VARCHAR(50),
    quantity_ordered INT,
    price_each DECIMAL(10, 2)
);

-- Insert sample data into payments
INSERT INTO payments (customer_id, check_number, payment_date, amount) VALUES
(1, 'CHK001', '2024-04-10', 120.50),
(2, 'CHK002', '2024-04-11', 220.75),
(3, 'CHK003', '2024-04-12', 150.00),
(1, 'CHK004', '2024-04-13', 310.40),
(2, 'CHK005', '2024-04-14', 500.00),
(3, 'CHK006', '2024-04-14', 250.30);

-- Insert sample data into customers
INSERT INTO customers (customer_id, customer_name, country, credit_limit) VALUES
(1, 'John Doe', 'USA', 5000.00),
(2, 'Jane Smith', 'UK', 7000.00),
(3, 'Ali Hassan', 'Kenya', 3000.00);

-- Insert sample data into orderdetails
INSERT INTO orderdetails (order_id, product_code, quantity_ordered, price_each) VALUES
(101, 'P001', 10, 15.00),
(102, 'P002', 5, 25.00),
(103, 'P001', 7, 15.00),
(104, 'P003', 3, 100.00);

-- ========================================
-- ✅ Question 1
-- Show total payment amount for each payment date (Top 5 latest)

SELECT 
    payment_date,
    SUM(amount) AS total_amount
FROM 
    payments
GROUP BY 
    payment_date
ORDER BY 
    payment_date DESC
LIMIT 5;

-- ========================================
-- ✅ Question 2
-- Find average credit limit of each customer

SELECT 
    customer_name,
    country,
    AVG(credit_limit) AS average_credit_limit
FROM 
    customers
GROUP BY 
    customer_name, country;

-- ========================================
-- ✅ Question 3
-- Find total price of products ordered

SELECT 
    product_code,
    quantity_ordered,
    SUM(quantity_ordered * price_each) AS total_price
FROM 
    orderdetails
GROUP BY 
    product_code, quantity_ordered;

-- ========================================
-- ✅ Question 4
-- Find highest payment amount for each check number

SELECT 
    check_number,
    MAX(amount) AS highest_amount
FROM 
    payments
GROUP BY 
    check_number;
