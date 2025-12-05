<p align="center">
  <img src="https://files.catbox.moe/0v9gto.png" alt="Retail Sales Analysis – SQL Project Banner" width="100%">
</p>


# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sales_project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

1. **How many sales we have?**
```sql
select COUNT(*) as total_sales from retail_sales
```

2.**How many unique customers we have?**
```sql
select COUNT(DISTINCT customer_id) as total_customers from retail_sales
```

3.**How many Categories we have?**
```sql
select DISTINCT category from retail_sales
```
4.**Check for any null values in the dataset and delete records with missing data.**
```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * from retail_sales
WHERE
    sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select * from retail_sales
WHERE 
	  category = 'Clothing'
	  AND 
	  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	  AND 
	  quantiy >= 4
```

3. **Write a SQL query to calculate the total sales for each category.**:
```sql
select category, 
		SUM(total_sale) as net_sale,
		count(*) as total_orders 
		from retail_sales
group by category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select  round(AVG(age),2) as average_age 
from retail_sales
WHERE
    category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions made by each gender in each category.**:
```sql
select category,
    gender,
    count(transactions_id) as total_transactions
from retail_sales
group by category, gender
order by 1
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
select customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select category,
       Count(DISTINCT customer_id) as unique_customers
from retail_sales
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: Sales are driven mainly by young to middle-aged buyers, with demand spread across both male and female customers.
- **High-Value Transactions**:A noticeable portion of purchases exceed a total sale of ₹1000, indicating strong interest in premium products.
- **Sales Trends**: Sales fluctuate across months, revealing peak seasons and slower periods, which can help with inventory and marketing planning.
- **Category Performance**: Certain product categories consistently outperform others, helping identify high-revenue product lines.
- **Customer Behaviour**: A small percentage of customers contribute a high share of the total revenue, highlighting opportunities for targeted marketing and loyalty programs.

## Reports

- **Sales Summary Reoort**: Overall sales performance including total revenue, number of orders, top-selling categories, and segment-wise customer contribution.
- **Trend Analysis Report**: Month-wise and shift-wise sales analysis to understand seasonality and buying time preferences.
- **Customer Insights Report**: Identification of the top 5 customers, repeat buyers, and unique customers per category.

## Conclusion

This SQL-based analysis provides actionable business insights that can help retail stakeholders optimize operations.
By examining customer demographics, sales trends, and category performance, the project demonstrates how SQL can be used not only for data extraction but also for data-driven decision-making.
These insights can support real-world use cases such as marketing strategy, inventory planning, and customer retention programs.

## How to Use

1. **Clone the Repository**: Get the project files from GitHub to your system.
2. **Set Up the Database**: Create the database and table structure using the SQL scripts provided.
3. **Import the Dataset**: Load the CSV file into the retail_sales table.
4. **Run the Queries**: Run the SQL queries inside SQL_Query.sql to reproduce the analysis and insights.
5. **Explore and Modify**: Add your own questions, tweak filters, or expand the analysis to practice advanced SQL concepts.



Thank you for your support, and I look forward to connecting with you!
