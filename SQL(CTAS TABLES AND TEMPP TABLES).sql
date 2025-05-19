---CTAS TABLES & TEMP TABLES

--TABLE TYPES
   --Permanent Table
   --Temporary table


--CREATE/INSERT
 --1.Create|Define the structure of the table
 --2.Insert|Insert Data into the table


 --CTAS(CREATE TABLE AS SELECT)
   --create a new table based on the result of an SQL query

--CTAS Syntax
/*
CREATE TABLE Table-Name
(
ID INT,
Name VARCHAR(50)
)

INSERT INTO Table-Name
VALUES (1,'Frank')*/

SELECT 
  DATENAME(MONTH,OrderDate) OrderMonth,
  COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(month,OrderDate)

SELECT * FROM Sales.MonthlyOrders


--If we want to drop the table
DROP TABLE Sales.MonthlyOrders

--T-SQL
SELECT 
  DATENAME(MONTH,OrderDate) OrderMonth,
  COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(month,OrderDate)


--TEMPORARY TABLES
  --Stores intermediate results in temporary storage  within the database during the session The database will drop all temporary tables once the session ends.


  /*
  SELECT...
  INTO #NewTable
  FROM ....
  WHERE.....
  */

  SELECT
  *
  INTO #Orders
  FROM Sales.Orders


  SELECT 
  *
  FROM #Orders


  DELETE FROM #Orders
  WHERE OrderStatus='Shipped'


  SELECT
  *
  INTO Sales.OrdersTest
  FROM #Orders
  -- 1.Load Data to TEMP Table
  -- 2.Transform Data in TEMP Table
  -- 3.Load TEMP Table into Permanent Table
  --Once we close the session everything will be close
