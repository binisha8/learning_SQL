/* SQL Functions*/
--concaT fUNCTION
--Show a list of customers first names together wit their country in one column
Select * from customers;

Select first_name,country,
CONCAT(first_name,'-',country) AS name_country
FROM customers


--UPPER AND LOWER FUNCTION
--CONVERT THE FIRST NAME TO LOWERCASE
Select 
first_name,
upper(first_name)AS upper_name,
lower(country) AS lower_country
from customers;

--TRIM FUNCTION(Removes Leading and trailing spaces)
--To detect unnecessary spaces
SELECT first_name,
LEN(first_name) len_name,
LEN(TRIM(first_name))len_trim_name,
LEN(first_name)-LEN(TRIM(first_name)) flag
FROM customers
WHERE first_name!=TRIM(first_name)


--REPLACE FUNCTION
--Remove dashes (-) from a phone number
SELECT
'123-456-7890' AS Phone,
REPLACE('123-456-7890','-','') AS REplace_fun


SELECT 'report.txt' AS old_filename,
REPLACE('report.txt','.txt','.csv') AS new_file_name


--LEN FUNCTION
SELECT 
first_name,
len(first_name) AS len_name
from customers;

--String Extraction
--left-Extracts specific number of characters from the stsrt
--right-Extracts specific number of characters from the end
--(value,no.of characters)

--Retrive the first 2 characters of each first name
Select
first_name,
LEFT(TRIM(first_name),2) AS left_char
from customers;


--Retrive the last 2 hcracters of each first name
Select
first_name,
RIGHT(TRIM(first_name),2) AS right_char
from customers;

--SUBSTRING(value,start,length)
 --Retrive a list of customers first names removing the first characters

 SELECT
 first_name,
 SUBSTRING(TRIM(first_name),2,4) AS sub_name,
 SUBSTRING(TRIM(first_name),2,len(first_name)) AS sub_name
 FROM customers







