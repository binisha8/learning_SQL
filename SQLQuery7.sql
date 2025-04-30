-- FILTERING DATA

--Retrive allcustomers from germany
select * 
from customers 
where country='Germany'

--Retrive all customers who are not from Gernamy
select * 
from customers
where country <> 'Germany' --(!=)

--Retrive all customers with a score greater than 500

Select *
From customers
where score>500

--Retrive all customers with a score of 500 or more
Select * 
from customers
where score >=500


--retrive all the customers who are from USA and have a score greater than 5
select * from customers 
where country='USA' and score>500;

--Retrive all customers with a score not less than 500

select * from customers
where not  score < 500

--Retrive all customers whose score falls in the range between 100 and 500
select * from customers 
where score between 100 and 500;

select * from customers 
where score >=100 AND score <= 500


-- Retrive all customers from either Germany or USA
Select * from customers 
where country= 'Germany' or country ='USA';

--OR
select * from customers 
where country IN ('Germany','USA')


--Find all customers whose first name starts with 'M'
select * from customers
where first_name LIKE  'M%'

--Find all customers whose first name ends with 'n'
select * from customers 
where first_name Like '%n'

--Find all customers whose first name contains 'r'
select * from customers 
where first_name LIKE '%r%'

--Find all customers whose first name  has 'r' in the thiird position
select * from customers 
where first_name LIKE  '__3%'--means that 1st and 2 character may be anything _ _ and 3rd position is fror r


