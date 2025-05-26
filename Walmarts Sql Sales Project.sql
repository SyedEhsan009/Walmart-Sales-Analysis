#                                              SQL sales project on walmarts
use walmart;
select * from walmarts;
##                     first we made a seperate column for each of the date function like day,month,year,and timings.  
#1. Time_of_day

SELECT time,
(CASE 
	WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
	WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
	ELSE "Evening" 
END) AS time_of_day
FROM walmarts;


ALTER TABLE walmarts ADD COLUMN time_of_day VARCHAR(20);
set sql_safe_updates=0;

UPDATE walmarts
SET time_of_day = (
	CASE 
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE "Evening" 
	END
);


# 2.Day_name

SELECT date,
DAYNAME(date) AS day_name
FROM walmarts;

ALTER TABLE walmarts ADD COLUMN day_name VARCHAR(10);

UPDATE walmarts 
SET day_name = DAYNAME(date);
select * from walmarts;

# 3.Momth_name

SELECT date,
MONTHNAME(date) AS month_name
FROM walmarts;

ALTER TABLE walmarts  ADD COLUMN month_name VARCHAR(10);

UPDATE walmarts
SET month_name = MONTHNAME(date);

#Q.4 years
 
SELECT date,
year(date) AS years
FROM walmarts;

ALTER TABLE walmarts  ADD COLUMN years int(10);

UPDATE walmarts
SET years = YEAR(date);


alter table walmarts drop column years;


#                        ==================================================================================
 #                                  lets start making analysis walmarts sales data
 #                                             Gerneric questions:-
 
 #Q.1How many distinct cities are present in the dataset?
 
 select * from walmarts;
 select distinct city from walmarts;
 
 #Q.2 In which city is each branch situated?
 
  SELECT DISTINCT branch, city FROM walmarts;
  
  #Q.3) fetch city and branch with city count;
  
  select branch,city,count(*) as total_count
  from walmarts group by branch,city;
  
 #                                                               product analysis 
 
#Q.4) How many distinct product lines are there in the dataset?

select count(distinct product_line ) from walmarts;

# Q.5) What is the most common payment method?

select payment, count(*) as mostcommonpaymnet from walmarts 
group by payment
order by payment desc 
limit 1;

#                                                   OR

SELECT payment, COUNT(payment) AS common_payment_method 
FROM walmarts GROUP BY payment ORDER BY common_payment_method DESC LIMIT 1;

## Q.6 how many different payment modes:-

select payment, count(*) as total_count
from walmarts group by payment;

## Q.7how many males and females are there in dataset=

select gender, count(*) as total_gender
from walmarts group by gender;

#Q.8 What is the most selling product line?

select product_line, count(*) as mostselling
from walmarts group by product_line order by product_line desc limit 1;

# 9 ) What is the total revenue by month?

select month_name, Sum(total) as total_revenue 
from walmarts 
group by month_name order by total_revenue desc;
 
#Q,10)Which month recorded the highest Cost of Goods Sold (COGS)? 

select month_name, sum(cogs) as highest_cogs 
from walmarts group by month_name 
order by highest_cogs desc 
limit 1;

# Q.11 Which product line generated the highest revenue?

select product_line, sum(total) as Highest_revenue 
from walmarts group by product_line
order by  Highest_revenue desc 
limit 1;

#Q.12  Which city has the highest revenue?

select city, sum(total) as Highest_revenue 
from walmarts group by city
order by  Highest_revenue desc 
limit 1;

#  we add another column named VAT and update that column with 15 %;

alter table walmarts add column VAT decimal(10,2);
set sql_safe_updates=0;
update walmarts
set VAT= total* 0.15;


#Q.!3 - Which product line incurred the highest VAT?

select product_line , sum(Vat) as Highest_Vat
from walmarts group by product_line 
order by  Highest_vat desc
limit 1;


#Q.14  Retrieve each product line and add a column 'product_category', indicating 'Good' or 'Bad,' based on whether its sales are above the average.
                                                #*****#


select 
	product_line,
    Total,
    case when Total >= (select avg(Total) from walmarts) then "good"
    else "bad" 
    end as product_category
from walmarts;

#Q.15  Which branch sold more products than average product sold? 
#                                                                        ***

select branch, sum(quantity) as quantity_sold
from walmarts group by branch having sum(quantity)> Avg(quantity) order by quantity_sold desc limit 1;

#Q.16 ?- What is the most common product line by gender
 
##                                                               Advanced Level 

WITH ranked_products AS (
  SELECT 
    gender, 
    product_line, 
    COUNT(*) AS count,
    ROW_NUMBER() OVER (PARTITION BY gender ORDER BY COUNT(*) DESC) AS rn
  FROM walmarts
  GROUP BY gender, product_line
)
SELECT gender, product_line AS most_common_product_line, count
FROM ranked_products
WHERE rn = 1;

#                                                                     OR

SELECT gender, product_line, COUNT(gender) total_count
FROM WALMARTS GROUP BY gender, product_line ORDER BY total_count DESC;


#                                                                     OR
SELECT gender, product_line, COUNT(*) AS count
FROM walmarts
GROUP BY gender, product_line
ORDER BY gender, count DESC;

# Q.17  What is the average rating of each product line?

select product_line,round(avg(rating),2) as avg_rating  from walmarts
group by product_line order by avg_rating  desc ;

##                                                            SALES ANALYSIS:-

#Q.18)  Number of sales made in each time of the day per weekday (excluding weekends).


select time_of_day,day_name, count(total) as no_sales_made 
from walmarts
where day_name not in ("sunday","saturday")
 group by time_of_day, Day_name ;
 
 
 ## Q.19  Identify the customer type that generates the highest revenue. ( revenue means SUM)
 
 
 select customer_type ,sum(total) as highest_revenue 
 from walmarts group by customer_type 
 order by highest_revenue desc limit 1;
 
# Q.20  Which city has the largest tax percent/ VAT (Value Added Tax)?

select city, sum(vat) as largest_tax_percent
from walmarts group by city 
order by largest_tax_percent desc 
limit 1;

# Q.21  Which customer type pays the most in VAT?

 select customer_type ,sum(vat) as most_vat
 from walmarts 
 group by customer_type 
 order by most_vat desc limit 1;
 
 #                                                         Customer Analysis 
 
 #Q.22 How many unique customer types does the data have?
 
  
 select distinct(customer_type) as unique_customer_type 
 from walmarts;
 
 #Q23 How many unique payment methods does the data have?
 
select distinct(payment) as unique_payment_method
 from walmarts;
 
 #Q.24   which is the most common customer type?
 
 SELECT customer_type, COUNT(*) AS count
FROM walmarts
GROUP BY customer_type
ORDER BY count DESC
LIMIT 1;


#Q.25  Which customer type buys the most (by total revenue and total count)?

select customer_type, sum(total) as total_revenue,
count(*) as total_count
from walmarts group by customer_type 
order by total_revenue desc, total_count desc limit 1;

#Q.26 What is the gender of most of the customers?

select Gender, count(*) as most_of_customer
from walmarts group by gender 
order by most_of_customer desc limit 1;

 # Q.27 what is the gender distribution per branch?
 
  select branch,gender,count(*) gender_distribution_per_branch 
from walmarts group by branch, gender
order by gender_distribution_per_branch desc limit 1;

# Q.28 Which time of the day do customers give most ratings?

 select time_of_day,count(rating) as most_ratings
 from walmarts group by time_of_day
 order by most_ratings desc limit 1;
 
# Q.29  Which time of the day do customers give most ratings per branch?

select time_of_day,branch, count(rating) as most_ratings
 from walmarts group by time_of_day,branch
 order by most_ratings desc limit 1;
 
 # Q.29 ) we can solve it by widows function as well , in windows funtion count all the branch...
 
 SELECT branch, time_of_day, rating_count
FROM (
    SELECT branch, time_of_day, COUNT(rating) AS rating_count,
           RANK() OVER (PARTITION BY branch ORDER BY COUNT(rating) DESC) AS rnk
    FROM walmarts
    GROUP BY branch, time_of_day
) AS ranked
WHERE rnk = 1;

 # Q.30  Which day of the week has the best average ratings?
 
 select Day_name, round(avg(rating),2) as best_average_ratings 
 from walmarts group by day_name order by best_average_ratings desc limit 1;
 
 
 ##Q.31 Which day of the week has the best average ratings per branch?
 
  SELECT branch, day_name, rating_average
FROM (
    SELECT branch, day_name, ROUND(AVG(rating), 2) AS rating_average,
           RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rnk
    FROM walmarts
    GROUP BY branch, day_name
) AS ranked
WHERE rnk = 1;
# or                            we can solve this by group by function 


select day_name,branch,round(avg(rating),2) as average_rating
from walmarts
group by day_name, branch order by average_rating desc limit 1;
 
 #                                                                   Fininsh
 #===================================================================****=======================================================================
 
 
 
 
 
 