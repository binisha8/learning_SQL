 --CASE STATEMENT
 -- #1 USE CASE(CATEGORIZING DATA)
 --main purpose of CASE is Data Transformation
       --Derive new information
	   --Create new columns based on existing data
 --Categorizing Data - Group the data into different categories based on certain conditions

 --SQL task-Generate a report showing the total sales for each category:
   -- High :if the sales higher than 50
   -- Medium :if the sales between 20 and 50
   -- Low : if the sales equal or lower than 20
   --sort the result from lowes

   SELECT
   Category,
   SUM(sales) AS TotalSales
   FROM(
   SELECT
   OrderID,
   Sales,
   CASE
       WHEN Sales >50 THEN 'High'
	   WHEN Sales  >20 THEN 'Medium'
	   ELSE 'LOW'
   END Category
   FROM Sales.Orders
   )t
   GROUP BY Category
   ORDER BY TotalSales DESC
--The datatype of the  results must be matching while using CASE
--CASE statement can be used anywhere in the query

-- #2 USE CASE(Mapping Values)
--RETRIVE employee details with gender displayed as full text

SELECT 
*
FROM Sales.Employees

SELECT 
EmployeeID,
GENDER,
CASE
  WHEN Gender = 'M 'THEN 'Male'
   WHEN Gender = 'F 'THEN 'Female'
  ELSE 'Not Available'
END GenderFullText
FROM Sales.Employees

--Retrive customer details with abbreviated country code
SELECT 
*
FROM Sales.Customers
SELECT Distinct country
From Sales.customers;

SELECT
CustomerID,
FirstName,
LastName,
Country,
CASE
  WHEN Country='Germany' THEN 'DE'
  WHEN Country='USA' THEN 'US'
  ELSE 'n/a'
END CountryAbbr
FROM Sales.Customers


--CASE STATEMENT
--QUICK FORM
 -- if we don't want to use country continuously we can use case Country 

 SELECT
CustomerID,
FirstName,
LastName,
Country,
CASE
  WHEN Country='Germany' THEN 'DE'
  WHEN Country='USA' THEN 'US'
  ELSE 'n/a'
END CountryAbbr,
CASE Country
  WHEN 'Germany' THEN 'DE'
  WHEN 'USA' THEN 'US'
  ELSE 'n/a'
END CountryAbbr
FROM Sales.Customers


--#3 USE Case
--Handling nulls-Replace Nulls with a specific value
--Nulls can lead to in accurate results,which can lead to wrong decision making

/*SQL TASK
FIND THE AVERAGE SCORES OF CUSTOMERS AND TREAT NULLS AS 0
*/
SELECT
CustomerID,LastName,
Score,
AVG(CASE 
    WHEN Score IS NULL THEN 0
	ELSE Score 
END ) Over() AVGCUSTOMER,

AVG(Score) OVER() AvgCustomer
FROM Sales.Customers

--CONDITIONAL aGGREGATION - Apply aggregate funtions only on subsetsof data
--that fulfill certain conditions.

--Count how namy times each customer has made an order with sales greater than 30

SELECT 
CustomerID,
SUM(CASE 
    WHEN Sales >30 THEN 1
	ELSE 0
END)TotalOrders
FROM Sales.Orders
GROUP BY CustomerID

