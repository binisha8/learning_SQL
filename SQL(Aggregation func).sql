--Aggregate Functions

--Find the total number of Orders
Select
Count(*) AS total_no_orders
FROM orders

Select* from orders

--Find the total sales of all orders
SELECT 
SUM(sales) AS total_sales
From Orders

--Find the average sales of all the orders
Select 
AVG(sales) AS average
From orders

--Find the highest score among customers
SELECT 
MAX(sales) AS highest
From Orders

--Find the lowest score among customers
SELECT 
MIN(sales) AS lowest
From Orders


