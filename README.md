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
Data Modeling
 ✅ Dimensional Model Design 
 ✅ Fact Table containing: 
 ✅ Foreign keys referencing all dimension tables
 ✅ Business Measures: Total_Sales, Total_Cost, Profit, Discount_Amount, Quantity

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

<h3> Dashboard#4 :  Regional Overview </h3>
<img width="1355" height="768" alt="image" src="https://github.com/user-attachments/assets/c8a0cf4b-11fe-4f6c-ac82-db663e6e4ca8" />

<h3> Dashboard#5 :Segment Overview  </h3>
<img width="1355" height="767" alt="image" src="https://github.com/user-attachments/assets/3df17313-8f8d-4cdd-a30f-c693ff561200" />

