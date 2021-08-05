-----------UC1-------------
-----CREATE DATABASE 
create database payroll_service;

use payroll_service;

---------UC2-------------
create table employee_payroll
(
empId int identity(1,1) primary key,
name varchar(20) not null,
salary float,
startDate date,
emailId varchar(20)
);

----------UC3-------------
Insert into employee_payroll(name,salary,startDate,emailId) values ('girish',25000,'2021-05-14','v.g@gmail.com'),('madhu',28000,'2021-07-21','v.m@gmail.com');
Insert into employee_payroll values ('nivas',90000,'2016-03-16','v.n@gmail.com'),('pavan',23000,'2020-11-30','pavan@gmail.com');

----------UC4--------------
select * from employee_payroll;

--------UC5-----------
select name,salary from employee_payroll where name='nivas';
select name,salary from employee_payroll where startDate between ('2021-01-01') and getdate();

-------------UC6----------
alter table employee_payroll add Gender char(1);

update employee_payroll set Gender='M' where name='girish' or name='nivas' or name='pavan';

update employee_payroll set Gender='F' where name='madhu';

--------UC7--------------
select sum(salary) as TotalSalary from employee_payroll;

select sum(salary)as TotalSalary ,gender  from employee_payroll where Gender='M' group by Gender;

select sum(salary)as TotalSalary,gender from employee_payroll group by Gender;

select avg(salary)as avgSalary,gender  from employee_payroll group by Gender;

select min(salary) as minSalary ,gender from employee_payroll   group by gender;

select count(salary) as CountofGender ,gender from employee_payroll   group by gender;

select max(salary) as maxSalary ,gender from employee_payroll   group by gender;

-------------UC8-----------
alter table employee_payroll add PhoneNumber bigint;

alter table employee_payroll add Department varchar(20) not null default 'HR';

update employee_payroll set PhoneNumber=7660094458 where name='girish';
update employee_payroll set PhoneNumber=9182501714 where name='madhu';
update employee_payroll set PhoneNumber=9123456780 where name='nivas';
update employee_payroll set PhoneNumber=8123456790 where name='pavan';


alter table employee_payroll add Address varchar(25) default 'Not Provided';


update employee_payroll set Address='nellore' where name='girish';
update employee_payroll set Address='hyderabad' where name='madhu';
update employee_payroll set Address='banglore' where name='nivas';
update employee_payroll set Address='chennai' where name='pavan';

------------UC9-------------------
Exec sp_rename 'employee_payroll.salary','Basic Pay','COLUMN';

alter table employee_payroll add Deductions float,TaxablePay float,IncomeTax float,NetPay float;

update employee_payroll set Deductions=1500 where Department='HR';
update employee_payroll set Deductions=1700 where Department='Accounts and Finance'
update employee_payroll set Deductions=2100 where Department='Product development';
update employee_payroll set Deductions=1570 where Department='Business development' ;
update employee_payroll set Deductions=2212 where Department='Research development';

update employee_payroll set NetPay=18500 where name='girish';
update employee_payroll set NetPay=23800 where name='madhu';
update employee_payroll set NetPay=60000 where name='nivas';
update employee_payroll set NetPay=19000 where name='pavan';

update employee_payroll set IncomeTax=1200;

update employee_payroll set TaxablePay=200;