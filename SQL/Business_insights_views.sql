USE superstore;

-- Top products per quarter
-- Product performance trends quarter-on-quarter


DROP VIEW IF EXISTS vw_product_seasonality;
CREATE VIEW vw_product_seasonality AS (
SELECT 

	quarter_year,
	DENSE_RANK() OVER(PARTITION BY quarter_year ORDER BY 	ROUND((SUM(sales_price*Quantity) - SUM(cost_price*Quantity))/SUM(sales_price*Quantity) * 100,2) DESC )  AS ranking,
	Product_name,
	MIN(order_date) AS start_date,
	MAX(order_date) AS end_date,
	-- KPI ( Reusable SQL Query) 
		( SUM(sales_price*quantity) / COUNT(order_id)) AS Average_order_value,
		SUM(sales_price*quantity) AS Total_SalesRevenue,
		SUM(cost_price*quantity) AS Total_Cost,
		SUM(sales_price*quantity) - SUM(cost_price*quantity) AS Total_Profit,
		SUM(quantity) AS Total_units_sold,
		SUM(case when f.mode_key = 1 then 1 else 0 end) as order_instore,
		SUM(case when f.mode_key = 2 then 1 else 0 end) as order_online,
		COUNT(order_id) AS Total_orders,
		ROUND((SUM(sales_price*Quantity) - SUM(cost_price*Quantity))/SUM(sales_price*Quantity) * 100,2) AS Profit_Margin_pct,
		ROUND(AVG(discount_pct),2)  AS Avg_discount
FROM facts_table f
	LEFT JOIN dim_date d ON  f.date_key = d.date_key
	LEFT JOIN dim_product p ON f.product_key = p.product_key
	LEFT JOIN dim_location l ON f.location_key = l.location_key
GROUP BY quarter_year , product_name 
);
-- Query to display top product ranking query
SELECT *
FROM vw_product_seasonality;

-- Query to diplay the Product performance quarter-on-quarter
SELECT 
	product_name,
	quarter_year,
	start_date,
	end_date,
	Average_Order_Value,
	Total_SalesRevenue,
	Total_Cost,
	Total_Profit,
	Total_units_sold,
	order_instore,
	order_online,
	Total_orders,
	Profit_Margin_pct,
	Avg_discount
FROM vw_product_seasonality
WHERE product_name = 'Portable Refrigerator Freezer';

-- Correlation Between Discount and Profit
-- Query first order_transaction


DROP VIEW IF EXISTS vw_corr1;
CREATE VIEW vw_corr1 AS ( 
SELECT 
	order_id,
	-- KPI ( Reusable SQL Query) 
	SUM(sales_price*quantity) AS Total_SalesRevenue,
	SUM(cost_price*quantity) AS Total_Cost,
	SUM(sales_price*quantity) - SUM(cost_price*quantity) AS Total_Profit,
	SUM(quantity) AS Total_units_sold,
	SUM(case when f.mode_key = 1 then 1 else 0 end) as order_instore,
	SUM(case when f.mode_key = 2 then 1 else 0 end) as order_online,
	COUNT(order_id) AS Total_orders,
	ROUND((SUM(sales_price*Quantity) - SUM(cost_price*Quantity))/SUM(sales_price*Quantity) * 100,2) AS Profit_Margin_pct,
	ROUND((discount_pct),2)  AS discount_pct
FROM facts_table f
GROUP BY order_id ,ROUND((discount_pct),2)
);

SELECT * FROM vw_corr1;


-- Pearson Correlation Coefficient
-- the Pearson correlation coefficient (r) is the most common way of measuring a linear correlation. 
-- It is a number between –1 and 1 that measures the strength and direction of the relationship between two variables.
-- Profit vs Discount
-- X = discount_pct -> Cause
-- Y = unit_profit_margin -> Effect
-- n = COUNT(*) = number of data points (orders)
-- ΣXY = SUM(discount_pct * unit_profit_margin) = sum of products
-- ΣX = SUM(discount_pct) = sum of all discount percentages
-- ΣY = SUM(unit_profit_margin) = sum of all profit margins
-- ΣX² = SUM(POW(discount_pct, 2)) = sum of squared discount percentages
-- ΣY² = SUM(POW(unit_profit_margin, 2)) = sum of squared profit margins

DROP VIEW IF EXISTS vw_corr2;
CREATE VIEW vw_corr2 AS ( 
SELECT 
	ROUND(((
        COUNT(*) * SUM(discount_pct * Profit_Margin_pct)
        - SUM(discount_pct) * SUM(Profit_Margin_pct)
    	) / 
   NULLIF(
        SQRT(
          (COUNT(*) * SUM(POW(discount_pct, 2)) - POW(SUM(discount_pct), 2)) *
          (COUNT(*) * SUM(POW(Profit_Margin_pct, 2)) - POW(SUM(Profit_Margin_pct), 2))
        ),
        0
      )
    ),5) AS correlation_discount_profit_margin
FROM vw_corr1 
);


DROP VIEW IF EXISTS vw_discount_impact_analysis;
CREATE VIEW vw_discount_impact_analysis AS ( 
SELECT 
	c1.order_id,
	c1.Total_SalesRevenue,
	c1.Total_Cost,
	c1.Total_Profit,
	c1.Total_units_sold,
	c1.order_instore,
	c1.order_online,
	c1.Total_orders,
	c1.Profit_Margin_pct,
	c1.discount_pct,
	c2.correlation_discount_profit_margin
FROM vw_corr1 c1 
INNER JOIN vw_corr2 c2) ;

SELECT * FROM vw_discount_impact_analysis;

-- Average order value, frequency, and profit per customer segment
-- This query can identify customer frequency ( once , multiple times , top customer)
-- instance of instore vs online
DROP VIEW IF EXISTS vw_customer_pattern;
CREATE VIEW vw_customer_pattern AS (
SELECT 
	customer_id,
	quarter_year,
	MIN(order_date) AS first_order,
	MAX(order_date) AS recent_order,
	ROUND(TIMESTAMPDIFF(day,MIN(order_date),MAX(order_date))/30,2) AS customer_tenure_months,
	-- KPI ( Reusable SQL query)
	( SUM(sales_price*quantity) / COUNT(order_id)) AS Average_order_value,
	SUM(case when f.mode_key = 1 then 1 else 0 end) as order_instore,
	SUM(case when f.mode_key = 2 then 1 else 0 end) as order_online,
	COUNT(order_id) AS Total_orders,
	SUM(quantity) AS Total_units_ordered,
	ROUND(AVG(quantity),2) AS Average_orders,
	SUM(sales_price*quantity) - SUM(cost_price*quantity) AS Total_Profit,
	SUM(sales_price*quantity) AS Total_SalesRevenue,
	SUM(cost_price*quantity) AS Total_Cost,
	ROUND((SUM(sales_price*Quantity) - SUM(cost_price*Quantity))/SUM(sales_price*Quantity) * 100,2) AS Profit_Margin_pct,
	ROUND(AVG(discount_pct),2)  AS Avg_discount
FROM facts_table f
LEFT JOIN dim_customer c ON f.customer_key = c.customer_key
LEFT JOIN dim_order_mode o ON f.mode_key = o.mode_key
LEFT JOIN dim_date d ON f.date_key = d.date_key
LEFT JOIN dim_product p ON f.product_key = p.product_key
GROUP BY customer_id , quarter_year
);

SELECT * FROM vw_customer_pattern;

DROP VIEW IF EXISTS vw_customer_rank;
CREATE VIEW vw_customer_rank AS (
SELECT 
	customer_id,
	MIN(order_date) AS first_order,
	MAX(order_date) AS recent_order,
	ROUND(TIMESTAMPDIFF(day,MIN(order_date),MAX(order_date))/30,2) AS customer_tenure_months,
	-- KPI ( Reusable SQL query)
	( SUM(sales_price*quantity) / COUNT(order_id)) AS Average_order_value,
	SUM(case when f.mode_key = 1 then 1 else 0 end) as order_instore,
	SUM(case when f.mode_key = 2 then 1 else 0 end) as order_online,
	COUNT(order_id) AS Total_orders,
	SUM(quantity) AS Total_units_ordered,
	ROUND(AVG(quantity),2) AS Average_orders,
	SUM(sales_price*quantity) - SUM(cost_price*quantity) AS Total_Profit,
	SUM(sales_price*quantity) AS Total_SalesRevenue,
	SUM(cost_price*quantity) AS Total_Cost,
	ROUND((SUM(sales_price*Quantity) - SUM(cost_price*Quantity))/SUM(sales_price*Quantity) * 100,2) AS Profit_Margin_pct,
	ROUND(AVG(discount_pct),2)  AS Avg_discount
FROM facts_table f
LEFT JOIN dim_customer c ON f.customer_key = c.customer_key
LEFT JOIN dim_order_mode o ON f.mode_key = o.mode_key
LEFT JOIN dim_date d ON f.date_key = d.date_key
LEFT JOIN dim_product p ON f.product_key = p.product_key
GROUP BY customer_id 
);

SELECT * FROM vw_customer_rank;


-- Profitability comparison across online vs in-store

DROP VIEW IF EXISTS vw_channel_margin_repor;
CREATE VIEW vw_channel_margin_repor AS (
SELECT 
	order_mode,
	-- KPI ( Reusable SQL query)
	( SUM(sales_price*quantity) / COUNT(order_id)) AS Average_order_value,
	SUM(case when f.mode_key = 1 then 1 else 0 end) as order_instore,
	SUM(case when f.mode_key = 2 then 1 else 0 end) as order_online,
	COUNT(order_id) AS Total_orders,
	SUM(quantity) AS Total_units_ordered,
	ROUND(AVG(quantity),2) AS Average_orders,
	SUM(sales_price*quantity) - SUM(cost_price*quantity) AS Total_Profit,
	SUM(sales_price*quantity) AS Total_SalesRevenue,
	SUM(cost_price*quantity) AS Total_Cost,
	ROUND((SUM(sales_price*Quantity) - SUM(cost_price*Quantity))/SUM(sales_price*Quantity) * 100,2) AS Profit_Margin_pct,
	ROUND(AVG(discount_pct),2)  AS Avg_discount
FROM facts_table f
LEFT JOIN dim_customer c ON f.customer_key = c.customer_key
LEFT JOIN dim_order_mode o ON f.mode_key = o.mode_key
LEFT JOIN dim_date d ON f.date_key = d.date_key
GROUP BY order_mode 
);

SELECT * FROM vw_channel_margin_repor;

-- Rank categories by profit margin per region

DROP VIEW IF EXISTS vw_category_region_rankings;
CREATE VIEW vw_category_region_rankings AS (
SELECT 
	product_category,
	region_name,
	DENSE_RANK() OVER(PARTITION BY region_name ORDER BY ROUND((SUM(sales_price) - SUM(cost_price))/SUM(sales_price) * 100,2)  DESC )  AS profit_margin_ranking,
	DENSE_RANK() OVER(PARTITION BY region_name ORDER BY SUM(sales_price*quantity) DESC )  AS sales_ranking,
	-- KPI ( Reusable SQL query)
	( SUM(sales_price*quantity) / COUNT(order_id)) AS Average_order_value,
	SUM(case when f.mode_key = 1 then 1 else 0 end) as order_instore,
	SUM(case when f.mode_key = 2 then 1 else 0 end) as order_online,
	COUNT(order_id) AS Total_orders,
	SUM(quantity) AS Total_units_ordered,
	ROUND(AVG(quantity),2) AS Average_orders,
	SUM(sales_price*quantity) - SUM(cost_price*quantity) AS Total_Profit,
	SUM(sales_price*quantity) AS Total_SalesRevenue,
	SUM(cost_price*quantity) AS Total_Cost,
	ROUND((SUM(sales_price*Quantity) - SUM(cost_price*Quantity))/SUM(sales_price*Quantity) * 100,2) AS Profit_Margin_pct,
	ROUND(AVG(discount_pct),2)  AS Avg_discount
FROM facts_table f
LEFT JOIN dim_customer c ON f.customer_key = c.customer_key
LEFT JOIN dim_order_mode o ON f.mode_key = o.mode_key
LEFT JOIN dim_location l ON f.location_key = l.location_key
LEFT JOIN dim_product p ON f.product_key = p.product_key
LEFT JOIN dim_date d ON f.date_key = d.date_key
GROUP BY product_category , region_name 
);

SELECT * FROM vw_category_region_rankings;

DROP VIEW IF EXISTS vw_region_rankings;
CREATE VIEW vw_region_rankings AS (
SELECT 
	region_name,
	DENSE_RANK() OVER( ORDER BY ROUND((SUM(sales_price) - SUM(cost_price))/SUM(sales_price) * 100,2)  DESC )  AS profit_margin_ranking,
	DENSE_RANK() OVER( ORDER BY SUM(sales_price*quantity)  DESC )  AS sales_ranking,
	-- KPI ( Reusable SQL query)
	( SUM(sales_price*quantity) / COUNT(order_id)) AS Average_order_value,
	SUM(case when f.mode_key = 1 then 1 else 0 end) as order_instore,
	SUM(case when f.mode_key = 2 then 1 else 0 end) as order_online,
	COUNT(order_id) AS Total_orders,
	SUM(quantity) AS Total_units_ordered,
	ROUND(AVG(quantity),2) AS Average_orders,
	SUM(sales_price*quantity) - SUM(cost_price*quantity) AS Total_Profit,
	SUM(sales_price*quantity) AS Total_SalesRevenue,
	SUM(cost_price*quantity) AS Total_Cost,
	ROUND((SUM(sales_price*Quantity) - SUM(cost_price*Quantity))/SUM(sales_price*Quantity) * 100,2) AS Profit_Margin_pct,
	ROUND(AVG(discount_pct),2)  AS Avg_discount
FROM facts_table f
LEFT JOIN dim_customer c ON f.customer_key = c.customer_key
LEFT JOIN dim_order_mode o ON f.mode_key = o.mode_key
LEFT JOIN dim_location l ON f.location_key = l.location_key
LEFT JOIN dim_date d ON f.date_key = d.date_key
GROUP BY region_name 
);

SELECT * FROM vw_region_rankings ;


-- instance of instore vs online by segment
DROP VIEW IF EXISTS vw_segment_pattern;
CREATE VIEW vw_segment_pattern AS (
SELECT 
	product_segment,
	order_mode,
	-- KPI ( Reusable SQL query)
	( SUM(sales_price*quantity) / COUNT(*)) AS Average_order_value,
	SUM(case when f.mode_key = 1 then 1 else 0 end) as order_instore,
	SUM(case when f.mode_key = 2 then 1 else 0 end) as order_online,
	COUNT(order_id) AS Total_orders,
	SUM(quantity) AS Total_units_ordered,
	ROUND(AVG(quantity),2) AS Average_orders,
	SUM(sales_price*quantity) - SUM(cost_price*quantity) AS Total_Profit,
	SUM(sales_price*quantity) AS Total_SalesRevenue,
	SUM(cost_price*quantity) AS Total_Cost,
	ROUND((SUM(sales_price*Quantity) - SUM(cost_price*Quantity))/SUM(sales_price*Quantity) * 100,2) AS Profit_Margin_pct,
	ROUND(AVG(discount_pct),2)  AS Avg_discount
FROM facts_table f
LEFT JOIN dim_customer c ON f.customer_key = c.customer_key
LEFT JOIN dim_order_mode o ON f.mode_key = o.mode_key
LEFT JOIN dim_date d ON f.date_key = d.date_key
LEFT JOIN dim_product p ON f.product_key = p.product_key
GROUP BY product_segment, order_mode
);

SELECT * FROM vw_segment_pattern;

-- instance of instore vs online by category
DROP VIEW IF EXISTS vw_category_pattern;
CREATE VIEW vw_category_pattern AS (
SELECT 
	product_category,
	-- KPI ( Reusable SQL query)
	( SUM(sales_price*quantity) / COUNT(*)) AS Average_order_value,
	SUM(case when f.mode_key = 1 then 1 else 0 end) as order_instore,
	SUM(case when f.mode_key = 2 then 1 else 0 end) as order_online,
	COUNT(order_id) AS Total_orders,
	SUM(quantity) AS Total_units_ordered,
	ROUND(AVG(quantity),2) AS Average_orders,
	SUM(sales_price*quantity) - SUM(cost_price*quantity) AS Total_Profit,
	SUM(sales_price*quantity) AS Total_SalesRevenue,
	SUM(cost_price*quantity) AS Total_Cost,
	ROUND((SUM(sales_price*Quantity) - SUM(cost_price*Quantity))/SUM(sales_price*Quantity) * 100,2) AS Profit_Margin_pct,
	ROUND(AVG(discount_pct),2)  AS Avg_discount
FROM facts_table f
LEFT JOIN dim_customer c ON f.customer_key = c.customer_key
LEFT JOIN dim_order_mode o ON f.mode_key = o.mode_key
LEFT JOIN dim_date d ON f.date_key = d.date_key
LEFT JOIN dim_product p ON f.product_key = p.product_key
GROUP BY product_category 
);

SELECT * FROM vw_category_pattern;
