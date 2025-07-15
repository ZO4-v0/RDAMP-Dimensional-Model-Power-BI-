-- No Nulls in Fact Table
SELECT 
	COUNT( order_id), 
	COUNT( customer_key), 
	COUNT( product_key), 
	COUNT( date_key), 
	COUNT( mode_key),
	COUNT( sales_price),
	COUNT( cost_price),
	COUNT( quantity),
	COUNT( discount_pct),
	COUNT(unit_profit_margin)
FROM facts_table;
-- WHERE price_flag = 'Positive_Value';

-- Perform Data aggregation
DROP VIEW IF EXISTS vw_data_validation;
CREATE VIEW vw_data_validation AS (
SELECT 
	COUNT(f.order_id) AS cnt_order, 
	COUNT(DISTINCT f.customer_key) AS cnt_customer, 
	COUNT(DISTINCT f.product_key) AS cnt_products, 
	COUNT(DISTINCT f.date_key) AS cnt_dates, 
	COUNT(DISTINCT f.mode_key) AS cnt_mode,
	COUNT(DISTINCT p.product_category) AS cnt_category,
	COUNT(DISTINCT p.product_segment) AS cnt_segment,
	COUNT(DISTINCT l.country_name) AS cnt_country,
	COUNT(DISTINCT l.region_name) AS cnt_region,
	MIN(order_date) AS Earliest_date,
	MAX(order_date) AS Latest_date,
	SUM(sales_price*quantity) AS Total_SalesRevenue,
	SUM(cost_price*quantity) AS Total_Cost,
	SUM(sales_price*quantity) - SUM(cost_price*quantity) AS Total_Profit,
	SUM(quantity) AS Total_units_sold,
	ROUND((SUM(sales_price) - SUM(cost_price))/SUM(sales_price) * 100,2) AS Profit_Margin_pct,
	ROUND(AVG(discount_pct),2)  AS Avg_discount
FROM facts_table f
LEFT JOIN dim_customer c ON f.customer_key = c.customer_key
LEFT JOIN dim_date d ON  f.date_key = d.date_key
LEFT JOIN dim_location l ON  f.location_key = l.location_key
LEFT JOIN dim_order_mode o ON f.mode_key = o.mode_key
LEFT JOIN dim_product p ON f.product_key = p.product_key
);

SELECT *  FROM vw_data_validation;

-- Fact table Query

SELECT
	f.order_id,
	f.customer_key,
	f.product_key,
	f.location_key,
	f.date_key,
	f.mode_key,
	f.sales_price,
	f.cost_price,
	f.quantity,
	f.discount_pct,
	f.unit_price,
	f.unit_profit_margin,
	f.price_flag
FROM facts_table f
LEFT JOIN dim_customer c ON c.customer_id = f.customer_key
LEFT JOIN dim_product p ON p.product_ID = f.product_key
LEFT JOIN dim_location l ON l.location_key = f.location_key
LEFT JOIN dim_date d ON d.order_date = f.date_key
LEFT JOIN dim_order_mode o ON o.order_mode = f.mode_key
WHERE price_flag = 'Positive_Value';

SELECT * FROM facts_table;
