--SubQueries and Nested Selects
--Subquery:A query inside another query

  --Cannot evaluate Aggregate functions like AVG() in WHERE clause 
  --Therefore ,use a sub-SELECT expression

  SELECT * FROM Sales.Employees

  SELECT EmployeeID,FirstName,LastName,Salary
  from Sales.Employees
  WHERE Salary<(SELECT AVG(Salary) from Sales.Employees);


  --subqueries in list of columns
  SELECT EmployeeID,Salary,
  (SELECT AVG(Salary) from Sales.Employees)
    AS AVG_Salary
	FROM Sales.Employees;


--Subqueries in FORM clause
    --Substitute the table name with a sub query
	--Called

SELECT *
FROM(SELECT EmployeeID,FirstName,LastName,Department from Sales.Employees) AS Employeee


--Find the products that have a price higher the average price of all products
SELECT 
*
FROM
(SELECT ProductID,Price,AVG(Price) OVER() AvgPrice
FROM Sales.Products)t
WHERe price>AvgPrice




SELECT *
FROM Sales.Products
Where Price>(SELECT AVG(Price) from Sales.Products)



--Mainly 2 types of subqueries based on dependency

   --1.Noncorrelated Subqueries
   --2.Correlated Subqueries


--Subqueries based on Result Types

   --1.Scalar subquery:Single Value
   --2.Row Subquery : Multiple Rows and Single column
   --3.Table Subquery:Multiple rows and  Multiple Columns
  
  
--Location|Clauses
  --Select
  --From
  --Before Join
  --Where
      

--Rank Customers based on their total amount of sales
SELECT * FROM Sales.Orders


SELECT
*,
RANK() OVER (ORDER BY TotalSales DESC) CustomerRank
FROM(
SELECT
CustomerID,
SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID)t


--SELECT Subquery
/* SELECT
  Column1,
  (SELECT column FROM table Where condition)
FROM table*/


--Show the product IDs,names,prices and total number of orders
SELECT 
ProductID,
Product,
Price,
(SELECT count(*)  FROM Sales.Orders ) AS TotaalOrders
FROM Sales.Products

--JOIN Subquery
--Used to prepare the data(filering or aggregation) before joining it with other tables


--Show all customers details and find the total orders for each customer
SELECT 
*
FROM Sales.Customers c
LEFT JOIN(SELECT CustomerID,
          Count(*) TotalOrders
          FROM Sales.Orders
          GROUP BY CustomerID)o
ON c.CustomerID=o.CustomerID

--WHERE Subquery:Used for complex filtering logic and makes flexible and dynamic
/*SELECT
Column1,column2,......
FROM table1
WHERE column=(SELECT column FROM table2 WHERE condition)*/


--Find a product that have a price higher than the average price of al the products
SELECT 
ProductID,
Price
FROM Sales.Products
WHERE Price >(SELECT  AVG(Price) FROM Sales.Products)


--IN OPERATOR:Checks whether a value matches any value from a list
/*Filteriing (List of Valued)
SELECT 
*
FROM Sales.Orders
WHERE CustomerID IN (1,2,3)

SELECT column1,Column2,......
FROM table1 WHERE column IN (SELECT column FROM table2 WHERE condition)*/


--SELECT the details of orders made by customers in Germany.
SELECT 
*
FROM Sales.Orders
WHERE CustomerID IN (SELECT CustomerID from Sales.Customers 
                     WHERE Country = 'Germany')


SELECT 
*
FROM Sales.Orders
WHERE CustomerID NOT IN (SELECT CustomerID from Sales.Customers 
                     WHERE Country = 'Germany')


--ANY ALL
  --ANY operator:Check if a value matches ANY value within alist
  --Used to check if a value is true for ATLEAST one of thevalues in a list


/*SELECT
Column1,column2,......
FROM table1
WHERE column <ANY (SELECT column FROM table2 WHERE condition)*/


--Find female employeees whose salaries are greater than the salaries of any male employees
SELECT 
EmployeeID,
FirstName,Gender,Salary
FROM Sales.Employees
WHERE GENDER ='F'
AND Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender ='M');

--ALL Operator:Checks if a value matches all values within a list

--Find female employees whose salaries are greater than the salaries of all male employees
SELECT 
EmployeeID,
FirstName,Gender,Salary
FROM Sales.Employees
WHERE GENDER ='F'
AND Salary > ALL (SELECT Salary FROM Sales.Employees WHERE Gender ='M');



--NON-CORRELATED SUBQUEY:A Subquery that can run independtlyy from the main Query
--CORRELATED SUBQUERY:A subquery that relays on values from the main query

--using correlated subquery
--Show all customer details and find the total orders of each customers
SELECT *,
(SELECT COUNT(*) FROM Sales.Orders o WHERE o.CustomerID=c.CustomerID) TotalSales
FROM Sales.Customers c

--correlates subquery in WHERE Clause Exists operator
--Exists


/*SELECT column1,column2,...
FROM Table2 
WHERE EXISTS (SELECT 1
             FROM Table1
			 WHERE Table1.ID=Table2.ID)*/

--Show the details of orders made by customers in Germany
SELECT
*
FROM Sales.Orders o
WHERE EXISTS(SELECT 
             3
             FROM Sales.Customers c
             WHERE Country='Germany'
             AND o.CustomerID=c.CustomerID)



--Correlated Subquery:Depends on the main query and can't be executes on its own
--Non-Correlated Subquery:Independent of the main query can be executed on its own