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