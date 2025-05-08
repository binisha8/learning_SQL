create database bank;
create table account
(account_number varchar(15) not null unique,
branch_name varchar(15) not null,
balance numeric(8,2) not null,
primary key(account_number));
create table branch
(branch_name varchar(15) not null unique,
branch_city varchar(15) not null,
assets numeric(8,2) not null,
primary key(branch_name));

create table customer
(customer_name varchar(15) not null unique,
customer_street varchar(12) not null,
customer_city varchar(15) not null,
primary key(customer_name));

/*Note: Join free Sanfoundry classes at Telegram or Youtube*/
create table loan
(loan_number varchar(15) not null unique,
branch_name varchar(15) not null,
amount numeric not null,
primary key(loan_number));

create table depositor
(customer_name varchar(15) not null,
account_number varchar(15) not null,
primary key(customer_name, account_number),
foreign key(account_number) references account(account_number),
foreign key(customer_name) references customer(customer_name));
create table borrower
(customer_name varchar(15) not null,
loan_number varchar(15) not null,
primary key(customer_name, loan_number),
foreign key(customer_name) references customer(customer_name),
foreign key(loan_number) references loan(loan_number));

/*NOTE: Please insert the following data into the database for the execution of further queries.*/

insert into customer values ('Jones', 'Main', 'Harrison');
insert into customer values ('Smith', 'Main', 'Rye');
insert into customer values ('Hayes', 'Main', 'Harrison');
insert into customer values ('Curry', 'North', 'Rye');
insert into customer values ('Lindsay', 'Park', 'Pittsfield');

insert into customer values ('Brooks', 'Senator', 'Brooklyn');
insert into customer values ('Green', 'Walnut', 'Stamford');
insert into customer values ('Jackson', 'University', 'Salt Lake');
insert into customer values ('Majeris', 'First', 'Rye');
insert into customer values ('McBride', 'Safety', 'Rye');

insert into branch values ('Downtown', 'Brooklyn', 900000);
insert into branch values ('Redwood', 'Palo Alto', 2100000);
insert into branch values ('Perryridge', 'Horseneck', 1700000);
insert into branch values ('Mianus', 'Horseneck', 400200);
insert into branch values ('Round Hill', 'Horseneck', 8000000);
insert into branch values ('Pownal', 'Bennington', 400000);
insert into branch values ('North Town', 'Rye', 3700000);
insert into branch values ('Brighton', 'Brooklyn', 7000000);
insert into branch values ('Central', 'Rye', 400280);

insert into account values ('A-101', 'Downtown', 500);
insert into account values ('A-215', 'Mianus',700);
insert into account values ('A-102', 'Perryridge', 400);
insert into account values ('A-305', 'Round Hill', 350);
insert into account values ('A-201', 'Perryridge', 900);
insert into account values ('A-222', 'Redwood', 700);
insert into account values ('A-217', 'Brighton', 750);
insert into account values ('A-333', 'Central', 850);
insert into account values ('A-444', 'North Town', 625);

insert into depositor values ('Johnson','A-101');
insert into depositor values ('Smith', 'A-215');
insert into depositor values ('Hayes', 'A-102');
insert into depositor values ('Hayes', 'A-101');
insert into depositor values ('Turner', 'A-305');
insert into depositor values ('Johnson','A-201');
insert into depositor values ('Jones', 'A-217');
insert into depositor values ('Lindsay','A-222');
insert into depositor values ('Majeris','A-33');
insert into depositor values ('Smith', 'A-444');

insert into loan values ('L-17', 'Downtown', 1000);
insert into loan values ('L-23', 'Redwood', 2000);
insert into loan values ('L-15', 'Perryridge', 1500);
insert into loan values ('L-14', 'Downtown', 1500);
insert into loan values ('L-93', 'Mianus', 500);
insert into loan values ('L-11', 'Round Hill', 900);
insert into loan values ('L-16', 'erryridge', 1300);
insert into loan values ('L-20', 'North Town', 7500);
insert into loan values ('L-21', 'Central', 570);

insert into borrower values ('Jones', 'L-17');
insert into borrower values ('Smith', 'L-23');
insert into borrower values ('Hayes', 'L-15');
insert into borrower values ('Jackson', 'L-14');
insert into borrower values ('Curry', 'L-93');
insert into borrower values ('Smith', 'L-11');
insert into borrower values ('Williams','L-17');
insert into borrower values ('Adams', 'L-16');
insert into borrower values ('McBride', 'L-20');
insert into borrower values ('Smith', 'L-21');
select* from account;
select* from branch;
select* from customer;
select* from loan;
select* from depositor;
select* from borrower;
/*list all the customer details,branch and account detail according to accno*/

select distinct customer.*,account.*,branch.*
from customer  
  inner join depositor 
on depositor.customer_name=customer.customer_name
  inner join account
on depositor.account_number=account.account_number
 inner join branch
on account.branch_name=branch.branch_name
order by account.account_number desc;
/*list the branch name where  the average account balance is more than 50000*/
select branch_name,avg(balance)as average_balance
from account
group by branch_name
having avg(balance)>50000;

Alter table account
alter column balance int;
insert into account values ('B-217', 'Xrighton', 750);
insert into account values ('B-333', 'Yent0ral', 850);
insert into account values ('B-444', 'Zorth Town', 625);

/*increase all accounts with balances over $10000 by 5% and other receive 6%*/ 
update  account
set balance=
case
when balance >10000 then (balance*0.05+balance)
else (balance*0.06+balance)
end;
/*list branch_cities and total ssets where total asset are more than $1000000 in the city*/
select branch_city,sum(assets)as total_assets
from  branch
group by  branch_city
having sum(assets) > 1000000;



