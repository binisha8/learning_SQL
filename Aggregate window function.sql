-- COUNT() -Returns the number of rows within a window
--Find the total number of Orders for each product

--COUNT(*) - counts all the rows in a table regardless of whether any value is NULL

--COUNT(1) =COUNT(*)
--NOTE: Counts the total number of rows,including duplicates,not the unique values!


--Find the total number of orders
SELECT 
*
FROM Sales.Orders

SELECT 
COUNT(*)  TotalOrders
FROM Sales.Orders

--Find the total number of orders additionally  provide details such order id and order date


SELECT
OrderID,
OrderDate,
COUNT(*) OVER() TotalOrders
FROM Sales.Orders

--Find the total number of orders
--Find the total number of orders for each customers
--additionally  provide details such order id and order date
SELECT
OrderID,OrderDate,
CustomerID,
COUNT(*) OVER() TotalOrders,
COUNT(*) OVER(PARTITION BY CustomerID) OrderByCustomers
FROM Sales.Orders


--Find the total number of customers, additionally povide all custmers details
SELECT 
*,
COUNT(*) OVER() TotalCustomers
FROM Sales.Customers



SELECT
*,
COUNT(*) OVER () TotalCustomerStar,
COUNT(1)OVER() TotalCustomersOne,
COUNT(Score) OVER() TotalScores,
COUNT(Country) OVER() TotalCounteries
FROM Sales.Customers -- helping in knowing NULL value


--DATA QUALITY ISSUE 
  --DPLICATES LEADS TO INACCURACIES IN ANALYSIS COUNT() CAN BE USED TO IDENTIFY DUPLICATES
  

  --Check whether the table 'Orders' contains any duplicate rows
  SELECT
  OrderID,
  COUNT(*) OVER (PARTITION BY OrderID) CheckPK
  FROM Sales.Orders

  SELECT
  *
  FROM(
   SELECT
  OrderID,
  COUNT(*) OVER (PARTITION BY OrderID) CheckPK
  FROM Sales.OrdersArchive)t -- if output is 1 then only it is not duplicate otherwise it is duplicate
  WHERE CheckPK >1


  --COUNT|USE CASES
  --#1 Overall Analysis
  --#2 Category Analysis
  --#3 Quality Checks:Identify Nulls
  --#4 Quality Checks:Identify Duplicates

  --SUM()--Returns sum of each values within a window
    --Find the total sales for each product
	--SUM(Sales) OVER(PARTITION BY Product)
	--SUM() Accepts only Numbers

--Find the totalsales across all orders and the  total sales for each product
--additionally  provide details such order id and order date
  SELECT
  OrderID,
  ProductID,
  OrderDate,
  Sales,
  SUM(Sales) OVER() AllOrders,
  SUM(SALES) OVER(PARTITION BY ProductID) Eachproduct 
  FROM Sales.Orders


  --COMPARISION ANALYSIS
     --Compare the current value and aggregated value of window functions


--FIND the percentage contribution of each product's Sales to the total sales

SELECT 
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() TotalSales,
ROUND(CAST(Sales AS FLOAT)/SUM(Sales) OVER() *100,2) PercentageofTotal
FROM Sales.Orders

--AVG() :Find the average of values within a window
--AVG(Sales)OVER (PARTITION BY product)

--Find the average sales across all orders and the average sales for each product.
--Aditionally,Provide details such as orderID and OrderDate

SELECT
OrderID,
OrderDate,
Sales,
ProductID,
AVG(Sales) OVER() AVGSales,
AVG(Sales) OVER(PARTITION BY ProductID)AvgSalesByProducts 
FROM Sales.Orders

--FIND the average scores of Customers Aditionally,Provide detail such as CustoomerID and LastName
SELECT
CustomerID,
LastName,Score,
COALESCE(Score,0) CustomerScore,
AVG(Score) OVER() AVgScore,
AVG(COALESCE(Score,0) ) OVER () AVGScorewithoutNULL
FROM Sales.Customers

--find all orders where sales are higher than the average sales all orders
SELECT 
*
FROM(SELECT
OrderID,
ProductID,
Sales,
AVG(Sales) OVER() AvgSales
FROM Sales.Orders)t
WHERE Sales > AvgSales


 --AGGREGATE WINDOW FUNCTION(MIN/MAX)
--MIN(Sales) OVER(PARTITION BY Product) 
--MAX(Sales) OVER(PARTITION BY Product)


--Find the highest  and lowest sales of all products
--Find the highest and lowest sales for each product
--Additionally provide details such oredr ID,Order date


SELECT
OrderId,
OrderDate,
ProductID,
Sales,
MAX(Sales) OVER() HighestSales,
MIN(Sales) OVER() LoWESTSales,
MAX(Sales) OVER(PARTITION BY ProductID) HighestSales,
MIN(Sales) OVER(PARTITION BY ProductID) LoWESTSales
 FROM Sales.Orders

 --Show the employees with the highest salaries
 SELECT
 *
 FROM(SELECT *,
 MAX(Salary) OVER() HighestSalary
 FROM Sales.Employees)t
 WHERE Salary=HighestSalary


 --Find the deviation of each sales from the minimum and maximum sales amount
 SELECT
OrderId,
OrderDate,
ProductID,
Sales,
MAX(Sales) OVER() HighestSales,
MIN(Sales) OVER() LoWESTSales,
Sales-MIN(Sales) OVER() DeviationFromMin,
MAX(Sales) OVER()- Sales DeviationFromMax
 FROM Sales.Orders

 --RUNNING annd ROLLING TOTAL
   --They aggregate sequence of members, and the aggregation is updated each time a new member is added
 --RUNNING TOTAL
       --Aggregate all values frim the beginning u to the current point without dropping off older data
	   --SUM(Sales) OVER(ORDER BY Month)
	   --DEFAULT(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
--ROLLING TOTAL
  --Aggregate all values within a fixed time window(eg 30 days)
  --As new data is added, the oldest data point will be dropped
   --SUM(Sales) OVER (ORDER BY MOMTH ROWS BETWEEN @PRECEDING AND CURRENT ROW)


--ANALYTICAL USE CASE(MOVING AVERAGE)
--Calculate moving average of sales for each product over time

SELECT 
OrderId,
ProductID,
OrderDate,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg
FROM Sales.Orders
--If you see the result then of 101 1. is 10 and 2. is (10+20)/2 =15 and same for other and for 102.........


--Calculate moving average of sales for each product over time, including only the next order 
SELECT 
OrderId,
ProductID,
OrderDate,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) ROLLINGAVG
FROM Sales.Orders


-- OVERALL TOTAL :SUM(Sales) OVER()(Overview of entire data)
-- Total per Groups : SUM(Sales) OVER( PARTITION BT Product)->Compare Categories
-- Running Total: SUM(Sales) OVER(ORDER BY Month)->Progress iver time
--Rolling Total:SUM(Sales) OVER(ORDER BY MONTH ROWS 2PRECEDING)-> progress over time in specific fixed window



--ranking window function
    -- 1.Integer Based Ranking
	 --Assign an integer for each row
	 --For eg. Find top 3 products 
	      --4types of integer based ranking
		    --ROW_NUMBER()
			--RANK()
			--DENSE_RANK()
			--NTILE()
		  
	
	
	
	
	
	--2. Percentage-based Ranking
	  
      --Assign a percentage to each row
	  --For eg: Find Top 20% products
	     --2 types of Percentage based ranking
		     --CUME_DIST()
			 --PERCENT_RANK()
/*
| Function         | Expression | Partition Clause | Order Clause | Frame Clause |
| ---------------- | ---------- | ---------------- | ------------ | ------------ |
| `ROW_NUMBER()    | Empty      | Optional         | **Required** | Not allowed  |
| `RANK()          | Empty      | Optional         | **Required** | Not allowed  |
| `DENSE_RANK()    | Empty      | Optional         | **Required** | Not allowed  |
| `CUME_DIST()     | Empty      | Optional         | **Required** | Not allowed  |
| `PERCENT_RANK()  | Empty      | Optional         | **Required** | Not allowed  |
| `NTILE(n)        | Number     | Optional         | **Required** | Not allowed  |*/


--a.ROW_NUMBER() Over( ORDER BY Sales DESC)
  --Assign aunique number to each row
  --It doesn't handle ties
--RANK the order based on their sales from the highestto lowest
  SELECT
  OrderID,
  ProductID,Sales,
  ROW_NUMBER() Over(Order By Sales Desc) SalesRank_Row
  From  Sales.Orders


----b.Rank() Over( ORDER BY Sales DESC)
  --Assign a rank to each row
  --It  handle ties
  --It leaves gap in ranking
--RANK the order based on their sales from the highestto lowest
  SELECT
  OrderID,
  ProductID,Sales,
  Rank() Over(Order By Sales Desc) SalesRank_Row
  From  Sales.Orders


----c.Rank() Over( ORDER BY Sales DESC)
  --Assign a rank to each row
  --It  handle ties
  --It  doesnot leave gap in ranking
--RANK the order based on their sales from the highestto lowest
  SELECT
  OrderID,
  ProductID,Sales,
  DENSE_Rank() Over(Order By Sales Desc) SalesRank_Row
  From  Sales.Orders


----d.Rank() Over( ORDER BY Sales DESC)
  --Assign a rank to each row
  --It  handle ties
  --It leaves gap in ranking
--RANK the order based on their sales from the highestto lowest
  SELECT
  OrderID,
  ProductID,Sales,
  Rank() Over(Order By Sales Desc) SalesRank_Row
  From  Sales.Orders

--TOP-N ANALYSIS
--fIND THE TOP HIGHEST SALES FOR EACH PRODUCT

  SELECT *
  FROM(
  SELECT
  OrderID,
  ProductID,Sales,
  ROW_NUMBER() Over(PARTITION BY ProductID Order By Sales Desc) RankByOder
  From  Sales.Orders)t
  WHERE RankByOder=1

  

  --BOTTOM N ANALYSIS
  --Find the lowest 2 customers based on their total sales

  SELECT *
  FROM(
  SELECT
  CustomerID,
  SUM(Sales) TotalSales,
  ROW_NUMBER() Over( Order By SUM(Sales) ) RankCustomers
  From  Sales.Orders
  GROUP BY CustomerID)t
  WHERE RankCustomers<=2


--Assign unique Ids to the rows of 'Orders Archive' table
SELECT
ROW_NUMBER() Over( Order By OrderID,OrderDate ) UniqueID,
*
FROM Sales.OrdersArchive

--Paginationg:Process of breaking down a large data into smaller,more managable chunks


--Identify duplicate rows in the table 'Orders Archive' and return a clean result without any duplicates

SELECT * FROM
(SELECT
ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY CreationTime DESC)rn,
*
FROM Sales.OrdersArchive)t WHERE rn=1

--NTILE(n)
--Divide the rows into a specified number of approximately equal groups(Buckets)
--Bucket Size=(number of Rows/Number of Buckets) 
    --Number of buckets=n
--Larger group come first

SELECT OrderID,Sales,
NTILE(1) OVER (ORDER BY Sales DESC) OneBuckets,
NTILE(2) OVER (ORDER BY Sales DESC) TwoBuckets,
NTILE(3) OVER (ORDER BY Sales DESC) ThreeBuckets
FROM Sales.Orders


--USE CASES
  --1.Data Segmentation
  --SEGMENT all orders into 3 categories high,medium and low sales
  SELECT
  *,
  CASE WHEN Buckets =1 THEN 'HIGH '
       WHEN Buckets =2 THEN 'MEDIUM '
	   WHEN Buckets =3 THEN 'LOW '
  END SALESSEGMENTATIONS
  FROM(SELECT OrderID,Sales,
  NTILE(3) OVER (ORDER BY Sales DESC) Buckets
  FROM Sales.Orders)t

  --In order to export the data,divide the orders into 2 groups
  SELECT
    NTILE(2) OVER (ORDER BY OrderID) Buckets,*
  FROM Sales.Orders



  --PERCENTAGE BASED RANKING

 --# A.CUME_DIST
   --(position Nr/Number of Rows)
   --CUMULATIVE DISTRIBUTION CALCULATES THE DISTRIBUTION OF THE DATA POINTS WITHIN A WINDOW
   --CUME_DIST() OVER(ORDER BY Sales DESC)
   --Tie Rule:The position of the last occurance of the same value
--# B. PERCENT_RANK
   --(position Nr-1/Number of Rows-1)
   --Calculates the relative position of each row
   --PERCENT_RANK() OVER(ORDER BY Sales DESC)
   --tie Rule:The position of the first occurance of the same value



   --VALUE WINDOW FUNCTION
   /*
 +-------------------------------+--------------------+-----------------------+------------------+------------------------------------------+
| Function                      | Expression         | Partition Clause      | Order Clause     | Frame Clause                             |
+-------------------------------+--------------------+-----------------------+------------------+------------------------------------------+
| LEAD(expr, offset, default)   | All Data Types     | Optional              | Required         | Not allowed                              |
| LAG(expr, offset, default)    | All Data Types     | Optional              | Required         | Not allowed                              |
| FIRST_VALUE(expr)             | All Data Types     | Optional              | Required         | Optional, Should be used                 |
| LAST_VALUE(expr)              | All Data Types     | Optional              | Required         | Optional, Should be used                 |
+-------------------------------+--------------------+-----------------------+------------------+------------------------------------------+*/
--LEAD():access a value from the next row within awindow

   --LEAD(Sales,2,10) OVER(PARTITION BY ProductID ORDER BY OrderDate)
   --10 is default value
   --find sales of the next mmonth
--LAG():Access a value from the previous roe within a window
    --Find the sales of the previous month

--TIME SERIES ANALYSIS:the process of analyzing the data to understand
    --Year-over-Year(YoY)
	  --Analyze overall growth or decline of the business's performance over the time
	--Month-over-Month(MoM)
	  --Analyze short term trends and discover patterns in seasonality

--Analyze the month-over month performance by finding the percentage change 
--in sales between the current and previous months
SELECT
*,
CurrentMonthSales-PreviousMonthSales AS MoM_Change,
ROUND(CAST((CurrentMonthSales-PreviousMonthSales )AS FLOAT)/PreviousMonthSales *100,1) AS MoM_Perc
FROM(
SELECT 
MONTH(OrderDate) OrderMonth,
SUM(Sales) CurrentMonthSales,
LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY MONTH(OrderDate))t




--Customer Retention Analysis
  --Measrure customers behaviour and loyality to help businesse build strong relationships with customers4
  --Analyze customer loyalty by ranking  of days between orders
  SELECT
  CustomerID,
  AVG(DaysUntilNextOrder)AvgDays,
  RANK() OVER(ORDER BY AVG(DaysUntilNextOrder))RankAvg
  FROM(
  SELECT
  OrderID,CustomerID,OrderDate CurrentOrder,
 LEAD(OrderDate) OVER (Partition BY CustomerID ORDER BY OrderDate) NextOrder,
 DATEDIFF(day,OrderDate,LEAD(OrderDate) OVER (Partition BY CustomerID ORDER BY OrderDate))DaysUntilNextOrder
 FROM Sales.Orders)t
 Group BY 
 CustomerID

 --First Value()
   --Access a value from the first row within a window
   --Frist_Value(Sales) OVER (ORDER BY Month)
 --Last value()
   --Access a value from the last row within a window
   --LAST_VALUE(Sales) OVER (ORDER BY Month)
--Default is RANGEBETWEEN UNBOUNDED PRECEDING AND CURRENT ROW


--Find the lowest and highest sales for each product
SELECT
OrderID,
ProductId,
Sales,
FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales)LowestSales,
LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales DESC) HighestSales2,
MIN(Sales) OVER (PARTITION BY ProductID)LowestSales2,
MAX(Sales) OVER (PARTITION BY ProductID)HighestSales3,
Sales-FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) AS SalesDifference
FROM Sales.Orders
