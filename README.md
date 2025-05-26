🛒 Walmart Sales Data Analysis with SQL
This project involves analyzing a real-world Walmart sales dataset using SQL. 
It includes data preprocessing, feature engineering (like extracting day, time, and VAT), and answering various business-focused questions across sales, customers, products, and time analysis using advanced SQL queries.

📂 Dataset Overview
File Used: Walmart Sales Data.csv
Rows: 1000
Columns:

Invoice ID

Branch

City

Customer Type

Gender

Product Line

Unit Price

Quantity

Tax (5%)

Total

Date

Time

Payment

COGS

Rating

🏗️ Database & Table
sql
Copy
Edit
USE walmart;
SELECT * FROM walmarts;
The dataset is stored in a single table: walmarts.


🔧 Feature Engineering
The following additional columns were created for better analysis:

Column Name	Description
time_of_day	Derived from time (Morning, Afternoon, Evening)
day_name	Weekday name from date column
month_name	Month name from date column
VAT	15% tax on the total column


📊 Key SQL Analyses
🏙️ Generic Information:
Distinct cities and branches

Total branches per city

📦 Product Analysis:
Distinct product lines

Most selling product line

Product line with highest revenue or VAT

Product lines categorized as “Good” or “Bad” based on average sales

💳 Payment Insights:
Most used payment method

Count of each payment mode

👨‍👩‍👧 Gender & Customer Analysis:
Gender distribution

Gender-wise product preferences

Unique customer types

Customer type with most purchases or VAT paid

🕒 Time-based Analysis:
Number of sales by time_of_day

Best performing weekday by rating

Most active day and time in each branch

🏆 Branch Analysis:
Which branch sells more than the average?

Branch-wise gender distribution

Branch with best average ratings

💰 Revenue & Financial:
Revenue and COGS by month

City with highest total revenue or tax collected

⚙️ SQL Concepts Used
CASE WHEN for feature engineering

DATE FUNCTIONS: DAYNAME(), MONTHNAME(), YEAR()

GROUP BY, HAVING, ORDER BY, LIMIT

WINDOW FUNCTIONS: ROW_NUMBER(), RANK(), PARTITION BY

Aggregate functions: SUM(), AVG(), COUNT(), ROUND()

✅ Outcomes

- Created powerful features for time-based and tax analysis.
- Answered 30+ real-world business questions using SQL.
- Practiced window functions, CTEs, group-level filters, and date-time operations.
- Ready to be showcased in a data analyst portfolio.


📎 How to Use
Load the dataset into a SQL-compatible environment.

Run the SQL script Walmarts Sql Sales Project.sql.

