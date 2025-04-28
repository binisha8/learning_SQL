--joining data
/* Set operators
1.union
2.union all
3.Except(minus)
4.Intersect

JOINS
1.Inner join
2.full join
3.left join
4.right join*/
SELECT *
from customers
select * from orders

--inner join


--get all customers along with their orders,but only for customers who have placed an order
SELECT c.id,c.first_name,o.order_id,o.sales
FROM customers  AS c
INNER JOIN orders AS o
ON c.id=o.customer_id


--left join
SELECT c.id,c.first_name,o.order_id,o.sales
from customers as c
LEFT JOIN orders as o
ON c.id=o.customer_id


--Right join
--Returns all rows from right and only matching from left
SELECT c.id,c.first_name,o.order_id,o.sales
from customers as c
RIGHT JOIN orders as o
ON c.id=o.customer_id


--Get all customers along with their orders including orders without matchin customers(using left join)
SELECT c.id,c.first_name,o.order_id,o.sales
FROM orders AS o
LEFT JOIN customers AS c
ON c.id=o.customer_id  -- same as right join

--FULL join
--Get all customers and all orders ,even if there,s no match
SELECT c.id,c.first_name,o.order_id,o.sales
FROM customers  AS c
FULL JOIN orders AS o
ON c.id=o.customer_id

--ADVANCED SQL JOIN
--left anti join
--Returns row from left that has no match in right
--Get al the customers who haven't place any orders
SELECT * 
from customers as c
Left join orders as o
on c.id=o.customer_id 
where o.customer_id IS NULL

--Right anti join
--returns rows from right that has no match in left

SELECT * 
from customers as c
Right join orders as o
on c.id=o.customer_id 
where c.id IS NULL

SELECT * 
from orders as o
Left join customers as c
on c.id=o.customer_id 
where c.id IS NULL

--Full anti join
--returns only rows that dont match in either tables
SELECT * 
from orders as o
full join customers as c
on c.id=o.customer_id 
where c.id  is null or o.customer_id IS NULL
 

 --Get all customers along with their orders, but only for customers who  have placed an oderselect 
 select *
 from customers as c
 left join orders as o
 on c.id=o.customer_id
 where o.customer_id is not null;

 --Cross join
 --combines every row from left with  every row from right
 select *
 from customers as c
 CROSS join orders as o


 