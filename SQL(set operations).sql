--SET OPERATORS


/* #RULE |SQL CLAUSES
-SET operator can be used almost in all clauses WHERE|JOIN|GROUP BY|
 HAVING
-ORDER BY is allowed only once at the end of query


#RULE 2
-The numbers of columns in each query must be the same


-# RULE 3
   Data types of columns in each query must be compatible
  
-# RULE 4
   The order of the columns in each query must be the same
   SELECT
   CustomerID,(int)
   LastName(varchar)
   FROM Sales.Customers

   UNION

   SELECT
   EmployeeID,(int)
   LastName(varchar)
   FROM Sales.Employees

# RULE 5
  the column names in the result set are determined by the column
  names specified in the first query
  -- 1st query controls the datatype

  SELECT 
  CustomerID AS ID,
  LastName AS Last_Name
  FROM Sales.Customers

  UNION

  SELECT 
  EmployeeID ,
  LastName 
  FROM Sales.Employees

# RULE 6 
- Even if all rules are met and SQL shows no errors,
  the result may be incorrect
- Incorrect column selection leads to inaccurate results

  SELECT 
  FirstName,
  LastName AS Last_Name
  FROM Sales.Customers

  UNION

  SELECT
  LastName,
  FirstName
  FROM Sales.Employees


*/
/* 1.  UNION
-Returns all distinct rows from both queries
-Removes duplicate rows from the results
*/

SELECT
FirstName,
LastName
FROM Sales.Customers

Union

Select FirstName,
LastName
FROM Sales.Employees


-- Combine the data from employees and customers into one table

SELECT *
FROM Sales.Customers;
SELECT * 
FROM SALES.Employees;

SELECT 
FirstName,
LastName
FROM Sales.Customers
Union
SELECT 
FirstName,
LastName
FROM Sales.Employees


-- UNION aLL
--Returns all rows from both queries,including duplicates

SELECT 
FirstName,
LastName
FROM Sales.Employees
UNION aLL
SELECT 
FirstName,
LastName
FROM Sales.Customers

/*EXCEPT
--Returns all distinct rows from the first query that are not found
--in the second query*/
   
--Find the employees who are not customers at athe same time

SELECT 
FirstName,
LastName
FROM Sales.Employees
EXCEPT
SELECT 
FirstName,
LastName
FROM Sales.Customers

/*Intersect
--reutrns commons rows betweenn two tables
--Find the employees who are also customers*/

SELECT 
FirstName,
LastName
FROM Sales.Employees
Intersect
SELECT 
FirstName,
LastName
FROM Sales.Customers

--Application of set operators

--Combine information
--Combine similar information before analyzing the data


--Orders are stored in separate tables(orders and ordersArchive)
--Combine all orders into one report without duplicates

SELECT 'Orders' AS sourceTable
       ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT 'OrdersArchive' AS sourceTable 
,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive
Order by OrderID

/* Data completeness Check
--Except operatoor can be used to compare tables
--to detect dicrepancies between databases*/

