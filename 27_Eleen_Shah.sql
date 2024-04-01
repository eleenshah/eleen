#DBMS Module End Exam
use hr;
#1. Create a customers table gaving 4 constrainsts.
/* Constraints are used to enhance integrity of database - In table customers, I have used 4 constraints
1] primary key - It is used to uniquely identify each row in a table. It cant be null.
2]Not Null- Field will bot accept null values.
3]Unique - Each value must be unique.eg:phone number , emailid. This maintains privacy as no 2 users can have same phonenumber or email id.
4]Default - It is used to set a default value when no value is passed.
5]Check - It is used to check a condition before inserting the value. */

create table customers(
cid int primary key,    #Primary key
cname varchar(30) not null,  #Not Null
phoneno varchar(20) unique,  #Unique
branch set('Mumbai','Bangalore','Delhi','Jaipur') default 'Mumbai',  #Default
age int check(age>18));  #Check
 
desc customers;

#2. Insert records in customers
insert into customers values(12,'Eleen Shah','9082223670','Mumbai',21);
insert into customers values(13,'Ruchi Shah','9087899970','Delhi',22);
insert into customers values(14,'Jay Shah','9920349227','Jaipur',42);
insert into customers(cid,cname,phoneno,age) values(15,'Riya Shah','9920378827',32); #Using default value for branch
select * from customers;

#3. Write a query to find name of employee whose name contains only 4 characters
select first_name from employees where length(first_name)=4;  #Using length() function which returns length of field in bytes
select first_name from employees where first_name like '____'; #Using wildcard character _ which represents one character only.
select * from employee_spare;

#4. Display total salary paid to employees work in each department.
select department_id,sum(salary) as 'Total Salary of dept' from employee_spare 
group by department_id order by sum(salary) desc;  #This will display total expenditure of each department on salaries of thei respective employees.


#5. Write a query that returms all employees who work in departments with an average salary greater than 75,000 per year.
#Query
select * from employee_spare where department_id in
(select department_id from employee_spare group by department_id having avg(salary)>75000);

#Sub-Query of Query to view average salary dept wise
Select department_id,avg(salary) as 'Avg Salary dept' from employee_spare group by department_id order by avg(salary) desc;
#After executing sub query we can see that there is no dept with avg(salry)>75000 tht's why the query will not display anything
select * from employee_spare where department_id in
(select department_id from employee_spare group by department_id having avg(salary)>10000);

#6. Write a query to fetch the region id which contains most number of cities.
select * from locations; 
select * from countries;
#This query displays all regions with number of cities
#select c.region_id,count(*) as 'Number of Cities' from locations l inner join countries c on l.country_id=c.country_id group by region_id;  
#We have region id column in ccountries and city column in locations. So we need to join both tables using common column country-id and group by region_id
#and count(city) to get desired result.

select c.region_id,count(l.city) as 'Number of Cities' from locations l inner join countries c
on l.country_id=c.country_id group by region_id order by count(l.city) desc limit 1;

#7. Write a stored procedure that takes an employee id as an input parameter and returns the emp's name,dept name,and hire_date
delimiter //
create procedure Emp_Details_deptname(in empid int)  #Passing input parameter empid
begin
    select concat(first_name," ",last_name) as full_name,d.department_name,e.hire_date from employee_spare e  #Selecting columns
    inner join departments d on e.department_id=d.department_id where e.employee_id=empid;
end;
//
drop procedure Emp_Details_deptname;
call Emp_Details_deptname(109);  #Call procedure 

#8. Write a stored function that takes an employee id as an input parameter and returns the number of years the employee has been with the company
delimiter //
create function Num_of_Years_with_Company(emp_id int)
returns int
deterministic
begin
     declare Num_of_Years int;
     select timestampdiff(year,hire_date,curdate()) into Num_of_Years from employee_spare where employee_id=emp_id;
     return Num_of_Years;
end;
//
delimiter ;
drop function Num_of_Years_with_Company;
select * from employee_spare;
select Num_of_Years_with_Company(100) as Num_of_Years;

#Mongo DB- Use restaurant.json

#use mydb;
#show collections;
#db.restaurant.find();

#1] Retrieve all documents where name starts with letter P
# db.restaurant.find({name:/^P/});

#2] Retrieve all docs where cusine equal to Bakery or Chinese
#  db.restaurant.find({"cuisine":{"$in":["Bakery","Chinese"]}});

#3]Retrieve all docs where grades.score >= 20
# db.restaurant.find({"grades.score":{"$gte":20}});
# db.restaurant.find({"grades.grade":'B',"grades.score":{"$gte":20}});




select first_name from employees where first_name='s';

SELECT e.first_name, e.salary, e.department_id, b.maxsal FROM employee_spare e, 
(SELECT department_id, MAX(salary) maxsal FROM employee_spare GROUP BY department_id) b  WHERE e.department_id = b.department_id AND e.salary < b.maxsal;  

alter table emp change column empno empnumber int;
select * from emp;