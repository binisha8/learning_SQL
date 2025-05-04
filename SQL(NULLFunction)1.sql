--NULL FUNCTION
-- 1. ISNULL()-ISNULL(value,replacement_value)
--ISNULL(shipping_address,'unknown')
--ISNULL(shippping_Address,Billing_Address)

--2.COALESCE(value1,value2,value3,...)
--Example -> COALESCE(shipping_address,'unknown')
--Example -> COALESCE(shipping_address,Billing_Address)
--Example -> COALESCE(shipping_address,Billing_Address,'unknown')
 

--ISNULL Vs COALESCE
/*  ISNULL                 |          COALESCE
 limites to two values     |   unlimited
 Faster                        slow
  
  ISNULL |COALESCE
  (usecase)
   1. handle the null before doing data aggregations*/
  --Find the average scores of the customers
  SELECT 
  CustomerID,
  Score,
  COALESCE(Score,0),
  AVG(Score) OVER () AvgScores,
  AVG(COALESCE(Score,0)) OVER() AvgScores2
  FROM Sales.Customers

  --2. handle the Null before doing mathematical operations

  --Display the full name of customers in asingle field
  --by mergimg their first and lastnames,and add 10 bonus points to
  --each customers score
  Select CustomerID,
  FirstName,
  LastName,
  COALESCE(LastName,'')LastName2,
  FirstName + ' '+  COALESCE(LastName,'') AS FullName,
  Score,
  COALESCE(Score,0) + 10 AS Scorewithbonus
  FROM Sales.Customers

  --3. Handle the NULL before JOINING tables
  /*Select 
  a.year,a.type,a.orders,b.sales
  FROM Table1 a
  JOIN Table2 b
  ON a.year=b.year
  AND ISNULL(a.type,'')=ISNULL(b.type,'')*/

  --SORTING DATA
  --4. Handle the NULL before  sorting data

--Sort the customers from lowest to highest scores, with NULL


SELECT 
CustomerID,
Score
FROM Sales.Customers
ORDER BY Score 


--1. Method-Replace the nulls with evry big number
SELECT 
CustomerID,
Score,
CASE WHEN Score IS NULL THEN 1 ELSE 0 END FLAG
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END,Score

--NULLIF - Compares two expressions  returns:
           --NULL,if they are equal
		   --First Value,if they are not equal
-- NULLIF(value1,value2)
-- NULLIF(Shipping_Address,'unknown') 
-- NULLIF(Shipping_Address,Builling_Address)
-- NULLIF(Price,-1)

--DIVISION BY ZERO-Preventing the error of  dividing by zero

--Find the sales price for each order by dividing the sales by the quantity.
SELECT 
OrderID,
Sales,Quantity
FROM Sales.Orders

SELECT 
OrderID,
Sales,Quantity,
Sales/NULLIF(Quantity,0) AS Price
FROM Sales.Orders

--IS NOT NULL
--Identify the customers who have no scoores

SELECT 
*
FROM Sales.Customers
WHERE Score IS  NULL

SELECT 
*
FROM Sales.Customers
WHERE Score IS NOT NULL


--IS NULL USE CASE 
--ANTI JOINS
 

 --list all details for customers who have not placed any orders

 SELECT
 c.*,
 o.OrderID
 From Sales.Customers c
 LEFT JOIN
 Sales.Orders o
 ON c.CustomerID=o.CustomerID
 WHERE o.CustomerID IS NULL

 --BLANK SPACE ' '
 --String value has one or more space chharacters


 ;WITH Orders AS(
 SELECT 1 Id,'A' Category UNION
 SELECT 2, null UNION
 SELECT 3, ''UNION
 SELECT 4,'  '
 )
 SELECT 
 *,
 DATALENGTH(Category) CategoryLen
 FROM Orders

 --Handling Nulls(DATA POLICIES)
 -- #1. DATA POLICY--Only use NULLs and emplty Strings,but avoid blank spaces.

 ;WITH Orders AS(
 SELECT 1 Id,'A' Category UNION
 SELECT 2, null UNION
 SELECT 3, ''UNION
 SELECT 4,'  '
 )
 SELECT 
 *,
 TRIM(Category) Policy1,
 DATALENGTH(TRIM(Category) ) Policy1
 FROM Orders

 -- #2 DATA POLICY
 -- Only use NULLS and avoid empty strings and blank spaces
 ;WITH Orders AS(
 SELECT 1 Id,'A' Category UNION
 SELECT 2, null UNION
 SELECT 3, ''UNION
 SELECT 4,'  '
 )
 SELECT 
 *,
 TRIM(Category) Policy1,
 DATALENGTH(TRIM(Category) ) Policy1,
 NULLIF(TRIM(Category),'') Policy2
 FROM Orders

 --#3 DATA POLICY
 -- Use the default value 'unknown' and avoid using nulls, empty strings , and blank spaces
 ;WITH Orders AS(
 SELECT 1 Id,'A' Category UNION
 SELECT 2, null UNION
 SELECT 3, ''UNION
 SELECT 4,'  '
 )
 SELECT 
 *,
 TRIM(Category) Policy1,
 DATALENGTH(TRIM(Category) ) Policy2,
 COALESCE(NULLIF(TRIM(Category),''), 'unknown') Policy3
 FROM Orders

