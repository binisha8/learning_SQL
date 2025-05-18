--View:Is a virtual table that shows data without storing it physically


/*
DDL:DATA DEFINATION LANGUAGE
  -Create
  -Alter
  -Drop


  --VIEW SYNTAX:
  CREATE VIEW VIEW-NAME AS  (DDL QUERY)
  (
  SELECT...(QUERY)
  FROM...
  WHERE...
  )*/
  --FIND THE RUNNING TOTAL OF SALES FOR EACH MONTH

  WITH CTE_mONTHLY_SUMMARY AS(
  SELECT 
  DATETRUNC(month,OrderDate)OrderMonth,
  SUM(Sales) TotalSales,
  COUNT(OrderID) TotalOrders,
  SUM(Quantity) TotalQuantities
  FROM Sales.Orders
  GROUP BY DATETRUNC(month,OrderDate) 
  )
  SELECT
  OrderMonth,
  SUM(TotalSales) OVER (ORDER BY OrderMonth)AS RunningTotal
  FROM CTE_mONTHLY_SUMMARY


  SELECT 
   *
  FROM V_monthly_Summary



  --View will make the query shorter
  SELECT
  OrderMonth,
  TotalSales,
  SUM(TotalSales) OVER (ORDER BY OrderMonth)AS RunningTotal
  FROM  V_monthly_Summary

  --Provide a view that combines detail from orders,products,customers andd employees
 SELECT
 *
 FROM Sales.V_Order_Details


 --Provide a view for the EU Sales team
 --that combines details from all tables 
 --and excludes data related to the USA

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
  ON e.EmployeeID = o.SalesPersonID
  WHERE Country <> 'USA';



  SELECT
  *
  FROM  Sales.V_Order_details_EU

  