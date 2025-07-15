<div align="center">
 <img width="914" height="855" alt="image" src="https://github.com/user-attachments/assets/72a0050f-ae34-40da-9e75-fc67c1bd94fe" />
</div>

<h1> RDAMP-Dimensional-Model-Power-BI </h1>
PROJECT TITLE : SQL-Based Data Modeling, Transformation and PowerBI Visualization

<h2>Project Overview </h2> 
This project demonstrates the implementation of a dimensional data model for Ace Superstore's sales data, following star schema best practices to create an enterprise-grade reporting system. The solution includes SQL-based dimensional modeling, view creation for business insights, and Power BI dashboard development. 


<h2>Business Impact</h2> 
This project helps transition the cleaned dataset into a format optimized for enterprise-grade reporting. Business users will be able to analyze performance from multiple angles using a data model designed for usability and scalability. 

<h2>Business Criteria</h2> 

 ## 1. Database Modeling 
      Dimensional Model Design
      Fact Table containing Foreign keys referencing all dimension tables
 ## 2.  Business Measures
      Total_orders
      Total_units_ordered
      Average_orders
      Total_Profit
      Total_SalesRevenue
      Total_Cost
      Profit_Margin_pct
      Avg_discount
 ## 3. SQL Views & Reusable SQL queries 
      vw_category_pattern 
      vw_category_region_rankings 
      vw_customer_pattern 
      vw_customer_rank 
      vw_discount_impact_analysis 
      vw_product_seasonality 
      vw_region_rankings 
      vw_segment_pattern 
      vw_data_validation
 ## 4.  Power BI Dashboard 
      %Discount vs Profit Correlation 
      Customer Overview 
      Product Seasonality Overview 
      Regional Overview 
      Segment Overview
 ##  5. Use Initial clean data on previous task
      https://github.com/ZO4-v0/RDAMP-Sales-Analysis/tree/main/Dataset

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
      |dim_customer   |Dimension| customer_key , customer_id | Contains Unique customer information , Does not include location as location is reference to store ID not customer info |
      |dim_product    |Dimension| product_key , product_ID , prodcut_name , product_category , product_segment , product_subcat | Contains Unique product information and corresponding segments |
      |dim_location   |Dimension| location_Key , postal_city , postal_code , city_name , region_name , country_name | Contais ACE'Store Unique Postal Code & City locations 
      |dim_date       |Dimension| date_key , order_date , order_year , order_month , month_name , quarter_num , yearmonth , quarter_year | Contains normalize order_id date information 
      |dim_order_mode |Dimension| mode_key , order_mode | Contains order mode information In-store vs Online | 

       
   
9. Using SQL CREATE and INSERT Fact Table and add KEY CONSTRAINTS

       Create_Insert_Fact.sql
       FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),
       FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
       FOREIGN KEY (location_key) REFERENCES dim_location(location_key),
       FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
       FOREIGN KEY (mode_key) REFERENCES dim_order_mode(mode_key)
      >  <img width="640" height="119" alt="image" src="https://github.com/user-attachments/assets/0727a9d5-c677-4aec-8119-dcbb0748accf" />


11. Create Query to validate data imported.

       data_aggregation.sql
     >  <img width="300" height="196" alt="image" src="https://github.com/user-attachments/assets/f82a6752-6b61-4086-a306-a62eb805af6a" />
     >  <img width="1350" height="45" alt="image" src="https://github.com/user-attachments/assets/76bdbb5d-2738-4ec0-b17c-1336fa3e7551" />
     >   <img width="610" height="390" alt="image" src="https://github.com/user-attachments/assets/6dba46bc-d4d7-45db-92be-512da81c5391" />
     >  <img width="1592" height="57" alt="image" src="https://github.com/user-attachments/assets/0875cf20-fe88-4e17-93d8-5fdd8e301726" />


<h2> Database Modeling </h2> 


1. Create SQL View Queries to answer Business Questions.








✅ README.md 
Your README must include: 
- Overview of your dimensional schema (diagram is compulsory) 
- Purpose of each dimension and fact table 
- SQL setup instructions 
- Power BI/Tableau connection steps 
- Screenshots of each dashboard view


<h2> Screenshots </h2>

<h3> Star Schema </h3>
<img width="914" height="855" alt="image" src="https://github.com/user-attachments/assets/72a0050f-ae34-40da-9e75-fc67c1bd94fe" />

<h3> superstore Database.Tables </h3>
<img width="324" height="448" alt="image" src="https://github.com/user-attachments/assets/54dd3a1c-7265-43af-9bcc-62de685f095c" />

<h3>Facts_Table</h3>
<img width="1392" height="770" alt="image" src="https://github.com/user-attachments/assets/fb12b0aa-f79a-48ac-8cf0-7c213918e8e1" />

<h3>Dimension_Table</h3>
<img width="278" height="279" alt="image" src="https://github.com/user-attachments/assets/8f2267ce-4045-4acd-941a-7ecbc721f17a" />
<img width="791" height="297" alt="image" src="https://github.com/user-attachments/assets/04e2f09e-0eec-4c60-8add-6dc25f5e61fa" />
<img width="744" height="298" alt="image" src="https://github.com/user-attachments/assets/5e16fd14-3b8d-4d76-bf90-3524e3ae6c2d" />
<img width="313" height="139" alt="image" src="https://github.com/user-attachments/assets/72faa875-b3fc-4df0-bd0f-fc77136eed52" />
<img width="1027" height="301" alt="image" src="https://github.com/user-attachments/assets/708d2e0d-e86e-4e8f-a4ce-ddd0b3c10c59" />

<h3> Dashboard#1 : %Discount vs Profit Correlation  </h3>
<img width="1364" height="769" alt="image" src="https://github.com/user-attachments/assets/2192cde3-6bf3-42a3-9592-38a74e8efd92" />

<h3> Dashboard#2 : Customer Overview </h3>
<img width="1357" height="766" alt="image" src="https://github.com/user-attachments/assets/745a4a65-d406-43df-a2a8-83728f87bb6b" />

<h3> Dashboard#3 : Product Seasonality Overview  </h3>
<img width="1357" height="768" alt="image" src="https://github.com/user-attachments/assets/3517577b-4bb7-47ca-a936-90eab745f063" />

<h3> Dashboard#4 : Regional Overview </h3>
<img width="1355" height="768" alt="image" src="https://github.com/user-attachments/assets/c8a0cf4b-11fe-4f6c-ac82-db663e6e4ca8" />

<h3> Dashboard#5 : Segment Overview  </h3>
<img width="1355" height="767" alt="image" src="https://github.com/user-attachments/assets/3df17313-8f8d-4cdd-a30f-c693ff561200" />

