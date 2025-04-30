/* howto choose between join types?*/
/*only matching->INNER JOIN
  all rows-> 1. One side ->Lef join

             2. Both sides ->Full join

  only unmatching -> 1. one side ->left anti join


--Multi-Table join
--Advanced join types*/

USE salesDB


Select 
o.OrderID,
o.Sales
from sales.Orders AS o;






select * from Sales.Customers;


select * from Sales.Employees;


select * from Sales.OrdersArchive;


select * from Sales.Orders;


select * from Sales.OrdersArchive;




/*Using SalesDB,Retrive a list of all orders,along with the related customer,product 
and employee details*/

Select 
o.OrderID,
o.Sales,
c.FirstName AS customerFirstName,
c.LastName CustoettLastName,
s.Product AS ProductName,
s.price,
e.FirstName AS employeeFirstName,
e.LastName AS employeeLastName
FROM Sales.Orders AS o
Left Join Sales.Customers AS c
ON o.CustomerID=c.CustomerID
left join Sales.Products As s
ON o.ProductID=s.ProductID
left join Sales.Employees as e
ON o.SalesPersonID=e.EmployeeID



