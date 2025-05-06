--Window Functions
   --Perform calculations(eg.aggregation) on a specific subset of datta, without
   --losing the level of details of rows

   --Group by will returns a single row for each group but Window will returns a result for each row


   --Find the total sales across all orders
   SELECT
   SUM(Sales) TotalSales
   FROM Sales.Orders

   --Find the total sales for each product
   SELECT
   ProductID,
   SUM(Sales) TotalSales
   FROM Sales.Orders
   GROUP BY ProductID

    --Find the total sales for each product, additionally provide details such order id and order date

	SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(sales) OVER(PARTITION BY ProductID)TotalSalesByProducts
	FROM Sales.Orders
	

	--WINDOW SYNTAX
	--Partition By-Divides the result set into partitions(Windows)
	--Find the total sales across all orders additionally provide details such order id and order date


	SELECT 
	OrderID,
	OrderDate,
	SUM(Sales) OVER() TotalSales
	From Sales.Orders

--Find the total sales for each product, additionally provide details such order id and order date
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) Over (PARTITION BY ProductID) TotalSales
	From Sales.Orders
	
	--Find the total sales across all orders
	--Find the total sales for each product,
	--additionally provide details such order id and order date

	SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER() TotalSales,
	SUM(Sales) Over (PARTITION BY ProductID) TotalSalesByProducts
	From Sales.Orders

	--Find the total sales across all orders
	--Find the total sales for each product,
	--Find the total sales for each combination of Product and orderStatus
	--additionally provide details such order id and order date

	
	SELECT 
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) OVER() TotalSales,
	SUM(Sales) Over (PARTITION BY ProductID) TotalSalesByProducts,
	SUM(Sales) OVER (PARTITION BY ProductID ,OrderStatus) SalesByProductsAndStatus
	From Sales.Orders 


	--RAnk each order based on their sales from highest to lowest, additionally provide details such order id and order date

	SELECT 
	OrderID,
	OrderDate,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) RankSales
	FROM Sales.Orders

	--Windoow FRAME
	 SELECT 
	 OrderID,OrderDate,
	 OrderStatus,Sales,
	 SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	 ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
	 FROM Sales.Orders
	

	--COMPACT fRAME
	--For only PRECEDING ,the CURRENT ROW can be skipped
	--NORMAL FORM-Rows BETWEEN CURRENTT ROW AND 2 FOLLOWING
	--SHORT FORM -ROWS 2 FOLLOWING
	SELECT 
	 OrderID,
	 OrderDate,
	 OrderStatus,
	 Sales,
	 SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
	 ROWS 2 PRECEDING) TotalSales
	 FROM Sales.Orders

--4X Rules

-- #1 RULE
--Window functions can be used ONLY in select and ORDER BY Clauses

-- #2 RULE 
--Nesting Window Functions is not allowed

-- #3 RULE
--SQL execute WINDOW Functions after WHERE Clause

SELECT 
OrderID,
OrderDate,
OrderStatus,
ProductID,
Sales,
SUM(Sales) OVER (PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN (101,102)


-- #4 RULE
--Windoe Function can be used together with GROUP BY in the same query,ONLY if the 
--same columns are used


SELECT 
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY SUM(Sales) DESC) RankSales
FROM Sales.Orders
GROUP BY CustomerID 


SELECT 
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY CustomerID DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID


