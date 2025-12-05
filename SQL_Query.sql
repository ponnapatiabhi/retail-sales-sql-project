-- Create database

CREATE database sales_project

-- Create table

DROP table if exists ratail_sales;
CREATE table retail_sales
	(
        transactions_id	INT PRIMARY KEY,
        sale_date DATE,
        sale_time TIME,	
		customer_id	INT,
		gender VARCHAR(15),
		age	 INT,
		category VARCHAR(15),	
		quantiy	INT,
		price_per_unit FLOAT,
		cogs	FLOAT,
		total_sale FLOAT
	);

select 
COUNT(*) from retail_sales

--Data cleaning
select * from retail_sales
WHERE 
		transactions_id	IS NULL
		OR
        sale_date IS NULL
		OR
        sale_time IS NULL
		OR
		customer_id	IS NULL
		OR
		gender IS NULL
		OR
		category IS NULL
		OR
		quantiy	IS NULL
		OR
		cogs	IS NULL
		OR
		total_sale IS NULL;

DELETE from retail_sales
WHERE 
		transactions_id	IS NULL
		OR
        sale_date IS NULL
		OR
        sale_time IS NULL
		OR
		customer_id	IS NULL
		OR
		gender IS NULL
		OR
		category IS NULL
		OR
		quantiy	IS NULL
		OR
		cogs	IS NULL
		OR
		total_sale IS NULL;

--Data Exploration

--1. How many sales we have?
select COUNT(*) as total_sales from retail_sales

--2. How many unique customers we have?
select COUNT(DISTINCT customer_id) as total_customers from retail_sales

--3. How many Categories we have?
select DISTINCT category from retail_sales


--Data Analysis & Business Q&A

--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from retail_sales WHERE sale_date = '2022-11-05';

--2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
--the quantity sold is more than 4 in the month of Nov-2022:
select * from retail_sales
WHERE 
	  category = 'Clothing'
	  AND 
	  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	  AND 
	  quantiy >= 4

--3. Write a SQL query to calculate the total sales (total_sale) for each category.
select category, 
		SUM(total_sale) as net_sale,
		count(*) as total_orders 
		from retail_sales
group by category

--4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select  round(AVG(age),2) as average_age 
from retail_sales
WHERE category = 'Beauty'

--5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales 
where total_sale >1000

--6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, count(transactions_id) as total_transactions from retail_sales
group by category, gender
order by 1

--7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year, month, avg_sale
FROM (
	  select 
	  	extract(YEAR from sale_date) as year,
		extract(MONTH from sale_date) as month,
		AVG(total_sale) as avg_sale,
		Rank() over (partition by extract(YEAR from sale_date) order by AVG(total_sale) DESC) as rank
	  from retail_sales
	  group by 1,2
	) as t1
	where rank =1

--8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id, sum(total_sale) as total_sales from retail_sales
group by customer_id
order by total_sales
desc limit 5

--9. Write a SQL query to find the number of unique customers who purchased items from each category.:
select category, Count(DISTINCT customer_id) as unique_customers from retail_sales
group by category

--10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale 
as (
	select *,
	CASE 
		when extract (HOUR from sale_time) <12 then 'morning'
		when extract(HOUR from sale_time) between 12 and 17 then 'Afternoon'
		Else 'Evening'
	end as shift
	from retail_sales
	)
select shift, count(*) as total_orders
from hourly_sale
group by shift

---End of the project










		