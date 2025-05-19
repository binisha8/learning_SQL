--PROCEDURE syntax

/*
CREATE PROCEDURE ProcedureName AS
BEGIN

--SQL STTATEMENTS GO HERE

END


exec pROCEDUREnAME --STORED PROCEDURE EXECUTION

*/
--  STEP 1. Write a query 
--For US Customers find the total nu,ber of customers and the average score

SELECT
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country='USA'

--STEP 2.Turning the Query into a stored Procedure
CREATE PROCEDURE GetCustomerSummary AS
BEGIN
SELECT
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country='USA'
END

--STEP3 : Execute the stored Procedure
EXEC GetCustomerSummary--with this we dont have to write query again and again we can simply run EXEC.... when ever we require




--Stored Procedure parameters
  --Placeholders used to pass values as input from the caller to the procedure,allowing dynamic data to be processed

  --For German Customers finf the total number of Customers and the Average SCore

WHERE Country='Germany'
ENDCREATE PROCEDURE GetCustomerSummaryGermany AS
BEGIN
SELECT
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM Sales.Customers

EXEC  GetCustomerSummaryGermany

--Defining the parameter
CREATE PROCEDURE GetCustomerSummaryy @Country NVARCHAR(50)='USA'--As a default value
AS
BEGIN
SELECT
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country=@Country
END

EXEC  GetCustomerSummaryy @Country='UK'
EXEC  GetCustomerSummaryy @Country='USA'

--IF we want to drop the procedure then
--DROP  PROCEDURE  GetCustomerSummaryy

--Multiple Statements
--Find the total number of Orders and totall number of sales
--Defining the parameter
CREATE PROCEDURE GetCustomer @Country NVARCHAR(50)='USA'--As a default value
AS
BEGIN
SELECT
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country=@Country;

Find the total number of Orders and totall number of sales
SELECT
COUNT(OrderID) TotalOrders,
SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID=o.CustomerID
WHERE c.Country=@Country;
END

EXEC GetCustomer
EXEC GetCustomer @Country ='Germany'


--Stored Procedure 
  --Varibles:Variables temporarily store and manipulate data during its execution

  --Total Customers from Germany:2
  --Average Score from Germany:425

ALTER PROCEDURE GetCustomer @Country NVARCHAR(50)='USA'--As a default value
AS
BEGIN

DECLARE @TotalCustomers INT,@AvgScore FLOAT;
--Preparre and Cleanup data

IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country=@Country)
BEGIN
  PRINT('Updating NULL Scores to 0');
  UPDATE Sales.Customers
  SET Score = 0
  WHERE Score IS NULL AND Country=@Country;
END

ELSE
BEGIN
    PRINT ('No NULL Scores found')
END;

--Genereting Reports
SELECT
@TotalCustomers= COUNT(*),
@AvgScore=AVG(Score)
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total customers from ' + @Country +':' + CAST( @TotalCustomers AS NVARCHAR);
PRINT 'AVERAGE sCORE FROM ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

--Find the total number of Orders and totall number of sales
SELECT
   COUNT(OrderID) TotalOrders,
   SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID=o.CustomerID
WHERE c.Country= @Country;
END
GO

EXEC  GetCustomer;
EXEC  GetCustomer @Country='Germany'





--Error Handling

/*
BEGIN TRY
--SQL statements that might cause an error
END TRY

BEGIN CATCH
--SQL statements to handle the error
END CATCH
*/

ALTER PROCEDURE GetCustomer @Country NVARCHAR(50)='USA'--As a default value
AS
BEGIN
	BEGIN TRY

	  DECLARE @TotalCustomers INT,@AvgScore FLOAT;

	  --===========================================
	  --STEP1:Prepare and Cleanup data
	  --===========================================

	  IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country=@Country)
	  BEGIN
	      PRINT('Updating NULL Scores to 0');
	      UPDATE Sales.Customers
	      SET Score = 0
	      WHERE Score IS NULL AND Country=@Country;
	  END

	  ELSE
	  BEGIN
		PRINT ('No NULL Scores found')
	  END;

	  --======================================
	  -- STEP 2:Genereting Reports
	  --======================================
	  --Calculate total Customers and Average Score for specific Country

	  SELECT
	     @TotalCustomers= COUNT(*),
	     @AvgScore=AVG(Score)
	  FROM Sales.Customers
	  WHERE Country = @Country;

	  PRINT 'Total customers from ' + @Country +':' + CAST( @TotalCustomers AS NVARCHAR);
	  PRINT 'AVERAGE sCORE FROM ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

	  --Find the total number of Orders and totall number of sales
	  SELECT
	     COUNT(OrderID) TotalOrders,
	     SUM(Sales) TotalSales,
	     
	  FROM Sales.Orders o
	  JOIN Sales.Customers c
	  ON c.CustomerID=o.CustomerID
	  WHERE c.Country= @Country;
	END TRY
	BEGIN CATCH

	--===========================
	--ERROR HANDLING
	--===========================

	  PRINT ('An error occured.');
	  PRINT('Error Message:' + ERROR_MESSAGE());
	  PRINT('ERROR Number: '+ CAST(ERROR_NUMBER() AS NVARCHAR));
	  PRINT('ERROR LINE:' +  CAST(ERROR_LINE() AS NVARCHAR));
	  PRINT('ERROR PROCEDURE ' + ERROR_PROCEDURE());
	 END CATCH
	END 
	GO

EXEC  GetCustomer;
EXEC  GetCustomer @Country='Germany';