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

----------UC10--------------
Insert into employee_payroll values('madhu',28000,'2021-07-21','v.m@gmail.com','F',9182501714,'HR','hyderabad',1500,200,1200,23800);

---------------UC11----
---Company Table
Create Table Company
(CompanyID int identity(1,1) primary key,
CompanyName varchar(100))
---Insert the values
Insert into Company values ('sai'),('deepak')

select * from company;

--Create Employee Table
create table Employee
(EmployeeID int identity(1,1) primary key,
Company_Id int,
EmployeeName varchar(200),
EmployeePhoneNum bigInt,
EmployeeAddress varchar(200),
StartDate date,
Gender char,
Foreign key (Company_Id) references Company(CompanyID)
)
---Insert the employee table
insert into Employee (Company_Id,EmployeeName,EmployeePhoneNum,EmployeeAddress,StartDate,Gender)values
(1,'lahari','1234567890','gudur','2020-02-14','F'),
(2,'Vishnu','2345654321','mumbai','2019-03-12','M'),
(1,'Ajay','9848022338','UK','2021-07-12','M'),
(2,'srini','9087654321','vijayawada','2020-03-15','M');
---Retrieve the data
Select * from employee;

--Create Payroll Table
create table PayRollCalculate
(
Employee_Id int,
BasicPay float,
TaxablePay float,
IncomeTax float,
NetPay float,
Deductions float,
Foreign key (Employee_Id) references Employee(EmployeeID)
)
---Insert the values in payrollcalculate table
Insert into PayRollCalculate (Employee_Id,BasicPay,IncomeTax,Deductions)values
(1,45000,1000,1500),
(2,64000,1432,1700),
(3,85000,1300,1240),
(4,55000,3000,1030);
---Retrieve the data
Select * from PayRollCalculate;
--Set the taxablepay and netpay value using update
update PayRollCalculate set TaxablePay=BasicPay-Deductions;

update PayRollCalculate set NetPay=TaxablePay-IncomeTax;

--Create Department Table
create table DepartmentTable
(
DepartmentId int identity(1,1) primary key,
DepartName varchar(100)
)
--Insert the value
Insert into DepartmentTable values
('HR'),
('Accounts and Finance'),
('Product development');
--Retrieve the data
Select * from DepartmentTable;
----Create Employee Department table
create table EmployeeDept
(
Dept_Id int ,
Employee_Id int,
Foreign key (Employee_Id) references Employee(EmployeeID),
Foreign key (Dept_Id) references DepartmentTable(DepartmentID)
)
------Insert the values in employeedept table
Insert into EmployeeDept(Dept_Id,Employee_Id) values
(1,1),
(2,2),
(3,3),
(2,4);
--Retrieve the data
select * from EmployeeDept;

-----------UC12------------

---UC4-->Retrieve the data 
Select CompanyID,CompanyName,
EmployeeID,EmployeeName,EmployeeAddress,EmployeePhoneNum,StartDate,Gender,
BasicPay,TaxablePay,IncomeTax,NetPay,Deductions,DepartmentId,DepartName
from Company
inner join Employee on Company.CompanyID=Employee.Company_Id
inner join PayRollCalculate on PayRollCalculate.Employee_Id=Employee.EmployeeId
inner join EmployeeDept on EmployeeDept.Employee_Id=Employee.EmployeeID
inner join DepartmentTable on DepartmentTable.DepartmentId=EmployeeDept.Dept_Id; 

-------UC5---->Retrieve the data using employeename 
select CompanyID,CompanyName,EmployeeID,EmployeeName,EmployeeAddress,EmployeePhoneNum,StartDate,Gender
from Company
inner join Employee on Company.CompanyID=Employee.Company_Id and Employee.EmployeeName='Vishnu';

-------UC5------->Retrieve the data from startdate and now(current date)
select CompanyID,CompanyName,EmployeeID,EmployeeName,StartDate,BasicPay 
from Company
inner join Employee on Company.CompanyID=Employee.Company_Id and StartDate between Cast('2019-01-01' as Date) and GetDate()
inner join PayRollCalculate on Employee.EmployeeID=PayRollCalculate.Employee_Id;

-----UC7----->Performing aggregate Functions using group by...
Select sum(BasicPay) as TotalSalary,Gender 
from Employee
inner join PayRollCalculate on Employee.EmployeeID=PayRollCalculate.Employee_Id group by Gender;

Select Avg(BasicPay) as AvgSalary,Gender 
from Employee
inner join PayRollCalculate on Employee.EmployeeID=PayRollCalculate.Employee_Id group by gender;

Select min(BasicPay) as MinSalary,Gender 
from Employee
inner join PayRollCalculate on Employee.EmployeeID=PayRollCalculate.Employee_Id group by Gender;

Select max(BasicPay) as MaxSalary,Gender 
from Employee
inner join PayRollCalculate on Employee.EmployeeID=PayRollCalculate.Employee_Id 
where Gender='F' group by Gender;

Select count(BasicPay) as CountOfPersons,Gender 
from Employee
inner join PayRollCalculate on Employee.EmployeeID=PayRollCalculate.Employee_Id group by Gender;