--Finding the second highest salary of an employee
SELECT MAX(Salary) 
FROM Sales.Employees
WHERE Salary<(SELECT MAX(Salary) FROM Sales.Employees)

SELECT * FROM Sales.Employees

--Department wise highest salary
SELECT Department,MAX(Salary)
FROM Sales.Employees
GROUP BY  Department


--Display alternate Records

SELECT * 
FROM(
	SELECT *,ROW_NUMBER() OVER (ORDER BY EmployeeID) AS rn
	FROM Sales.Employees
	)AS numbered
WHERE rn % 2=1;


--Find the duplicate values and its frequency of a column
SELECT FirstName, COUNT(*) AS Frequency
FROM Sales.Employees
GROUP BY FirstName
HAVING COUNT(*)>1

--OR

SELECT FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID, COUNT(*) AS Frequency
FROM Sales.Employees
GROUP BY FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID
HAVING COUNT(*) > 1;


--Find the third highest salary fron the employees table
DECLARE @N INT =2;
SELECT Salary
FROM(
SELECT Salary,DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rank
FROM Sales.Employees
)AS ranked
WHERE Rank=@N;

--Query to calculate the even records from a table
SELECT *
FROM (
	SELECT *,ROW_NUMBER() OVER (ORDER BY EmployeeID) AS rn
FROM Sales.Employees
) AS ranked
WHERE rn %2 <> 1

--WRite the Query to display the first and last record from the table
SELECT*
FROM Sales.Employees
WHERE EmployeeID IN 
	(SELECT MIN(EmployeeID) FROM Sales.Employees
    UNION
    SELECT MAX(EmployeeID) FROM Sales.Employees);

--how do you copy all rows of a table using SQL Query

SELECT *
INTO Employees_Copy
FROM Sales.Employees;


--Write a Query to retrive the list of employees working in the same department
SELECT *,
RANK() OVER(PARTITION BY Department ORDER BY EmployeeID ) AS listofEmployees
FROM Sales.Employees

SELECT *
FROM Sales.Employees
ORDER BY Department, EmployeeID;

--Write a query to retrive the last 3 records from the Employees table
SELECT *
FROM(
SELECT *,
RANK() OVER(ORDER BY EmployeeID DESC) rn
FROM Sales.Employees)t
WHERE rn <=3


SELECT * FROM Sales.Employees


--Write a query to fetch  details of employees whose enpname ends with an alphabet 'A' and contains 5 alphabets
SELECT *
FROM Sales.Employees
WHERE LEN(FirstName)=4
AND FirstName LIKE '%y'


SELECT *
FROM Sales.Employees
WHERE FirstName LIKE '___y'

--Write a query to delete the duplicate record from employee_info
SELECT EmployeeID, COUNT(*)
FROM Sales.Employees
GROUP BY EmployeeID
HAVING COUNT(*)>1


--Write a query to retrive the first four  characters of Employee name from the employee table
SELECT SUBSTRING(FirstName,1,4)
FROM Sales.Employees



SELECT COUNT(*),GENDER
FROM Sales.Employees
WHERE YEAR(BirthDate)
BETWEEN '1980' AND '1988'
GROUP BY  Gender


--Write a query to fetch 50% records from the employee_info table
SELECT TOP (SELECT COUNT(*)/2 FROM Sales.Employees)
*
FROM Sales.Employees

SELECT *
FROM Sales.Employees
WHERE EmployeeID<=(SELECT COUNT(EmployeeID)/2 FROM Sales.Employees)


--Write a query to display the totral salary of each empoyee after adding 10% increment in the salary
SELECT EmployeeID,FirstName,LastName,Salary+(Salary*0.1) AS 'Total Salary'
FROM Sales.Employees

--Write a query to retrive 2 minimun and maximum salaries
SELECT TOP(2) *
FROM(SELECT *,
MAX(Salary) OVER(ORDER BY Salary DESC) MAXIMUMSalary 
FROM Sales.Employees)  t


--Write a query to retrive 2 minimun and maximum salaries
SELECT TOP(2) *
FROM(SELECT *,
MIN(Salary) OVER(ORDER BY Salary asc) MinimumSalary 
FROM Sales.Employees)t


--Write a query to fetch the employee name and replace the space with'-'
SELECT 
  REPLACE(FirstName + ' ' + LastName, ' ', '-') AS FullNameWithHyphen
FROM Sales.Employees;


--highest and lowest salary
SELECT *,
MAX(Salary) OVER( PARTITION BY Department ORDER BY Salary DESC)Highest,
MIN(Salary) OVER(PARTITION BY Department ORDER BY Salary) Lowest
FROM Sales.Employees


SELECT * FROM Sales.Products 
INSERT into Sales.Products (ProductID,Product,Category,Price) VALUES(101,'Bottle','Accessories',10);


--deleting duplicates
DELETE FROM Sales.Products
WHERE productID IN (SELECT ProductID 
						FROM (SELECT *,
						ROW_NUMBER() OVER(PARTITION BY Product,Category ORDER BY ProductID DESC) rn
						FROM Sales.Products)t
WHERE t.rn>1);



--Create  the database 
CREATE DATABASE OnlineRetailDB;
GO


--Use the database
USE OnlineRetailDB;
GO

--Create Customer Table
CREATE TABLE Customers(
CustomerID INT PRIMARY KEY IDENTITY(1,1),
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
Email NVARCHAR(100),
Phone NVARCHAR(50),
Address NVARCHAR(255),
City NVARCHAR(50),
State NVARCHAR(50),
ZipCode NVARCHAR(50),
Coumtry NVARCHAR(50),
CreateDate DATETIME DEFAULT GETDATE()
);

-- Create the Products table
CREATE TABLE Products (
	ProductID INT PRIMARY KEY IDENTITY(1,1),
	ProductName NVARCHAR(100),
	CategoryID INT,
	Price DECIMAL(10,2),540
	Stock INT,
	CreatedAt DATETIME DEFAULT GETDATE()
);


--Create Category Table
CREATE TABLE Categories(

	CategoryID INT PRIMARY KEY IDENTITY(1,1),
	CategoryName NVARCHAR(100),
	Description NVARCHAR (255)
	
);


--Create Order table
CREATE TABLE Orders(
	OrderID INT PRIMARY KEY IDENTITY(1,1),
	CustomerID INT,
	OrderDate DATETIME DEFAULT GETDATE(),
	TotalAmount DECIMAL(10,2),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) 

);

-- Create the OrderItems Table
CREATE TABLE OrderItems(
	OrderItemID INT PRIMARY KEY IDENTITY(1,1),
	OrderID INT,
	ProductID INT,
	Quantity INT,
	Price DECIMAL(10,2),
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
	);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               


--If we want to Alter/Rename the Column Name 
EXEC sp_rename 'OnlineRetailDB.dbo.Customers.Coumtry', 'Country', 'COLUMN'; 

--Insert data into Categories Table
INSERT INTO Categories(CategoryName,Description)
VALUES
('Electronics','Devices and Gadets'),
('Clothing ','Apparel and Accessories'),
('Books','Printed and Electronics Books');

--Insert data into Products table
INSERT INTO Products(ProductName,CategoryID,Price,Stock)
VALUES
('Smartphone', 1, 699.99, 50),
('Laptop', 1, 999.99, 30),
('T-shirt', 2, 19.99, 100),
('Jeans', 2, 49.99, 60),
('Fiction Novel', 3, 14.99, 200),
('Science Journal', 3, 29.99, 150);

--Insert into Customers table
INSERT INTO Customers(FirstName,LastName,Email,Phone,Address,City,State,ZipCode,Country)
VALUES
	('Sameer', 'Khanna', 'sameer.khanna@example.com', '123-456-7890', '123 Elm St.', 'Springfield','IL', '62701', 'USA'),
	('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Oak St.', 'Madison','WI', '53703', 'USA'),
	('harshad', 'patel', 'harshad.patel@example.com', '345-678-9012', '789 Dalal St.', 'Mumbai', 'Maharashtra', '41520', 'INDIA');

--INSERT DATA INTO ORDER TABLE
INSERT INTO Orders( CustomerID,OrderDate,TotalAmount)
VALUES
    (1, GETDATE(), 719.98),
	(2, GETDATE(), 49.99),
	(3, GETDATE(), 44.98);


--Insert data into OrderItems
INSERT INTO OrderItems(OrderID,ProductID,Quantity,Price)
VALUES
	(1, 1, 1, 699.99),
	(1, 3, 1, 19.99),
	(2, 4, 1,  49.99),
	(3, 5, 1, 14.99),
	(3, 6, 1, 29.99);


--Retrive all orders for a specific Customers
SELECT o.OrderID,o.OrderDate,o.TotalAmount,oi.ProductID,p.ProductName,oi.Quantity,oi.Price
FROM Orders o
JOIN OrderItems oi ON o.OrderID=oi.OrderID
JOIN Products p ON oi.ProductID=p.ProductID
WHERE o.CustomerID=1;


--Find the total sales for each product
SELECT p.ProductID,p.ProductName,SUM(oi.Quantity * oi.Price) AS 'Total Sales'
FROM OrderItems oi
JOIN Products p
ON oi.ProductID=p.ProductID
GROUP BY p.ProductID,p.ProductName
ORDER BY 'Total Sales' DESC;


--Calculate the average order value
SELECT AVG(TotalAmount) AS AverageOrderValue FROM Orders;

--List the top 5 customers by total spending

SELECT CustomerID,FirstName,LastName,TotalSpent
FROM
(SELECT c.CustomerID,c.FirstName,c.LastName,SUM(o.TotalAmount) AS TotalSpent,
ROW_NUMBER() OVER (ORDER BY SUM(o.TotalAmount)DESC) AS rn
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,c.FirstName,c.LastName)sub 
WHERE rn <=5;


--Retrive  the most popular product category
SELECT CategoryID,CategoryName,TotalQuantitySold,rn
FROM(
SELECT c.CategoryID,c.CategoryName,SUM(oi.Quantity) AS TotalQuantitySold,
ROW_NUMBER() OVER (ORDER BY SUM(oi.Quantity) DESC) AS rn
FROM OrderItems oi
JOIN Products p
ON oi.ProductID=p.ProductID
JOIN Categories c
ON p.CategoryID=c.CategoryID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
GROUP BY c.CategoryID,c.CategoryName) sub
WHERE rn=1; 


--List all products that are out of stock,i.e stock-0
INSERT INTO Products(ProductName,CategoryID,Price,Stock)
VALUES ('Keyboard',1,699.99,0);

SELECT * FROM Products
WHERE Stock=0;

SELECT p.ProductID,p.ProductName,p.Stock 
FROM Products p
JOIN Categories c ON p.CategoryID=c.CategoryID
WHERE Stock=0

--Find the customers who placed orders in last 30 days
SELECT c.CustomerID,c.FirstName,c.LastName,c.Phone,c.Email ,o.OrderDate
FROM Customers c JOIN Orders o
ON c.CustomerID=o.CustomerID
WHERE o.OrderDate>=DATEADD(DAY,-30,GETDATE());

--Calculate the total number of orders placed each month
SELECT YEAR(OrderDate) AS OrderYear,
MONTH(OrderDate) AS OrderMonth,
COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY Year(OrderDate),MONTH(OrderDate);


--Retrive the details of the most recent order
SELECT TOP 1 o.OrderID,o.OrderDate,o.TotalAmount,c.FirstName,c.LastName
FROM Orders o JOIN Customers c
ON o.CustomerID=c.CustomerID
ORDER BY o.OrderDate DESC;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

--Find the average price of products in each cateory
SELECT c.CategoryID,c.CategoryName, AVG(p.Price) AS AveragePrice
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryID,c.CategoryName;

INSERT INTO Customers(FirstName,LastName,Email,Phone,Address,City,State,ZipCode,Country)
VALUES
	('Asim', 'Rana', 'asim.rana@example.com', '123-456-9999', '123 Elm St.', 'Springfield','IL', '62701', 'USA');


SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderItems;


--Deleting duplicate rows  5 and 6
DELETE FROM Customers
WHERE CustomerID IN (5, 6);

--Find customers who have never placed an order
SELECT c.CustomerID,c.FirstName,c.LastName,c.Email,c.Phone
FROM Customers c
LEFT JOIN Orders o 
ON c.CustomerID=o.CustomerID
WHERE o.OrderID IS NULL;


--Retrive  the total quantity sold for each product
SELECT p.ProductID,p.ProductName,SUM(o.Quantity) AS TotalQuantity
FROM OrderItems o
JOIN Products p ON p.ProductID=o.ProductID 
GROUP BY p.productID,p.ProductName
ORDER BY p.ProductName;

--Calculate the total revenue generated from each category
SELECT  c.CategoryID,c.CategoryName,SUM(oi.Quantity*oi.Price) AS TotalRevenue
FROM OrderItems oi JOIN Products p
ON oi.ProductID=p.ProductID
JOIN Categories c
ON c.CategoryID=p.CategoryID
GROUP BY c.CategoryID,c.CategoryName
ORDER BY TotalRevenue DESC


--Find the highest priced  product in each category
SELECT c.CategoryID,c.CategoryName,p1.ProductID,p1.ProductName,p1.Price
FROM Categories c 
JOIN Products p1 ON  c.CategoryID=p1.CategoryID
WHERE p1.Price =(SELECT MAX(Price) FROM Products p2 where p2.CategoryID=p1.CategoryID)
ORDER BY p1.Price DESC;

--Retrive orders with a total amount greater than a specific value (e.g. $500)
SELECT o.OrderID,c.CustomerID,c.FirstName,c.LastName,o.TotalAmount
FROM Orders o 
JOIN Customers c
ON o.CustomerID=c.CustomerID
WHERE o.TotalAmount>=500
ORDER BY o.TotalAmount DESC


--List products along with the number of order they appear in
SELECT p.ProductID,p.ProductName,COUNT(oi.OrderID) AS OrderCount
FROM Products p JOIN OrderItems oi
ON p.ProductID=oi.ProductID
GROUP BY p.ProductID,p.ProductName
ORDER BY OrderCount DESC;



--Find the top 3 most frequently ordered products
SELECT TOP 3 p.ProductID,p.ProductName,COUNT(oi.OrderID) AS OrderCount
FROM Products p JOIN OrderItems oi
ON p.ProductID=oi.ProductID
GROUP BY p.ProductID,p.ProductName;



--Calculate the total number of customers from each country
SELECT Country,COUNT(CustomerID) AS TotalCustomers
FROM Customers
GROUP BY Country


--Retrive the list of customers along with their total spending
SELECT c.CustomerID,c.FirstName,c.LastName,SUM(o.TotalAmount) AS TotalSpending
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY c.CustomerID,c.FirstName,c.LastName;


--List orders with more than a specified number of items(e.g. 5 items)
 SELECT o.OrderID,c.CustomerID,c.FirstName,c.LastName,COUNT(oi.OrderItemID) AS NumberofItems
 FROM Orders o 
 JOIN OrderItems oi
 ON o.OrderID=oi.OrderID
 JOIN Customers c
 ON o.CustomerID=c.CustomerID
 GROUP BY o.OrderID ,c.CustomerID,c.FirstName,c.LastName
 HAVING COUNT(oi.OrderItemID)>5
 ORDER BY NumberofItems;


--Find the total sales across all orders
--Additionally provide details such orderID,order Date

SELECT 
OrderID,
OrderDate,
SUM(Sales) OVER() TotalSales
FROM Sales.Orders

--Find the total sales across all orders
--Find the total sales for each product
--Find the total sales for each combination of product and order status
--Additionally provide details such orderID,order Date
SELECT 
OrderID,
OrderDate,
ProductID,
OrderStatus,
Sales,
SUM(Sales) OVER() TotalSales,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSales,
SUM(Sales) OVER(PARTITION BY ProductID,OrderStatus) SalesBYPRODUCTAndStatus
FROM Sales.Orders

--Rank each order based on their sales from highest to loweat, additionally provide details such orderid and order date

SELECT		
	OrderID,
	OrderDate,
	Sales,
RANK() OVER(ORDER BY SALES DESC) RankSales
FROM Sales.Orders

   
 SELECT
 OrderID,
 OrderDate,
 OrderStatus,Sales,
 SUM(sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate
 ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
 FROM Sales.Orders


 --Rank Customers based on their total sales
 SELECT 
	CustomerID,
	SUM(Sales) TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) AS RankCustomers
FROM Sales.Orders
GROUP BY CustomerID


--Find the total numbers of orders
SELECT 
COUNT(*) TotalOrders
FROM Sales.Orders


--Find the total number of Orders
--Additionally provide details such orderID,order date
SELECT
	OrderID,
	OrderDate,
	Count(*) OVER() TotalOrders 
	FROM Sales.Orders

--Find the total number of orders fpr each customers
SELECT
OrderID,
OrderDate,
CustomerID,
Count(*) OVER(PARTITION BY CustomerID) OrdersByCustomers
FROM Sales.Orders

--Find the total number of customers, additionally provide all customer's details


 SELECT *,
 COUNT (*) OVER () NoofCustomers
 FROM Sales.Customers

 --Find the total numbers of scores for the Customers
 SELECT *,
 COUNT(Score) OVER() TotalnumberofScores
 FROM Sales.Customers

--Rank the orders based on their sales from highest to the lowest
SELECT 
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row
FROM Sales.Orders


--using rank()function
SELECT 
OrderId,
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row,
RANK() OVER(ORDER BY Sales DESC) SalesRANK,
DENSE_RANK() OVER(ORDER BY Sales DESC) SalesDenseRank
FROM Sales.Orders


--Findthe top highest sales for each product
SELECT *
FROM(
SELECT
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
FROM Sales.Orders)t
WHERE RankByProduct=1

--Find the lowest 2 customers based on their total sales
SELECT *
FROM(
	SELECT
	CustomerID,
    SUM(Sales) TotalSales,
	ROW_NUMBER() OVER( ORDER BY SUM(Sales) ASC) RANKTOTALSALES
	FROM Sales.Orders
	GROUP BY CustomerID
	)t
	WHERE RANKTOTALSALES<=2


--Assign unique IDs to the rows of the 'Orders Archive' table
SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY OrderID,OrderDate ASC) AS UniqueID
FROM Sales.OrdersArchive


--Identify duplicates rows in the table 'Order Archive'and return a clean result without any duplicates


SELECT *
FROM(
	SELECT 
	ROW_NUMBER() OVER(PARTITION BY OrderId ORDER BY CreationTime DESC)rn,
	*
	FROM Sales.OrdersArchive
)t
WHERE rn = 1

SELECT
OrderID,
Sales,
NTILE(1) OVER (ORDER BY Sales DESC) OneBucket,
NTILE(2) OVER (ORDER BY Sales DESC) TwoBucket,
NTILE(3) OVER (ORDER BY Sales DESC) OneBucket
FROM Sales.Orders


--Segment all orders into 3 categories:high,medium,low sales
SELECT *,
CASE WHEN Buckets=1 THEN 'High'
	 WHEN Buckets=2 THEN 'Medium'
	 WHEN Buckets=3 THEN 'Low'
END Sales_Segmentations
FROM
(SELECT
OrderID,
Sales,
NTILE(3) OVER (ORDER BY SALES DESC) Buckets
FROM Sales.Orders)t

--In order to export the data , divide the ordersinto 2 groups
SELECT 
NTILE(2) OVER (ORDER BY OrderID) Buckets,
*
FROM Sales.Orders


--Find the product that fall within the highest 40% of the prices
SELECT
*,CONCAT(DistRank*100, '%') DistRankPerc
FROM(
SELECT 
Product,
Price,
CUME_DIST() OVER (ORDER BY Price DESC) DistRank
FROM Sales.Products                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
)t
WHERE DistRank<=0.4

--Analyze te month-over-month(MOM) performance by finding the percentage change in sales between the current and previous month
SELECT
*,
	 CurrentMontSales- PreviousMonthSales AS MOM_Change
FROM(
	SELECT
	MONTH(OrderDate) OrderMonth,
	SUM(Sales) CurrentMontSales,
	LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) PreviousMonthSales,
	LEAD(SUM(Sales)) OVER (ORDER BY Month(OrderDate)) NextMonthSales
	FROM Sales.Orders
	GROUP BY
		MONTH(OrderDate))t


--Analyze customer loyalty by ranking Customers basd on the average number of days between orders
SELECT
CustomerID,
AVG(DaysUntilNextOrder) AvgDays
FROM(
	SELECT
	OrderId,
	CustomerID,
	OrderDate CurrentDate,
	LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)NextOrder,
	DATEDIFF(day,OrderDate,LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate))DaysUntilNextOrder
	FROM Sales.Orders
	
)t
GROUP BY CustomerID


--Find the lowest and highest sales for each product
SELECT
OrderID,
ProductID,
Sales,
FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales)LowestSales,
LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales 
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC)HighestSales2,
MIN(Sales) OVER (PARTITION BY ProductID) LowestSales2,
MAX(Sales) OVER (PARTITION BY ProductID) HighedtSales3
FROM Sales.Orders

--Find the lowest and highest sales for each product
--Find the difference in sales between the current and lowest sales
SELECT
	OrderID,
	ProductId,
	Sales,
	FIRST_VALUE(Sales) OVER (PARTITION BY Productid ORDER BY Sales )LowestSales,
	LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales 
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
	Sales - FIRST_VALUE(Sales) OVER (PARTITION BY Productid ORDER BY Sales ) AS SalesDifference
FROM Sales.Orders                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   rders


---Indexing
SELECT *
INTO Sales.DBCustomers
FROM Sales.Customers


SELECT
*
FROM Sales.DBCustomers
WHERE CustomerID=1


CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID 
ON Sales.DBCustomers(CustomerID)


CREATE CLUSTERED INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers(FirstName)

DROP INDEX idx_DBCustomers_CustomerID  ON Sales.DBCustomers

SELECT  *
FROM Sales.DBCustomers
WHERE LastName='Brown'


SELECT
*
FROM Sales.DBCustomers
WHERE Country='USA'

CREATE INDEX idx_DBCustomers_CountryScore
ON Sales.DBCustomers (Country,Score)       

IF OBJECT_ID ('Sales.V_Monthly_Summary','V') IS NOT NULL
    DROP VIEW Sales.V_Monthly_Summary
GO

CREATE VIEW Sales.V_Monthly_Summary AS
(
SELECT 
DATETRUNC(month,OrderDate)OrderMonth,
SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY DATETRUNC(month,OrderDate)
)


--Finding the running total of sales for each month
WITH CTE_Monthly_Summary AS(
SELECT 
DATETRUNC(month,OrderDate)OrderMonth,
SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY DATETRUNC(month,OrderDate)
)
SELECT 
OrderMonth,   
SUM(TotalSales) OVER (ORDER BY OrderMonth) AS RunningTotal
FROM CTE_Monthly_Summary


--Find the TotalSales per customers(Standalone CTE)
WITH CTE_TotalSales AS
(
SELECT 
CustomerID,
SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)
--Find the last order date for each customers
, CTE_LastOrder AS
(SELECT
CustomerID,
MAX(OrderDate) LastOrder
FROM Sales.Orders
GROUP BY CustomerID
)
--MainQuery 
SELECT 
c.CustomerID,
c.Firstname,
c.Lastname,
t.TotalSales,
l.LastOrder
FROM Sales.Customers c
LEFT JOIN CTE_TotalSales t
ON c.CustomerID=t.CustomerID
LEFT JOIN CTE_LastOrder l 
ON c.CustomerID=l.CustomerID
ORDER BY CustomerID


--Find the toatl sales per customer
--Find the last order date per customer
--Rank customers based on total sales per customer
WITH CTE_TotalSales AS
(
SELECT 
CustomerID,
SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY CustomerID
)

--Find the last order date for each customers
, CTE_LastOrder AS
(SELECT
CustomerID,
MAX(OrderDate) LastOrder
FROM Sales.Orders
GROUP BY CustomerID
)
--Rank Customers nased on totalSales per Customer(NEsted CTE)
,CTE_CustomerRank AS
(
SELECT
CustomerID,
TotalSales,
RANK() OVER(ORDER BY TotalSales DESC)AS RankTotalSales
FROM CTE_TotalSales
)

--MainQuery 
SELECT 
c.CustomerID,
c.Firstname,
c.Lastname,
t.TotalSales,
l.LastOrder,
cr.RankTotalSales
FROM Sales.Customers c
LEFT JOIN CTE_TotalSales t
ON c.CustomerID=t.CustomerID
LEFT JOIN CTE_LastOrder l 
ON c.CustomerID=l.CustomerID
LEFT JOIN CTE_CustomerRank cr
ON c.CustomerID=cr.CustomerID
ORDER BY CustomerID




--GENERATE A Sequence of Numbers from 1 to 20

WITH Series AS
(
--Anchor Query
SELECT
1 AS MyNumber

UNION ALL
--Recursive Query
SELECT 
MyNumber+1 
FROM Series
WHERE MyNumber<20 

)
--MainQuery
SELECT *
FROM Series
OPTION(MAXRECURSION 5000)




















































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































              
