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