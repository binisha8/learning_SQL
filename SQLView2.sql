/*
CREATE VIEW V_monthly_Summary AS
(
SELECT 
  DATETRUNC(month,OrderDate)OrderMonth,
  SUM(Sales) TotalSales,
  COUNT(OrderID) TotalOrders,
  SUM(Quantity) TotalQuantities
  FROM Sales.Orders
  GROUP BY DATETRUNC(month,OrderDate) 
  )*/
 
  /*
  CREATE VIEW Sales.V_monthly_Summary AS      --can make the view at the correct schema
(
SELECT 
  DATETRUNC(month,OrderDate)OrderMonth,
  SUM(Sales) TotalSales,
  COUNT(OrderID) TotalOrders,
  SUM(Quantity) TotalQuantities
  FROM Sales.Orders
  GROUP BY DATETRUNC(month,OrderDate) 
  );*/


  --To DELETE the view we use Drop
 -- DROP VIEW Sales.Sales.V_monthly_Summary 



  CREATE VIEW Sales.V_Order_Details AS
SELECT
  o.OrderID,
  o.OrderDate,
  p.Product,
  p.Category,
  COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') AS CustomerName,
  c.Country AS CustomerCountry,
  COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') AS SalesName,
  o.Sales,
  o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales.Products p
  ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
  ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
  ON e.EmployeeID = o.SalesPersonID;
