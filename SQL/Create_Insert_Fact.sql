USE superstore;

DROP TABLE IF EXISTS temp;
CREATE TEMPORARY TABLE temp (
SELECT 
	`Order ID` AS order_id ,
	TRIM(Customer_ID) AS customer_key,
	TRIM(Product_ID) AS product_key ,
	TRIM(CONCAT(Postal_Code,CONCAT('_',City))) AS postal_city ,
	DATE(Order_date) AS date_key,
	TRIM(Order_Mode) AS mode_key,
	Sales AS sales_price ,
	CAST(Cost_Price AS DECIMAL(10,2)) AS cost_price ,
	Quantity AS quantity ,
	CAST((Discount * 100) AS DECIMAL(10,2)) AS discount_pct,
	ROUND(Sales * (Discount* 100)) AS unit_price,
	ROUND((Sales - Cost_Price) / (Sales) * 100,2) AS unit_profit_margin,
	CASE WHEN Sales < 0 OR Cost_price < 0 THEN 'Negative_value' ELSE 'Positive_Value' END AS price_flag
FROM raw);

-- Facts Table
-- Only contains numeric and foreign key fields
-- Foreign key constraints defined
-- No NULLs in foreign keys

DROP TABLE IF EXISTS facts_table;
CREATE TABLE facts_table (
order_key INT AUTO_INCREMENT PRIMARY KEY,
order_id VARCHAR(20) NOT NULL,
customer_key INT NOT NULL, 
product_key INT NOT NULL,
location_key INT NOT NULL,
date_key INT NOT NULL,
mode_key INT NOT NULL,
sales_price DECIMAL(10,2) NOT NULL,
cost_price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
discount_pct DECIMAL(10,2) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
unit_profit_margin DECIMAL(10,2) NOT NULL,
price_flag VARCHAR(50) NOT NULL,
-- Foreign Key Constraints
FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
FOREIGN KEY (location_key) REFERENCES dim_location(location_key),
FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
FOREIGN KEY (mode_key) REFERENCES dim_order_mode(mode_key)
);


INSERT INTO facts_table (order_id,customer_key,product_key,location_key,date_key,mode_key,sales_price,cost_price,quantity,discount_pct,unit_price,unit_profit_margin,price_flag) 
SELECT
	t.order_id,
	c.customer_key,
	p.product_key,
	l.location_key,
	d.date_key,
	o.mode_key,
	t.sales_price,
	t.cost_price,
	t.quantity,
	t.discount_pct,
	t.unit_price,
	t.unit_profit_margin,
	t.price_flag
FROM temp t
LEFT JOIN dim_customer c ON c.customer_id = t.customer_key
LEFT JOIN dim_product p ON p.product_ID = t.product_key
LEFT JOIN dim_location l ON l.postal_city = t.postal_city
LEFT JOIN dim_date d ON d.order_date = t.date_key
LEFT JOIN dim_order_mode o ON o.order_mode = t.mode_key
WHERE price_flag = 'Positive_Value';

SELECT * FROM facts_table ;
