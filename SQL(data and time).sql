SELECT 
OrderID,
CreationTime,
'2025-08-20' HardCodede,
GETDATE() Today--Returns the current dates and time at the moment when the query is executed
From Sales.Orders

--Date and Time Function
--Part Extarction
--1. Day()-returns the day from a date
--2. Month()-returns the month from a date
--3. Year()-retirns the year from a date
-- Syntax 1.Day(date) 2. Month(date) 3.Year(date)

SELECT OrderID,CreationTime,
YEAR(CreationTime) Year,
MONTH (CreationTime) MONTH,
DAY (CreationTime) Day
FROM Sales.Orders


--DATEPART()
--Syntax
--DATEPART(part,date)


SELECT
OrderID,
CreationTime,
DATEPART(year,CreationTime) Year_DP,
DATEPART(month,CreationTime) MONTH_DP,
DATEPART(day,CreationTime) Day_DP,
DATEPART(hour,CreationTime) hour_DP,
DATEPART(minute,CreationTime) minute_DP,
DATEPART(second,CreationTime) second_DP,
DATEPART(QUARTER,CreationTime) QUARTER_DP,
DATEPART(week,CreationTime) WEEK_DP
FROM Sales.Orders


--DATENAME()
--Returns the name of a specific part of date
--DATENAME(part,date)

SELECT
OrderID,
CreationTime,
DATENAME(month,CreationTime) Month_dn,
DATENAME(WEEKDAY,CreationTime) weekday_dn,
DATENAME(day,CreationTime) day_dn,
--DATEPART 
DATEPART(year,CreationTime) Year_DP,
DATEPART(month,CreationTime) MONTH_DP,
DATEPART(day,CreationTime) Day_DP,
DATEPART(hour,CreationTime) hour_DP,
DATEPART(minute,CreationTime) minute_DP,
DATEPART(second,CreationTime) second_DP,
DATEPART(QUARTER,CreationTime) QUARTER_DP,
DATEPART(week,CreationTime) WEEK_DP
FROM Sales.Orders

--DATETRUNC()-Truncates the date ti o the specific part
--DATETRUNC(part,date)
SELECT
OrderID,
CreationTime,
--DATETRUNC
DATETRUNC(minute,CreationTime)Minute_dt,
DATETRUNC(YEAR,CreationTime)YEAR_dt,
DATETRUNC(day,CreationTime)Day_dt,
--DATENAME
DATENAME(month,CreationTime) Month_dn,
DATENAME(WEEKDAY,CreationTime) weekday_dn,
DATENAME(day,CreationTime) day_dn,
--DATEPART 
DATEPART(year,CreationTime) Year_DP,
DATEPART(month,CreationTime) MONTH_DP,
DATEPART(day,CreationTime) Day_DP,
DATEPART(hour,CreationTime) hour_DP,
DATEPART(minute,CreationTime) minute_DP,
DATEPART(second,CreationTime) second_DP,
DATEPART(QUARTER,CreationTime) QUARTER_DP,
DATEPART(week,CreationTime) WEEK_DP
FROM Sales.Orders


--EOMONTH()-Returns the last day of a month
--SYNTAX-EOMONTH(date)
SELECT 
OrderID,
CreationTime,
EOMONTH(CreationTime) EndOfMonth,
--Start of month
DATETRUNC(month,CreationTime) StartOfMonth,
--if we want only dates then
CAST(datetrunc(month,CreationTime)AS DATE)StartOfMonth
FROM Sales.Orders


--Part Extraction Use Case(Data Aggregations)
-- How many orders were placed each yesr?
SELECT 
OrderDate,
COUNT(*) NoofOrders
FROM Sales.Orders
GROUP BY OrderDate

--OR
SELECT 
Year(OrderDate),
COUNT(*) NoofOrders
FROM Sales.Orders
GROUP BY Year(OrderDate)


--How many orders were placed each month
SELECT 
DATENAME(MONTH,OrderDate)AS Orderdate,
COUNT(*) NoofOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)


--Show all orders tht were placed during the month of feb
SELECT * 
FROM Sales.Orders
WHERE MONTH(OrderDate)=2
--Filtering data using an int is faster than using a string
--Avoid using DATENAME for filtering data,instead use DATEPART


--FUNCTIONS COMPARISONS

/*DATATYPES
DAY MONTH YEAR DATAPART -> INT
DATENAME -> STRING
DATETRUNC -> DATETIME
EOMONTH -> DATE*/

--CASTING - Changing the data type from one to another
--In order to change the datatype we use CAST(),CONVERT().
--FORMAT() SYNTAX-FORMAT(value,format[,culture])
--FORMAT(OrderDate , 'dd/MM/yyy')
--FORMAT(OrderDatte,'dd/MM/yyy','ja-JP')
--FORMAT(1234.56,'D','fr-FR')

SELECT 
OrderID,
CreationTime,
FORMAT(CreationTime,'MM-dd-yyyy') USA_Format,
FORMAT(CreationTime,'dd-MM-yyyy')EURO_format,
FORMAT(CreationTime,'dd')dd,
FORMAT(CreationTime,'ddd')ddd,
FORMAT(CreationTime,'dddd')dddd,
FORMAT(CreationTime,'MM') MM,
FORMAT(CreationTime,'MMM') MMM,
FORMAT(CreationTime,'MMMM') MMMM
FROM Sales.Orders

/*Show Creation time using the following format:
Day Wed Jan Q1 2025 12:34:56 PM*/

SELECT
OrderID,
CreationTime,
'Day '+ FORMAT(CreationTime,'ddd MMM') + ' Q'+ DATENAME(quarter,CreationTime)
+' '+ FORMAT(Creationtime,'yyy hh:mm:ss tt') CustomeFormat
FROM Sales.Orders

--Formatting use case(Data aggregation)
SELECT
FORMAT(OrderDate,'MMM yy') OrderDate,
count(*)
From Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy')

--Convert()-Converts a date or time value to a different data type and formats the vallue
--syntax=Convert(data_type,value[,style]) default style=0
--Examples:COVNERT(INT,'124') Converts to int
--Convert(VARCHAR ,OrderDate ,'34')
Select 
Convert(Int,'123') AS [String to int],
Convert(Date,'2025-04-6') AS [string to date],
CreationTime,
Convert(Date,CreationTime) AS[Datetime to date],
Convert(Varchar,CreationTime,32)AS [USA Std.Style:32],
Convert(Varchar,CreationTime,34)AS [EURO Std.Style:32]
FROM Sales.Orders


--CAST() = Converts a value to a specified data type
--SYNTAX = CAST(value AS data_type)
--Examples = CAST('123' As INT)
--CAST('2025-08-20' AS DATE)
--No format can be specified


SELECT
CAST('123' AS INT) AS [String to int],
CAST(123 AS VARCHAR) AS [INT to String],
CAST('2025-08-20' AS DATE) AS [String to Date],
CAST('2025-08-20' AS DATETIME2) AS [String to DateTIME],
CreationTime,
CAST(CreationTime AS DATE) As [Datetime to Date]
FROM SAles.Orders

 
 --FORMAT Vs CAST Vs Convert

 --Date Calculations
 --DATEADD()-Adds or subtracts a specific time interval to/from a date
 --DATEADD(part,interval,date) -> DATEADD(year,2,OrderDate)


 SELECT 
 OrderID,OrderDate,
 DATEADD(month,3,OrderDate) AS ThreeMonthsLater,
 DATEADD(year,2,OrderDate) AS TwoYearsLater,
 DATEADD(day,3,OrderDate) AS ThreedaysLater,
 DATEADD(day,-10,OrderDate) AS tendaysbefore
 FROM Sales.Orders

--SYNTAX -> DATEDIFF(part,start_date,end_date)
--DATEDIFF(year,OrderDate,ShipDate)
--DATEDIFF(day,OrderDate,ShipDate)

--calculate the age of employees
SELECT *
FROM Sales.Employees

SELECT BirthDate,
DATEDIFF(year,BirthDate,GETDATE())
FROM Sales.Employees

--Find the average shipping duration in days for each month

SELECT 
MONTH(OrderDate) AS OrderDate,
AVG(DATEDIFF(day,OrderDate,ShipDate))AvgShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

--Find the number of days between each order and previous order
SELECT 
OrderID,
OrderDate AS CurrentOrderdate,
LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate,
DATEDIFF(day,LAG(OrderDate) OVER (ORDER BY OrderDate),OrderDate) AS daysbetnpreviousandpresent
FROM Sales.Orders


--ISDATE() - Check if a value is a date.Returns 1 if the string is a valid date
--ISDATE(value)
--ISDATE('2025-08-20')
--ISDATE(2025)

SELECT 
ISDATE('123') Datecheck1,
ISDATE('2025-08-20') Datecheck2,
ISDATE('20-08-2025') Datecheck3,--only if it is following(yyyy-mm-dd) then only gives 1
ISDate('2025') Datacheck4,
ISDATE('08') Datecheck5


SELECT 
OrderDate,
ISDATE(OrderDate),
CASE 
    WHEN ISDATE(OrderDate)=1
	THEN CAST(OrderDate AS DATE)
END NewOrderDate
FROM
(
SELECT '2025-08-20' AS OrderDate Union
SELECT '2025-08-21' Union
SELECT '2025-08-23' Union
SELECT '2025-08'
)t







