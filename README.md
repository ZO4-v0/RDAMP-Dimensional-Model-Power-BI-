<div align="center">
 <img width="714" height="555" alt="image" src="https://github.com/user-attachments/assets/72a0050f-ae34-40da-9e75-fc67c1bd94fe" />
</div>

<h1> RDAMP-Dimensional-Model-Power-BI </h1>
Dimensional Modeling , SQL Transformation and PowerBI Visualization

<h2>Project Overview </h2> 
This project demonstrates the implementation of a dimensional data model for Ace Superstore's sales data, following star schema best practices to create an enterprise-grade reporting system. The solution includes SQL-based dimensional modeling, view creation for business insights, and Power BI dashboard development. 


<h2>Business Impact</h2> 
This project helps transition the cleaned dataset into a format optimized for enterprise-grade reporting. Business users will be able to analyze performance from multiple angles using a data model designed for usability and scalability. 


<h2>Business Criteria</h2> 

  1. Database Modeling 

         Dimensional Model Design
         Fact Table containing Foreign keys referencing all dimension tables
     
 3.  Business Measures

          Total_orders
          Total_units_ordered
          Average_orders
          Total_Profit
          Total_SalesRevenue
          Total_Cost
          Profit_Margin_pct
          Avg_discount
 4. SQL Views & Reusable SQL queries 

         vw_product_seasonality
         vw_discount_impact_analysis
         vw_customer_pattern
         vw_customer_rank
         vw_channel_margin_repor
         vw_category_region_rankings
         vw_region_rankings
         vw_segment_pattern
         vw_category_pattern
         vw_data_validation
 5.  Power BI Dashboard 

         %Discount vs Profit Correlation 
         Customer Overview 
         Product Seasonality Overview 
         Regional Overview 
         Segment Overview
  6. Use Initial clean data on previous task

         https://github.com/ZO4-v0/RDAMP-Sales-Analysis/tree/main/Dataset


<h2>Business Insights / Analysis  </h2> 


<h3> Dashboard#1 : Discount vs Profit Correlation Analysis </h3>

     - Very weak positive correlation (r = 0.178) between discount_pct and profit_margin_pct.
     - While a slight upward trend exists, it is not strong enough to suggest a significant impact of discount on profit margin.
     - The weak correlation suggests that other variables may be influencing profit margins more than discounts.
     - Recommendation : Perform  clustering techniques to identify hidden patterns or drivers of profit margin.
      
<h3> Dashboard#2 : Customer Overview </h3>

    - Customer_ID : MN066756 Top customer with £35.83k of total profit conttribution
    - Accumalted £51.17k of sales revenue across 128 orders  
    - One of the loyal customers for 26.8 months
    - Out of 3681 Unique customers , 2138 customers are One-time customers.
    - Excluding One-time Customers average customer tenure is at 16.42 Months.
    - Online Purchase shows higher profit_margin_pct vs Instore purchase.
    - However starting Q2 of 2024 in-store purchase are declining. 17.40% decrease in instore purchase as of Q1 of 2025.
    - Recommendation : Consider Loyalty promotions for top tier customers and expand digital marketing.


<h3> Dashboard#3 : Product Seasonality Overview </h3>

    - Heatmap visuals shows clear profit margin differences across products and quarters.
    - Identified top products contributor by Profit_margin Q-on-Q
    - Recommendations : Consider bundling underperforming products with high-margin ones to boost profitability


<h3> Dashboard#4 : Regional Category Overview </h3>

     - East Midlands leads in revenue and order volume, followed by Yorkshire & the Humber and Scotland.
     - Top Categories varies region-by-region
     - Recommendations : Deploy targeted campaigns in underperforming regions

<h3> Dashboard#5 : Regional Category Overview </h3>

     - Outdoor and Kitchen segments are leading in total revenue but still present room for margin optimization.
     - Bicycles have the highest AOV of 3.5k Instore and 2.9k Online
     - Recommendation : Leverage Bicycle Segment by upselling/bundling related items ( accessories , gears ) 


<h2>Tools Used </h2> 

       1. Excel
       2. MySQL Workbench 8.0
       3. HeidiSQL
       4. PowerBI
       5. Notepad++ with CSV Lint Plugin

<h2> Convert .csv File to SQL format </h2> 

1. Save dataset in .csv Format
2. Open Notepad++ and import .csv file
   > <img width="1008" height="264" alt="image" src="https://github.com/user-attachments/assets/ca0e01b4-c6a2-4830-9887-a9be32b23c7e" />
3. Open [CSV LINT] window and validate data
   > <img width="1004" height="231" alt="image" src="https://github.com/user-attachments/assets/918de3ad-4381-49d3-8c9b-e12fef721f7b" />
4. Once Validated and no Error Found -> Convert data to SQL format modify Batch size SQL insert to Maximum row size.
   ><img width="398" height="259" alt="image" src="https://github.com/user-attachments/assets/1037a5e9-6d34-48c5-8d00-b273db4f7c90" />
5. [Raw.sql] is now ready for import
   ><img width="1004" height="592" alt="image" src="https://github.com/user-attachments/assets/ee7308d9-55ec-4c6e-b1ff-4f7369017d0b" />


<h2> Database Modeling </h2> 

1. Download MySQL Workbench 8.0
   > https://dev.mysql.com/downloads/workbench/?os=33
   
2. Connect to Local MySQL connections
   > <img width="270" height="160" alt="image" src="https://github.com/user-attachments/assets/b8430ea0-0ca0-4d68-b433-2db4b716b49c" />
   
3. Create New Database
   > <img width="527" height="122" alt="image" src="https://github.com/user-attachments/assets/462ccfa5-1427-49bc-9110-956b7055b46b" />
   
4. Perform Data import using pRaw.sql] to [superstore] database
   > <img width="818" height="448" alt="image" src="https://github.com/user-attachments/assets/97e5a23a-f2f4-48ec-853d-c7bf1c1b4fbd" />
   
5. Once finished , Validate data and data formats.
   > <img width="268" height="332" alt="image" src="https://github.com/user-attachments/assets/b4665a20-bd9c-40ee-88b7-d7efed52f22c" />
   > > <img width="1599" height="718" alt="image" src="https://github.com/user-attachments/assets/a2b3ca36-80a2-4f2e-8c32-13438043b3c4" />
   >  <img width="123" height="57" alt="image" src="https://github.com/user-attachments/assets/89e86128-40a2-491a-afec-6391cdb07820" />
   
6. Design and draft Star schema with the folliwng Criteria

       1. Descriptive Dimensional Model
       2. Fact Table containing Foreign keys referencing all dimension tables with clear and atomic data.
       3. Clean Standardize Text and Normalized Dates
       4. Handle Nulls and defaults
       5. Optimized Indexing
       6. No Duplicate and Null keys
   >   <img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/72a0050f-ae34-40da-9e75-fc67c1bd94fe" />
  
7. Using SQL CREATE and INSERT Dimension Table

       Create_Insert_Dimension.sql
      | Table         | Type    | Columns                    |Description  |
      |---------------|---------|----------------------------|-------------|
      |dim_customer   |Dimension| customer_key , customer_id | Contains Unique customer information , Does not include location information as location is reference to store location not customer data |
      |dim_product    |Dimension| product_key , product_ID , prodcut_name , product_category , product_segment , product_subcat | Contains Unique product information and corresponding segments |
      |dim_location   |Dimension| location_Key , postal_city , postal_code , city_name , region_name , country_name | Contais ACE'Store Unique Postal Code & City locations 
      |dim_date       |Dimension| date_key , order_date , order_year , order_month , month_name , quarter_num , yearmonth , quarter_year | Contains normalize order_id date information 
      |dim_order_mode |Dimension| mode_key , order_mode | Contains order mode information In-store vs Online | 
      |Facts_table    |Fact     | Primary Key , Foreign Keys , Business Measures |  Foreign keys referencing all dimension tables and business measures data | 
        
8. Using SQL CREATE and INSERT Fact Table and add KEY CONSTRAINTS

       Create_Insert_Fact.sql
      >  <img width="640" height="119" alt="image" src="https://github.com/user-attachments/assets/0727a9d5-c677-4aec-8119-dcbb0748accf" />


9. Create Query to validate data imported.

       data_aggregation.sql
     >  <img width="300" height="196" alt="image" src="https://github.com/user-attachments/assets/f82a6752-6b61-4086-a306-a62eb805af6a" />
     >  <img width="1350" height="45" alt="image" src="https://github.com/user-attachments/assets/76bdbb5d-2738-4ec0-b17c-1336fa3e7551" />
     >   <img width="610" height="390" alt="image" src="https://github.com/user-attachments/assets/6dba46bc-d4d7-45db-92be-512da81c5391" />
     >  <img width="1592" height="57" alt="image" src="https://github.com/user-attachments/assets/0875cf20-fe88-4e17-93d8-5fdd8e301726" />


<h2> SQL Views  </h2> 

  # vw_product_seasonality

    Product performance trends quarter-on-quarter
    This query will answer products ranking per quarter-year and corresponding KPI Measures
   >   <img width="1045" height="385" alt="image" src="https://github.com/user-attachments/assets/0c37b8bb-e1bd-4c04-a71c-57d00b66e673" />


 # vw_discount_impact_analysis

    Correlation Between %Discount and Profit_Margin_Pct and corresponding KPI Measures
    Calculate using Pearson Correlation Coefficient
    Pearson Correlation Coefficient (r) is the most common way of measuring a linear correlation. 
    It is a number between –1 and 1 that measures the strength and direction of the relationship between two variables.
   >   <img width="536" height="239" alt="image" src="https://github.com/user-attachments/assets/8d0d4cf9-1b92-4e82-aa0d-13825cbd223d" />


 # vw_customer_pattern 

    Customer order pattern quarter-on-quarter
    This query will answer customer information ( Tenure , AOV , Prefered Channel ) and corresponding KPI Measures
   > <img width="731" height="387" alt="image" src="https://github.com/user-attachments/assets/2fdee2e2-58d1-4cc2-9094-a9751ffef44b" />


 # vw_customer_rank

    Customer Overall Ranking
    This query will answer Top customers and corresponding KPI Measures
   > <img width="737" height="373" alt="image" src="https://github.com/user-attachments/assets/33f9e257-cbc3-453e-b95c-5440a5f7765c" />


 # vw_channel_margin_repor

    Profit Margin Distribution by Channel Mode
    This will answer the order mode performance and corresponding KPI Measures
   >  <img width="731" height="318" alt="image" src="https://github.com/user-attachments/assets/e4973417-9f44-47f7-bd9a-727ca1b6e5c5" />


 # vw_category_region_rankings

     Product Category By region performance
     This will answer the TOP category per region and corresponding KPI Measures
   > <img width="816" height="356" alt="image" src="https://github.com/user-attachments/assets/3ce9169c-6972-4d08-989a-67dad7a7ec97" />

 # vw_region_rankings
     Regional Overview
     This will answer Top region and corresponding KPI Measures
   >  <img width="823" height="356" alt="image" src="https://github.com/user-attachments/assets/1f7a5d94-6dd8-4c14-bd2f-da4187e48a43" />

 # vw_segment_pattern
     Segment Overview
     This will answer Top segment and corresponding KPI Measures
   >  <img width="738" height="349" alt="image" src="https://github.com/user-attachments/assets/fae3d1c6-8304-4421-864e-695ddd573d95" />

 # vw_category_pattern
     Product Category  Overview
     This will answer Top category , preferred order mode and corresponding KPI Measures
   > <img width="741" height="330" alt="image" src="https://github.com/user-attachments/assets/d343341d-5623-4309-83c1-2e69714d04bb" />



<h2> Connecting PowerBI desktop to SQL Server </h2> 


1. Install MySQL ODBC Connector
     >  https://dev.mysql.com/downloads/connector/odbc/
2. Open ODBC Data Source Adminstrator   
3. Navigate to System DSN TAB

       Click Add and Find MySQL ODBC 9.3 Unicode Driver and fill details and test connection for validation
       Data Source Name    MyLocalMySQL
       TCP/IP Server       localhost
       Port                3306
       User                your MySQL username
       Password            your MySQL password
       Database            your database name
    >    <img width="600" height="266" alt="image" src="https://github.com/user-attachments/assets/288f8061-00c9-436b-847a-994a4e893ba9" />

4. Open PowerBi Desktop -> Get Data -> ODBC -> Find your DataSourceName (DSN) -> Add your data base

   >  <img width="883" height="703" alt="image" src="https://github.com/user-attachments/assets/bd80acb2-009f-470b-8685-9a66e17e14a4" />


<h2> Screenshots </h2>

<h3> Star Schema </h3>

   >  <img width="914" height="855" alt="image" src="https://github.com/user-attachments/assets/72a0050f-ae34-40da-9e75-fc67c1bd94fe" />

<h3> superstore Database : Table & View </h3>

   >   <img width="324" height="448" alt="image" src="https://github.com/user-attachments/assets/54dd3a1c-7265-43af-9bcc-62de685f095c" />

<h3>Facts_Table</h3>

   >   <img width="1392" height="770" alt="image" src="https://github.com/user-attachments/assets/fb12b0aa-f79a-48ac-8cf0-7c213918e8e1" />

<h3>Dimension_Table</h3>

   >  <img width="278" height="279" alt="image" src="https://github.com/user-attachments/assets/8f2267ce-4045-4acd-941a-7ecbc721f17a" />
   >   <img width="791" height="297" alt="image" src="https://github.com/user-attachments/assets/04e2f09e-0eec-4c60-8add-6dc25f5e61fa" />
   >   <img width="744" height="298" alt="image" src="https://github.com/user-attachments/assets/5e16fd14-3b8d-4d76-bf90-3524e3ae6c2d" />
   >   <img width="313" height="139" alt="image" src="https://github.com/user-attachments/assets/72faa875-b3fc-4df0-bd0f-fc77136eed52" />
   >   <img width="1027" height="301" alt="image" src="https://github.com/user-attachments/assets/708d2e0d-e86e-4e8f-a4ce-ddd0b3c10c59" />

<h3> Dashboard#1 : %Discount vs Profit Correlation  </h3>

>   <img width="1364" height="769" alt="image" src="https://github.com/user-attachments/assets/2192cde3-6bf3-42a3-9592-38a74e8efd92" />

<h3> Dashboard#2 : Customer Overview </h3>

>   <img width="1248" height="706" alt="image" src="https://github.com/user-attachments/assets/900d029c-d60b-4091-ab26-43eb7d589088" />


<h3> Dashboard#3 : Product Seasonality Overview  </h3>

>   <img width="1357" height="768" alt="image" src="https://github.com/user-attachments/assets/3517577b-4bb7-47ca-a936-90eab745f063" />

<h3> Dashboard#4 : Regional Overview </h3>

>  <img width="1355" height="768" alt="image" src="https://github.com/user-attachments/assets/c8a0cf4b-11fe-4f6c-ac82-db663e6e4ca8" />

<h3> Dashboard#5 : Segment Overview  </h3>

>   <img width="1355" height="767" alt="image" src="https://github.com/user-attachments/assets/3df17313-8f8d-4cdd-a30f-c693ff561200" />

