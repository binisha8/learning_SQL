/*Create table persons( 
id int not null,
person_name varchar(50) not null,
birthdate date,
phone varchar(15) not null,
constraint pk_persons primary key (id)
);*/
select * from persons
 -- insert data from 'customers' into persons
 /*Insert into persons(id,person_name,birthdate,phone)
 Select
 id,
 first_name,
 NULL,
 'unknown'
 from customers;*/
 select * from persons;
 






 --MODIFY THE DATA

 --change the score of customer with id 6 to 0
 update customers
 set score=0
 where id=6;

 select *from customers
 where id =6;

 --change the score of customer with id 10 to 0 and update the country to 'UK'
 update customers
 set score =0,
     country ='UK'
where id =4

select * from customers;

--update all customers with null score by setting their score to 0

update customers
set score=0
where score  IS NULL

select * from customers;
 
 --Delete all the customers whose id is greater than 5
 delete from customers
 where id>5

 select * from customers

 --Delete From persons

 TRUNCATE table persons --only delete the data contents


 select * from customers