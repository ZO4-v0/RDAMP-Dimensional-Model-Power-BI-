USE superstore;

-- DATA MODELLING 
-- Dimension Schema
-- Surrogate primary keys used
-- Cleaned and deduplicated
-- All text fields are trimmed and standardized (UPPERCASE for categorical fields)
-- Denormalized Star Schema

SET FOREIGN_KEY_CHECKS=1;


-- Customer DIMENSION
-- Unique Customer with surrogate keys
-- Enable customer center analysis and segmentation
-- DO NOT INCLUDE locations
-- Location in the dataset is reference to store location per order_id
-- Customer_id can have multiple location depends where the order was made.
DROP TABLE IF EXISTS dim_customer;
CREATE TABLE dim_customer (
customer_key INT AUTO_INCREMENT PRIMARY KEY,
customer_ID VARCHAR(26) NOT NULL
);


-- Product Dimension 
-- Unique products and heirachy by Category and Segment
-- This will support product performance analysis and segmentations
DROP TABLE IF EXISTS dim_product;
CREATE TABLE dim_product (
product_key INT AUTO_INCREMENT PRIMARY KEY,
product_ID VARCHAR(26) NOT NULL,
product_name VARCHAR(50) NOT NULL,
product_category VARCHAR(26) NOT NULL,
product_segment VARCHAR(100) NOT NULL,
product_subcat VARCHAR(100) NOT NULL
);

-- location Dimension 
-- Geographic Dimension of stores
-- Use Postal_city as surrogate key 
-- Concat( postal and City )
-- This will support regional comparisons
DROP TABLE IF EXISTS dim_location;
CREATE TABLE dim_location (
location_key INT AUTO_INCREMENT PRIMARY KEY,
postal_city VARCHAR(20) NOT NULL,
postal_code VARCHAR(4) NOT NULL,
city_name VARCHAR(10) NOT NULL,
region_name VARCHAR(24) NOT NULL,
country_name VARCHAR(16) NOT NULL
);

-- date Dimension 
-- Timme & date dimension
-- Normalize date
-- This will support time-based analysis and trend
DROP TABLE IF EXISTS dim_date;
CREATE TABLE dim_date (
date_key INT AUTO_INCREMENT PRIMARY KEY,
order_date DATE NOT NULL,
order_year INT NOT NULL,
order_month INT NOT NULL,
month_name VARCHAR(10) NOT NULL,
quarter_num VARCHAR(2) NOT NULL,
yearmonth INT NOT NULL,
quarter_year VARCHAR(20) NOT NULL 
);


-- Order Mode Dimension 
-- Instore vs Online analysis 
DROP TABLE IF EXISTS dim_order_mode;
CREATE TABLE dim_order_mode(
mode_key INT AUTO_INCREMENT PRIMARY KEY,
order_mode VARCHAR(26) NOT NULL
);


-- DATA LOADING
-- Load Dimension Tables

-- Load dim_customers
-- Clean and Trim data
INSERT INTO dim_customer(customer_ID)
SELECT DISTINCT 
	TRIM(Customer_ID) AS customer_id
FROM superstore.raw
WHERE Customer_ID IS NOT NULL ; 

-- Load dim_product
-- Clean and Trim data
INSERT INTO dim_product ( product_ID , product_name , product_category , product_segment ,product_subcat)
SELECT DISTINCT
	TRIM(Product_ID) AS product_ID,
   TRIM(Product_Name) AS product_name,
   TRIM(Category) AS product_category,
	TRIM(Segment) AS product_segment,
	TRIM(Sub_Category) AS product_subcat
FROM superstore.raw
WHERE Product_ID IS NOT NULL;

-- Load dim_location
-- Clean and Trim data
-- Concat Postal_city
INSERT INTO dim_location (postal_city, postal_code , city_name , region_name , country_name) 
SELECT DISTINCT 
	TRIM(CONCAT(Postal_Code,CONCAT('_',City))) AS postal_city,
	TRIM(Postal_Code) AS postal_code,
   TRIM(City) AS city_name,
   TRIM(Region) AS region_name,
	TRIM(Country) AS country_name
FROM superstore.raw
WHERE City IS NOT NULL ; 


-- Load dim_date
-- Create Single column for Year , Month , MonthName , QuarterYear , YearMonth
INSERT INTO dim_date(order_date,order_year,order_month,month_name,quarter_num,yearmonth,quarter_year)
SELECT DISTINCT 
	DATE(Order_date) AS order_date ,
	YEAR(Order_date) AS order_year ,
	MONTH(Order_date) AS order_month,
	MONTHNAME(Order_date) AS month_name ,
	CONCAT("Q",QUARTER(Order_date)) AS quarter_num ,
	YEAR(Order_date) * 100 + MONTH(Order_date) AS yearmonth ,
	CONCAT(RIGHT(YEAR(Order_date),2),'-',CONCAT("Q",QUARTER(Order_date))) AS quarter_year
FROM superstore.raw
WHERE Order_date IS NOT NULL;



-- Load dim_order_mode
-- Clean and Trim data
INSERT INTO dim_order_mode(order_mode)
SELECT DISTINCT 
	TRIM(Order_Mode) AS order_mode 
FROM superstore.raw
WHERE Order_Mode IS NOT NULL ;

