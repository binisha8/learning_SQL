--COMMON TABLE EXPRESSION(CTE):TEMPORARY,NAMED RESULT SET(VIRTUAL TABLE),THAT CAN BE USED MULTIPLE TIMES WITHIN YOUR QUERY
--TO SIMPLIFY AND ORGANIZE COMPLEX QUERY

--CTE TYPES
   --1.non-Recursive CTE
     --a.Standalone CTE
	 --b.RecursiveCTE
   --2. Recursive CTE

   --CTE Syntax
 /*  WITH CTE-Name AS
   (SELECT ....
   FROM...
   WHERE.....
   )


   SELECT ...
   FROM CTE-Name
   WHERE...*/

   --STEP1:Find the total Sales Per Customers
WITH CTE_Total_Sales AS
(
   SELECT
   CustomerID,
   SUM(Sales) AS TotalSales
FROM Sales.Orders
Group BY CustomerID

)
SELECT 
c.CustomerID,
c.FirstName,
c.LastName
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID=c.CustomerID


--CTE RULE :WE cannot use ORDER BY directley

--MULTIPLE STANDALONE CTEs

/* WITH CTE-Name AS
   (SELECT ....
   FROM...
   WHERE.....
   )
   ,CTE-Name2 AS
   (SELECT ....
   FROM...
   WHERE.....
   )
   ,CTE-Name3 AS
   (SELECT ....
   FROM...
   WHERE.....
   )

   SELECT ...
   FROM CTE-Name1
   join CTE-Name2
   WHERE...*/

   --STEP2:Find the last order date for each customer
 ;WITH CTE_Total_Sales AS (
    SELECT 
        CustomerID,
        SUM(Sales) AS TotalSales
    FROM Sales.Orders
    GROUP BY CustomerID
),
CTE_Last_Order AS (
    SELECT 
        CustomerID,
        MAX(OrderDate) AS Last_Order
    FROM Sales.Orders
    GROUP BY CustomerID
)
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    cts.TotalSales,
    clo.Last_Order
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
    ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
    ON clo.CustomerID = c.CustomerID;




	--NESTED CTE
--cTE inside another CTE 
--A nested CTE uses the result of another CTE, so it can't run independently
/*

WITH CTE_Name1 AS (
    SELECT ...
    FROM ...
    WHERE ...
),
CTE_Name2 AS (
    SELECT ...
    FROM CTE_Name1
    WHERE ...
)
SELECT ...
FROM CTE_Name2
WHERE ...;
*/

--Poject

--1. Find the total sales per customer
--2.Find the last order date per customer
--3. Rank customers based on total sales per customer
 ;WITH CTE_Total_Sales AS (
    SELECT 
        CustomerID,
        SUM(Sales) AS TotalSales
    FROM Sales.Orders
    GROUP BY CustomerID
),
CTE_Last_Order AS (
    SELECT 
        CustomerID,
        MAX(OrderDate) AS Last_Order
    FROM Sales.Orders
    GROUP BY CustomerID
),
CTE_Customer_Rank AS
(
SELECT 
CustomerID,
TotalSales,
RANK() OVER (ORDER BY TotalSales DESC) AS CustomerRank
FROM CTE_Total_Sales
)

--Segment  customers based on their total sales

,CTE_Customer_Segments AS
(
SELECT
CustomerID,
CASE WHEN TotalSales>100 THEN 'High'
     WHEN TotalSales>80 THEN 'High'
	 ELSE 'LOW'
END CustomerSegments
FROM CTE_Total_Sales
)
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    cts.TotalSales,
    clo.Last_Order,
	ccs.CustomerSegments



FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
    ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
    ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank ccr
    ON ccr.CustomerID=c.CustomerID
LEFT JOIN CTE_Customer_Segments ccs
    ON ccs.CustomerID=c.CustomerID


--Non-Recursive CTE:is executed only once without aby reception
--Recursive CTE:Self-referencing query that repeatedly processes data until a specific condition is met  
/*
;WITH CTE-Name AS
(
SELECT....(Anchor query)
FROM....
WHERE....

UNION ALL

SELECT...(Recursive Query)
FROM CTE-NAME
WHERE[BREAK CONDITION]
)
SELECT ..(MAIN query)
FROM CTE-NAME
WHERE.....*/

--GENERATE a Sequence of numbers from 1 to 20
;WITH Series AS(
--Anchor Query
SELECT 
 1 AS MyNumber
 UNION ALL 
 --Recrusive Query
 SELECT
 MyNumber+1
 FROM Series
 WHERE MyNumber<20
 --WHERE MyNumber<1000
 )
 --Main Query
 SELECT *
 FROM Series
-- OPTION(MAXRECURSION 1000) if we need more than 100 recursion


--Show the employee hierarchy by displaying each employee's level within the organization
--Anchor Query
-- Recursive CTE for Employee Hierarchy
;WITH CTE_Emp_Hierarchy AS (
    -- Anchor query: top-level managers (no manager)
    SELECT 
        EmployeeID,
        FirstName,
        ManagerID,
        1 AS Level
    FROM Sales.Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Recursive query: employees reporting to those in CTE
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.ManagerID,
        ceh.Level + 1
    FROM Sales.Employees AS e
    INNER JOIN CTE_Emp_Hierarchy AS ceh
        ON e.ManagerID = ceh.EmployeeID
)

-- Final output
SELECT *
FROM CTE_Emp_Hierarchy;



--NOTE:Donot use more than 1 CTE in one query 