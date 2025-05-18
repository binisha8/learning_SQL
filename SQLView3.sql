CREATE VIEW Sales.V_Order_details_EU AS(
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
  WHERE Country <> 'USA')
