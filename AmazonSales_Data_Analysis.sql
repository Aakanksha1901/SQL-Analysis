create database AMAZONSALES;
use AMAZONSALES;

-- Display all records from the sales table.
-- Show only the first 10 rows of the dataset.
select * from amazon_sales limit 10;

-- Find the total number of records in the table.
select count(*) as Total from amazon_sales;

-- list all unique product categories available.
select distinct category as Categories from amazon_sales;

-- Find the total sales amount for all orders.
select sum(total_sales)as total_amount from amazon_sales;

-- Find the average order value.
select avg(total_sales) as Average_value from amazon_sales;

-- Display all orders where the sales amount is greater than 10,000.
select * from amazon_sales where total_sales > 10000;

-- Count how many orders were placed for each product category.
select product as Product_name , count(*) as total_quantity from amazon_sales 
group by product;


-- Find the maximum and minimum sales amount.
select max(total_sales) as MaximumValues , min(total_sales) as MinimumValue from amazon_sales;

-- Show all orders placed in the year 2025.
select * from amazon_sales where date  between '2025-01-01' and '2025-12-31';
SELECT *
FROM amazon_sales
WHERE YEAR(date) = 2025;

-- Find the total sales for each region.
select customer_location, sum(total_sales) as Total from amazon_sales group by customer_location;

-- Display all records from the sales table.
select * from amazon_sales;

-- Show only order_id, product, and total_sales.
select order_id , product , total_sales from amazon_sales;

-- Find all orders where status = 'Cancelled'.
select * from amazon_sales where status = "Cancelled";

--  List distinct product categories available in the dataset.
select distinct category as Categories from amazon_sales;

-- Show all orders made using Credit Card payment method.
select * from amazon_sales where payment_method = "Credit Card" ;

-- Find orders where quantity is greater than 2.
select product , category, quantity from amazon_sales where quantity > 2;

-- Retrieve all sales records for customers from New York.
select product ,total_sales as All_Sales from amazon_sales where customer_location = "New York";

-- Sort orders by total_sales in descending order.
select * from amazon_sales order by total_sales desc;

-- Count the total number of orders.
select count(*) as Total from amazon_sales;

-- Find the maximum total_sales value.
select product as Name ,total_sales as max_ordervalue from amazon_sales
order by total_sales desc limit 1;

SELECT MAX(total_sales) AS max_total_sales
FROM amazon_sales;


-- Find the minimum product price.
select  product as name, price as min_priceofproduct from amazon_sales
order by price 
limit 1;

-- Show all orders for the product Running Shoes.
select * from amazon_sales where product = "Running Shoes" ;

-- Count how many orders are Pending.
select count(*) as Pending_orders from amazon_sales where status = "Pending";

-- Display orders where price is greater than 100.
select order_id , total_sales as PriceValue from amazon_sales where total_sales > 100 ; 

-- Show unique customer locations.
select distinct customer_location as Unique_loactions from amazon_sales;

-- Calculate total revenue (SUM(total_sales)) from all orders.
select sum(total_sales) as total_revenue from amazon_sales;

-- Find total sales per category.
select category, sum(total_sales) as sales from amazon_sales
group by category;

-- Find average order value (AVG(total_sales)).
select avg(total_sales) as averagevalue from amazon_sales;

-- Count number of orders per payment_method.
select  payment_method as Method , count(*) as OrderNumbers from amazon_sales
group by payment_method ;

-- Find total quantity sold for each product.
select product as Product_name , sum(quantity) as total_quantity from amazon_sales 
group by product;

-- Identify the top 5 highest sales orders.
select * from amazon_sales order by total_sales desc limit 5;

-- Find customers who placed more than one order.
select customer_name as name , count(*) as order_count from amazon_sales
group by customer_name
having count(*) > 1;

-- Calculate total sales by customer_location.
select customer_location, sum(total_sales) as Total from amazon_sales group by customer_location;

-- Find the product with the highest total sales.
select product , sum(total_sales) as Total_value from amazon_sales 
group by product
order by Total_value desc
limit 1;


-- Show monthly sales trend using the date column.
 SELECT 
  to_char(date, 'YYYY-MM') AS month,
  SUM(total_sales) AS monthly_sales
  FROM amazon_sales
  GROUP BY month
  ORDER BY month; 

-- Find average price of products in each category.
select  category as name, avg(price) as average_price from amazon_sales
group by category;

-- Count number of cancelled orders per category.
select category as name , count(*) as Count from amazon_sales where status ="Cancelled"
group by category;

-- Find customers whose total purchase value exceeds 500.
select customer_name as customer , total_sales as sales from amazon_sales where total_sales < 500 ;

-- Find payment method contributing the highest revenue.
select payment_method , sum(total_sales) as highest_revenue from amazon_sales
group by payment_method
order by highest_revenue desc limit 1;

-- Show category-wise average quantity sold per order.
select category , avg(quantity) as average_quantity from amazon_sales
group by category;

-- Find orders where total_sales is greater than the overall average sales.
select * from amazon_sales where total_sales > ( select avg(total_sales) from amazon_sales);

-- Rank products based on total revenue generated.
select product as Products , sum(total_sales) as Total_Revenue from amazon_sales 
group by product
order by Total_Revenue desc;

-- Identify locations with more than 5 orders.
select customer_location , count(*) as Orders from amazon_sales
group by customer_location 
having count(*) > 5;

-- Calculate percentage contribution of each category to total revenue.
select category , sum(total_sales) as category_sales ,
round(
(sum(total_sales)* 100) /
(select sum(total_sales) from amazon_sales) , 2
) as revenue_percentage
from amazon_sales
group by category;

-- Find customers who used more than one payment method.
select customer_name as NAME , count(distinct payment_method) as PaymentMethods_used from amazon_sales
group by customer_name
having count(distinct payment_method) > 1;

-- Find the top 5 products by total sales.
select * from amazon_sales order by total_sales desc limit 5;

-- Display total sales and total quantity sold per category.
select category as CATEGORY ,
sum(total_sales) as TotalSales , 
sum(quantity) as Quantity from amazon_sales
group by category;

-- Find the average sales per order for each region.
select customer_location as Region , avg(total_sales) as Sales 
from amazon_sales
group by customer_location;

-- List customers whose total purchase value is greater than the overall average sales.
select * from amazon_sales where total_sales > (select avg(total_sales) as avg_sales from amazon_sales);

-- Display categories where total sales exceed 1,00,000.
select category , sum(total_sales) as total_sales from amazon_sales
group by category
having sum(total_sales) > 100000;


-- Identify the region with the highest number of orders.
select customer_location as region , count(*) as Maximum_orders
from amazon_sales
group by customer_location
order by Maximum_orders desc limit 1;


-- Find the second highest sales amount.
select  total_sales as sales
from amazon_sales
order by total_sales desc 
limit 1 offset 1;

SELECT MAX(total_sales) AS second_highest_sales
FROM amazon_sales
WHERE total_sales < (
    SELECT MAX(total_sales)
    FROM amazon_sales
);

-- Show orders where the sales amount is above the average sales.
select * from amazon_sales where total_sales > (select avg(total_sales) as avg_sales from amazon_sales);

-- Count how many distinct customers placed orders in each region.
select customer_location as region , count(distinct customer_name) as name from amazon_sales
group by customer_location;

-- Find customers who have never placed an order above 10,000.
SELECT customer_name
FROM amazon_sales
GROUP BY customer_name
HAVING MAX(total_sales) <= 10000;


-- Show regions where average sales per order is greater than the overall average.
select customer_location as region from amazon_sales 
group by customer_location 
having avg(total_sales) > (select avg(total_sales) as avg_sales from amazon_sales);

-- Find customers who have placed orders in more than one region.
select customer_name as name from amazon_sales 
group by customer_name
having count(distinct customer_location) > 1;

-- Find the top 3 products by total revenue.
select product as products , sum(total_sales) as total_revenue from amazon_sales
group by product 
order by total_revenue desc limit 3;

-- Find the bottom 3 products by total revenue.
select product as products , sum(total_sales) as total_revenue from amazon_sales
group by product 
order by total_revenue  limit 3;



