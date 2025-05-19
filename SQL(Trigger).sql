--TRIGGER Syntax
/*
CREATE TRIGGER TriggerName ON TableName
WHEN ->AFTER INSERT,UPDATE,DELETE
   BEGIN
WHAT->--SQL Statements GO HERE
   END


STEP 1:Create Log Table */
CREATE TABLE Sales.EmployeesLogs(
   LogID INT IDENTITY(1,1) PRIMARY KEY,
   EmployeeID INT,
   LogMessage VARCHAR(255),
   LogDate DATE
   )

--STEP 2:Create Trigger on Employee Table
CREATE TRIGGER trg_AfterInsertemployees ON Sales.Employees
AFTER INSERT
AS 
BEGIN
   INSERT INTO Sales.EmployeesLogs(EmployeeID,LogMessage,LogDate)
   SELECT
    EmployeeId,
	'New employee Added='+ CAST(EmployeeID AS VARCHAR),
	GETDATE()
   FROM INSERTED
END

--STEP 3:Insert new data into employees
SELECT * FROM Sales.EmployeesLogs
INSERT INTO Sales.Employees
Values(6,'Maria','Doe','HR','1988-01-12','F',80000,3)
INSERT INTO Sales.Employees
Values(7,'Marie','Loe','CR','2001-01-01','F',8000,8)




  