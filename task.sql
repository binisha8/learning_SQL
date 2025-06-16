--How to retrive the second highest salary of the employee
SELECT MAX(Salary)
FROM Sales.Employees
WHERE Salary < (SELECT MAX(Salary) FROM Sales.Employees)

--How to get the nth highest salary
SELECT Salary
FROM (SELECT Salary,DENSE_RANK() OVER (ORDER BY Salary DESC) AS rank
FROM Sales.Employees) AS ranked_salaries
WHERE rank=4;



--fetch all employees whose salary is greater than average salary
SELECT *
FROM Sales.Employees
WHERE Salary >(SELECT AVG(Salary) FROM Sales.Employees)

--query to display urrent date and time
SELECT CURRENT_TIMESTAMP;

--How to find the duplicates records in a table
SELECT EmployeeID,COUNT(*)
FROM Sales.Employees
GROUP BY EmployeeID
HAVING COUNT(*)>1;

--How to get the common records from the tables
SELECT * 
FROM Sales.Employees
SELECT * 
FROM Sales.Orders
INTERSECT
SELECT *
FROM Sales.OrdersArchive


--How to retrive the last 5 records from a table
SELECT TOP 5 *
FROM Sales.Employees
ORDER BY EmployeeID DESC


--How to calculate the total Salary of  all employes
SELECT SUM(Salary)
FROM Sales.Employees


--WRITE A QUERY TO FIND ALL EMPLOYEES WHOSE BIRTHDATE IS  IN THE YEAR 2020?
SELECT *
FROM Sales.Employees
WHERE YEAR(BirthDate)=2020


--WRITE A QUERY  TO FIND EMPLOYEES WHOSE NAME STARTS WITH 'A'
SELECT * 
FROM Sales.Employees
WHERE FirstName LIKE 'A%'






