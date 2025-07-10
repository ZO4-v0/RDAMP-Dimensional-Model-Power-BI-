# RDAMP-Dimensional-Model-Power-BI-
Dimensional Modeling, SQL Transformation &amp; Power BI/Tableau Reporting 

#Problem Description 

Following the foundational analysis in Task 1, Ace Superstore now aims to build a structured, query-optimized reporting system. Your responsibility in this task is twofold: 
 
1. Design and implement a star schema using SQL. 
2. Create SQL views from your schema and connect them directly to Power BI to produce advanced interactive dashboards. 

#Business Impact 

This task helps transition the cleaned dataset into a format optimized for enterprise-grade reporting. Business users will be able to analyze performance from multiple angles using a data model designed for usability and scalability. 

#Acceptance Criteria 

✅ Dimensional Model Design 
- dim_customer 
- dim_product 
- dim_location 
- dim_date 
- dim_category 
- dim_segment 
- dim_order_mode 

✅ fact_sales containing: 
 - Foreign keys referencing all dimension tables
 - Measures: Total_Sales, Total_Cost, Profit, Discount_Amount, Quantity

✅ SQL Implementation 
- Use appropriate CREATE TABLE statements and data types 
- Apply foreign key constraints 
- Clean and deduplicate dimension data 
- Ensure: 
  - No NULLs in fact table keys 
  - Standardized and trimmed text fields 
  - dim_date includes fields like Order_Date, Year, Month, Quarter
 
✅ SQL Views Creation 
Create at least three SQL views that summarize key insights for Power BI/Tableau 
The Views include: 
- vw_product_seasonality: Product performance trends over time 
- vw_discount_impact_analysis: Correlation between discounts and profits 
- vw_customer_order_patterns: Average order value, frequency, and profit per customer segment 
- vw_channel_margin_report: Profitability comparison across online vs in-store 
- vw_region_category_rankings: Rank categories by profit margin per region

✅ Power BI/Tableau Dashboard 
1. Import your SQL views 
2. Create an interactive dashboard in Power BI/Tableau using your views 
3. Dashboard must include: 
   - Product Seasonality Trends (e.g. heatmap) 
   - Discount vs. Profit Analysis (e.g. scatter plot or slope chart) 
   - Average Order Value by Channel and Segment (e.g. combo chart) 
   - Top 10 Customers by Profit Contribution (e.g. horizontal bar chart) 
   - Category Ranking by Region (e.g. matrix or bar chart)
  
✅Queries 
Include 5 reusable SQL queries (outside of views) that: 
- Join fact and dimension tables 
- Return strategic business insights  


✅ README.md 
Your README must include: 
- Overview of your dimensional schema (diagram is compulsory) 
- Purpose of each dimension and fact table 
- SQL setup instructions 
- Power BI/Tableau connection steps 
- Screenshots of each dashboard view
