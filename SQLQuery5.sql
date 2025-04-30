USE MyDatabase;
-- This is a comment
/* This
uis 
us
*/
--Retrive All Customer Data
SELECT *
FROM customers;
SELECT *
FROM orders;
SELECT first_name,country,score
FROM customers;
--Retrive customers with a score not equal to 0

SELECT *
FROM customers
WHERE score!=0;
SELECT *
FROM customers
WHERE country='Germany';
/* Retrive all customers and sort the results by the highest score first. */
SELECT *
FROM customers
ORDER BY score DESC;
-- lowest score first
SELECT *
FROM customers
ORDER BY score ASC,country DESC;

SELECT country,SUM(score) AS total_score -- this only allows the group by needed columns omly
FROM customers
GROUP BY country;

-- Find the total score and total number of customers for each country

SELECT country,
SUM(score) AS total_score,
COUNT(id) AS total_no
FROM customers
GROUP BY country;

--having clause

/* SELECT country
FROM customers
WHERE score>400
GROUP BY country
HAVING SUM(score)>800*/ 


/*Find the average score for each country considering only customers
with a score not equal to 0*/
SELECT country,AVG(score) AS Average
FROM customers
where score!=0
GROUP by country
Having AVG(score)>430;

--Distinct(Removes Duplicates)
/*SELECT DISTINCT country
FROM customers*/
-- Return Unique list of all countries
SELECT Distinct country
FROM customers

SELECT Top 3 *
From customers; 

SELECT TOP 3 *
FROM customers
ORDER BY score DESC


/*ALTER TABLE persons
add email Varchar(50) NOT NULL;*/

/*select* from persons*/

/*ALTER table persons
drop column phone ;*/

/*select * from persons
DROP Table persons*/


INSERT into customers(id,first_name,country,score)
Values (6,'Rama','Nepal',910);
Select * from customers;

