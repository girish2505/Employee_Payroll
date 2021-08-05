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
