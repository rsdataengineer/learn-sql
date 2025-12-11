show databases;						-- show all database in MYSQL server
use database 'database_name'		-- selects the particular database
show tables;						-- show all tables in selected database
drop database 'database_name'		-- deletes the database mentioned. This is a DDL command and deletes the complete database with all tables in it

-- Creating a table
'create table table_name(
col_name datatype constraint,
col_name datatype constraint)'

-- Datatypes define what type of kind of data can be stored in the columns
'Commonly used datatypes
Int -- for storing integer or numbers
Varchar -- for storing variable length strings or characters
Decimal -- for storing numbers with decimals
Float
Double
Date -- for storing dates
Datetime -- for storing dates and time
Boolean -- for storing True or False'

-- Constraints in SQL are rules applied to columns of table to enforce data integrity and accuracy. Constraints ensure that data entered is valid and consistent and follow the rules while entering data in table
'Not null -- enforce null or blank data cannot be stored
Unique -- ensures all values or data in a column are unique. Unique constraint can be used with multiple columns in a table
Primary Key -- it is combination of both unique and not null. It uniquely identifies each record or row in a table and cannot have null. Only one primary key can be used in a table and also used to create connection or relation with other table using foriegn key. It unique
Foreign Key -- it creates a link between 2 tables and ensures value in a column exist in another table primary key. It refers to the primary key in another table. It can have duplicate or null values and there can be mulitple Foreign keys
Check -- checks the data based on a condition. For example in a voting list, age must be more than 18 therefore check constraint can be added which ensures all records entered are or age 18 or above
Default -- this provides default value in case of null. While entering data if no value is provided for a column, this constraint enters the default value
Auto increment - this constraint is used with integer type column. This contraint increments the value for every next record'

-- Composite Key - It is a primary key made of two or more columns. It uniquely identifies a record using combination of columns
-- Surrogate Key - It is an artificial key usually an auto increment number. These are used when natural keys are inconvenient or too long

--Types of SQL commands:
'DDL - Data Defination Language - These commands defines and deals with the structure of the table. These command describes the blueprint of the table and used for structural change of table. CREATE, ALTER, DROP, TRUNCATE
DML - Data Manipulation Language - These deals with the data of table and not structure. These commands effects the records or data of the table and not their structure. INSERT, DELETE, UPDATE
D'


show databases;								-- show all databases in the server
use tutorial;								-- use tutorial database
show tables;								-- shows all tables under tutorial database

create table stores(						-- this creates a table with name store_name under tutorial database
store_id int primary key,					-- this table contains store_id column that is of integer datatype and is primary key
store_name varchar(100) not null			-- another column is store_name that is of varchar type and has not null constraint
);

use ecom;
show tables;

select * from dim_customer;
select * from dim_product;
select customer_id, email from dim_customer;

-- Indentation is used for proper code readabilty
select customer_id, first_name, last_name,email
from dim_customer;

-- Limit clause is to limit the rows or records that need to be returned in select query. It sets an upper limit on numbers of rows to be returned
select * from dim_customer
limit 20;

-- Where clause is used to apply filter records and used with existing column of the table. It is also known as pruning the data and is executed before group by
select * from dim_customer										-- Only one where clause is used in one statement
where (gender = 'F') and (country = 'France') and (join_date > '2022-01-01');

-- Where clause with multiple conditions
select * from dim_customer
where (gender = 'F') AND ((country = 'France') OR (join_date > '2022-01-01'));

-- Operators in where clause
'Arithmetic operators: + - * / %
Comparision operators: = != < > <= >=
Logical operators: AND OR NOT IN NOT IN BETWEEN ALL LIKE ANY'


-- Like Operation is used in a where clause to search a specific pattern in a string
select first_name, last_name
from dim_customer
where (first_name LIKE 'T%');

(-- Order by clause is used to sort data in ascending or descending order
select * from dim_product
order by unit_price;				-- By default MYSQL sorts the data in ascending order

select * from dim_product
order by unit_price desc;			-- to sort data in descending order we use desc keyword
)


(-- Distinct clause is used to remove duplicate rows
select distinct category from dim_product;

-- Distinct can be used to find unique combination with mulitple columns as well
select distinct category, brand		-- This returns unique (category, brand) combination, not unique values of each column individually
from dim_product;

-- Distinct can also be used to count unique values in a column
select count(distinct brand) from dim_product;
)


select first_name, last_name
from dim_customer
where (first_name LIKE 'T%') AND (first_name LIKE '%y');

select * from dim_customer
where
first_name LIKE 'T__f%y';

select * from dim_product order by unit_price;

select * from dim_product order by unit_price desc;

-- How to find top 3 expensive products
select * from dim_product
order by unit_price desc
limit 3;

-- Aggregate Functions - they perform calculations on set of values, and return single value
-- COUNT - retuns the count of values
-- MAX - retuns the maximum value
-- MIN - retuns the minimum value
-- SUM - retuns the sum of all values
-- AVG - retuns the average of all values


-- GroupBy is used to group records that have same values in the columns and then apply aggregation. It can be understood as grouping the rows and then giving aggreagation or criteria for grouping
select category, avg(unit_price) as 'Average Price', sum(unit_price) as 'Total Price'
from dim_product
group by category;

-- Having by is used to filter data from aggregated column. It is used with group by clause. Where clause is used to filter rows before grouping, and having by is used to filter groups after grouping
select category, avg(unit_price) as avg_price, sum(unit_price) as total_price
from dim_product
group by category
having avg_price > 500;

(-- Execution Flow tells how SQL engine is processing the query
select category, avg(unit_price) as avg_price	-- 5 Then it will returns the required results
from dim_product								-- 1 It will first select the table on which query will be executed
where country = 'France'						-- 2 It will filter the data and will save computation time
group by category								-- 3 Then it group the records
having avg_price > 500							-- 4 and then applies having filter
order by										-- 6 Later the data is sorted
limit											-- 7 and then apply limit on data
)

-- Union 

-- JOINS in MYSQL. Joins is used to combine or join two or multiple tables based on a related column between them. Several tables can be joined together, therefore for joining n tables, you need (n-1) joins
-- Whenever applying join, the datatype of both common column must be same and exactly matching
'Types of Joins:
Inner Join - Returns only matching rows from both tables
Left Join - Returns all rows from left table plus matching rows from right table. Non-matching values become NULL
Right Join - Returns all rows from right table plus matching rows from left table. Non-matching values become NULL
Full Join - MYSQL does not support Full Join directly however we can simulate it using Union
Cross Join - Returns all possible combinations
Self Join - Table joined with itself'

-- Inner Join. By default MYSQL does inner join
select *
from orders o
inner join customers c
on o.cust_id = c.cust_id

-- Left Join
select o.*, c.id
from orders o
left join customers c
on o.cust_id = c.cust_id

-- Right Join
select o.*, c.id
from orders o
right join customers c
on o.cust_id = c.cust_id

-- DML commands - These commands works and updates
'DML commands modifies the data or record of the table:
Insert - this inserts record or data into table
Update - this updates records based on a condition in where clause and used with set keyword for new value
Delete - this deletes records based on condition in where clause'





-- TRANSFORMATIONS


-- Type Casting - It is done to cast the datatype of a column into another one while applying a join or during a query. **MYSQL does NOT SUPPORT varchar inside cast.
'Only supported datatypes in cast are:
Char, Binary, Date, DateTime'

-- STRING FUNCTIONS

select customer_key, cast(customer_key as char(255))
from dim_customer;

select * from dim_customer;
desc dim_customer;


select concat(first_name, '  ', last_name) as full_name
from dim_customer;

select concat_ws(' ',first_name, last_name, country) as full_details from dim_customer;

select 
	first_name, last_name, concat(first_name, ' ', last_name) as full_name,
	country, length(country) as country_length
from dim_customer;

select first_name, last_name, upper(country) from dim_customer;

select first_name, last_name, lower(country) from dim_customer;

select email, substring(email, 1, 4) from dim_customer;

select email, replace(email, '@','%') as new_email from dim_customer;

select country, left(country, 3) as left_slicing from dim_customer;

select country, right(country, 3) as right_slicing from dim_customer;

select country, reverse(country) as rev_country from dim_customer;


-- CONDITIONAL STATEMENTS - case when statements. These are similar to if else condition.
select * from dim_product;

select *,
	case
    when unit_price <= 100 then 'affordable'
    when unit_price<= 200 then 'normal'
    else 'expensive (but not for you!)'
    end as price_category
from dim_product;


-- MYSQL does not support aggregate function inside a CASE clause
select *,
	case
    when unit_price > (select avg(unit_price) from dim_product) then 'profitable product'
    when unit_price < (select avg(unit_price) from dim_product) then 'needs improvement'
    else 'normal pricing'
    end as product_type
from dim_product;


select *,
	case
    when unit_price <= 100 and category = 'clothing' then 'affordable'
    when unit_price<= 200 and category = 'clothing' then 'normal'
    when unit_price > 200 and category = 'clothing' then 'expensive (but not for you!)'
    else concat('Not for ',category)
    end as price_category
from dim_product;


-- WINDOW FUNCTIONS - these are special functions that perform calculations over set of rows. These functions let us perform calculations across set of rows without collapsing them like aggregate functions
-- Window functions useful for ranking, running totals, moving averages, comparisions within partitions - Row number, Ranking, Dense Rank
'function_name(expression)
over(
	[partition by col_name, col_name]
    [order by col3]
    [rows between ...]
)'

select * from dim_product;


-- Ranking


-- Partition divides the rows in a group based on a criteria and resets the counting for each partition

select
	*,
	row_number() over(partition by category order by unit_price) as rw_number,
    rank() over(partition by category order by unit_price) as rank_number,
    dense_rank() over (partition by category order by unit_price) as dnsrnk
from dim_product;						-- Here partition is applied on category, therefore counting is reset for each category


-- SUBQUERY in MYSQL - These are queries written inside another query or a query inside another query. They are used when you need to get the result from a query to use inside another query
-- subquery or inside query is executed first and then it's result is used for outside query. It is used when going through multiple transformations or multi-step queries
select * from dim_product;
select unit_price from dim_product order by unit_price desc;

select * from dim_product where unit_price > (select avg(unit_price) from dim_product);	-- this returns the records which has unit price more than average of unit price

select * from (
	select * from dim_product where unit_price > (select avg(unit_price) from dim_product)
    ) as subquery
where product_name = 'Figure Method'							-- This uses the result of a query inside another query

select max(unit_price) from dim_product where unit_price <  (select max(unit_price) from dim_product);		-- this returns the second highest expensive product


-- CTE are called Common Table Expressions. These are kind of alternatives to subqueries. These can be undestood as temporary tables or when you want to query from temp table. CTE's can be used from 'from clause' and not withiin where
with cte_table as (
select * from dim_product 
where unit_price > (select avg(unit_price) from dim_product)
)
select * from cte_table where product_name = 'Figure Method';		-- CTE expects another query afterward. In MySQL, a CTE must always be followed by a main select/insert/udpate/delete


with cte_table as (
select * from dim_product 
where unit_price > (select avg(unit_price) from dim_product)
)
select * from cte_table 
where product_name in ('Figure Method', 'Huge Change', 'Film Finally')

-- merged CTEs - here we are creating multiple common table expressions
with cte_table as (
select * from dim_product 
where unit_price > (select avg(unit_price) from dim_product)
),
cte_table_2 as (
select * from cte_table 
where product_name in ('Figure Method', 'Huge Change', 'Film Finally')
)
select * from cte_table_2 where product_name = 'Figure Method'

-- REAL TIME SCENARIO
-- Finding the nth value - using Limit + offset. Limit 1 offset (n-1)
select *
from dim_product
order by unit_price desc
limit 1 offset 4;				-- here limit is 1 and offset is (n-1)

-- Finding nth highest value  - using window function
select * from
(select *,
rank() over(order by unit_price desc) as rnk
from dim_product) as u
where u.rnk = 5;					-- here u.rnk is n

-- Finding TOP n highest values - using Limit clause
select *
from dim_product
order by unit_price desc
limit 5;									-- here limit is n

-- Finding TOP n highest values using window function
select * from
(select *,
row_number() over (order by unit_price desc) as rn,
rank() over (order by unit_price desc) as rnk
from dim_product) as ecom
where ecom.rn < 6 and ecom.rnk <6;					-- here rn or rnk is < (n+1)

-- Finding TOP n highest values in each category

select * from
(select *,
	dense_rank() over (partition by category order by unit_price) as dns,
    row_number() over (partition by category order by unit_price) as rn
from dim_product) as ecom
where ecom.dns < 6;							-- here dns < (n+1)

-- Finding nth highest values in each category
select * from
(select *,
	dense_rank() over (partition by category order by unit_price) as dns,
    row_number() over (partition by category order by unit_price) as rn
from dim_product) as ecom
where ecom.dns = 5;

-- Removing Duplicates
select *
from
(select *,
	row_number() over(partition by id, order by id) as dedup
from customers) as dup
where dup.dedup = 1

-- LAG and LEAD window functions - these are used to find previous or following records or preceding and subsequent value
-- LAG checks for preceding or previous data
-- LEAD checks for subsequent or following data

create table weather(
id int,
temp float);

insert into weather values
(1,10),
(2,12),
(3,9),
(4,15),
(5,20);

select * from weather;

select *,
	lag(temp,1,0) over (order by id) as previous_daytemp,			-- lag function takes 3 parameters (from what column, lag by how much, default value in case of null)
    lead(temp,1,0) over (order by id) as next_daytemp				-- similarly lead function also takes 3 parameters (from what column, lead by how much, default value)
from weather;


-- VIEW in MySQL - View is kind of virtual table - which looks like a table but not physically stored. These are created from select query and everytime a view is queried, MySQL runs the select query in background
-- Views are used to simplify complex queries and reuse SQL logic and codes without rewriting the same statements.
-- Cases when a view is updatable - it is based on one table, no GROUP BY, no DISTINCT, no aggregate functions, no UNION, no window functions

create view w_func as 						-- here a view is created with syntax create view view_name as (select query)
select
	*,
	row_number() over(partition by category order by unit_price) as rw_number,
    rank() over(partition by category order by unit_price) as rank_number,
    dense_rank() over (partition by category order by unit_price) as dnsrnk
from dim_product;

select * from w_func;						-- view can be queried just like a table with select statement


-- STORED PROCEDURES - Stored Procedure is a predefined set of SQL statements that are stored in the database and can be executed or called whenever needed. They can perform multiple operations and can modify data
-- First of all we have to define a delimiter - this is a character which tells the end of code for stored procedure

create table pro(
p_id int,
p_name varchar(255),
p_email varchar(255)
);

delimiter //
create procedure first_procedure(in p_id int, in p_name varchar(255), in p_email varchar(255))
begin										-- this initiates the procedure
	insert into pro
    values
    (p_id, p_name, p_email);
end //

delimiter ;

call ecom.first_procedure(2, 'Airpods', 'airpods@apple.com');

select * from pro;

Explain OrderBy clause in SQL.
The ORDER BY clause in SQL is used to sort the result set of a query by one or more columns. It allows you to specify the order in which the rows should be returned, either in ascending (ASC) or descending (DESC) order. By default, if no order is specified, the sorting is done in ascending order.
Here is the basic syntax of the ORDER BY clause:
```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;
```

Difference between where and having clause in SQL.
The WHERE clause and HAVING clause in SQL are both used to filter records, but they are used in different contexts and serve different purposes.
1. WHERE Clause:
- The WHERE clause is used to filter rows before any groupings are made. It is applied to individual rows in a table.
- It cannot be used with aggregate functions (like COUNT, SUM, AVG, etc.)
Example:
```sql
SELECT * FROM Employees
WHERE Salary > 50000; 
```
2. HAVING Clause:
- The HAVING clause is used to filter groups after the GROUP BY clause has been applied. It is used with aggregate functions.
- It allows you to filter the results of a GROUP BY query based on aggregate values.
Example:
```sql
SELECT Department, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 5;
```
In summary, use the WHERE clause to filter individual rows before grouping, and use the HAVING clause to filter groups after aggregation.

What is stored procedure in SQL?
A stored procedure in SQL is a precompiled collection of one or more SQL statements that are stored in the database and can be executed as a single unit. Stored procedures are used to encapsulate logic, improve performance, and promote code reuse. They can accept input parameters, return output parameters, and perform complex operations such as data manipulation, transaction control, and error handling.
Stored procedures are created using the CREATE PROCEDURE statement and can be executed using the EXEC or CALL command, depending on the database system. Here is a simple example of a stored procedure:
```sql
    CREATE PROCEDURE GetEmployeeByID
    @EmployeeID INT
AS
BEGIN
    SELECT * FROM Employees
    WHERE EmployeeID = @EmployeeID;
END;   
To execute the stored procedure, you would use:
```sql
EXEC GetEmployeeByID @EmployeeID = 1;
Stored procedures offer several benefits, including improved performance due to precompilation, reduced network traffic by executing multiple SQL statements in a single call, and enhanced security by controlling access to the underlying data.

What is trigger in SQL?
A trigger in SQL is a special type of stored procedure that automatically executes or "fires" in response to certain events on a particular table or view. Triggers are used to enforce business rules, maintain data integrity, and perform auditing tasks. They can be set to activate before or after data modification operations such as INSERT, UPDATE, or DELETE.
Here is the basic syntax for creating a trigger:
```sql
CREATE TRIGGER trigger_name
ON table_name
AFTER|BEFORE INSERT|UPDATE|DELETE
AS
BEGIN
    -- SQL statements to be executed when the trigger fires
END;
```
For example, the following trigger automatically logs changes made to the Employees table:
```sql
CREATE TRIGGER LogEmployeeChanges
ON Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO EmployeeAudit (EmployeeID, OldSalary, NewSalary, ChangeDate)
    SELECT d.EmployeeID, d.Salary, i.Salary, GETDATE()
    FROM deleted d
    JOIN inserted i ON d.EmployeeID = i.EmployeeID;
END;
```
In this example, the trigger "LogEmployeeChanges" fires after an UPDATE operation on the Employees table and logs the old and new salary values into the EmployeeAudit table.
Triggers are powerful tools for automating database tasks, but they should be used judiciously, as they can add complexity to database operations and may impact performance if not designed carefully.

What is a selfjoin and how would you use it?
A self-join is a type of join in SQL where a table is joined with itself. This is useful when you need to compare rows within the same table or when you want to retrieve related data from the same table. To perform a self-join, you typically use table aliases to differentiate between the two instances of the table.
Here is an example of how to use a self-join:
```sql
SELECT e1.EmployeeID AS EmployeeID, e1.Name AS EmployeeName, e2.Name AS ManagerName
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.EmployeeID;
```
In this example, the Employees table is joined with itself to retrieve a list of employees along with their respective managers. The table alias "e1" represents the employees, while "e2" represents the managers. The join condition matches the ManagerID of the employee with the EmployeeID of the manager.
Self-joins are particularly useful in hierarchical data structures, such as organizational charts or category trees, where you need to establish relationships between records within the same table.

What is subquery in SQL? Provide an example.
A subquery in SQL is a query nested inside another query. It is used to retrieve data that will be used in the main query as a condition or to provide a value. Subqueries can be placed in various parts of a SQL statement, such as the SELECT, FROM, WHERE, or HAVING clauses.
Here is an example of a subquery used in the WHERE clause:
```sql
SELECT EmployeeID, Name, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);
```
In this example, the subquery `(SELECT AVG(Salary) FROM Employees)` calculates the average salary of all employees. The main query then retrieves the EmployeeID, Name, and Salary of employees whose salary is greater than this average salary.
Subqueries can also be used in the FROM clause, as shown below:
```sql
SELECT Dept.DepartmentName, Emp.EmployeeCount
FROM Departments Dept
JOIN (SELECT DepartmentID, COUNT(*) AS EmployeeCount
      FROM Employees
      GROUP BY DepartmentID) Emp
ON Dept.DepartmentID = Emp.DepartmentID;
In this example, the subquery counts the number of employees in each department, and the main query joins this result with the Departments table to retrieve the department names along with their respective employee counts.
Subqueries are powerful tools that allow for more complex queries and can help break down problems into smaller, manageable parts.
```

What is transaction in SQL?
A transaction in SQL is a sequence of one or more SQL operations that are treated as a single unit of work. Transactions are used to ensure data integrity and consistency in a database. They follow the ACID properties, which stand for Atomicity, Consistency, Isolation, and Durability.
1. Atomicity: Ensures that all operations within a transaction are completed successfully. If any operation fails, the entire transaction is rolled back, and no changes are made to the database.
2. Consistency: Ensures that a transaction brings the database from one valid state to another valid state, maintaining all defined rules and constraints.
3. Isolation: Ensures that the operations of one transaction are isolated from those of other transactions, preventing concurrent transactions from interfering with each other.
4. Durability: Ensures that once a transaction is committed, the changes made are permanent and will survive any subsequent system failures.
Here is an example of how to use transactions in SQL:
```sql
BEGIN TRANSACTION;
    UPDATE Accounts
    SET Balance = Balance - 100
    WHERE AccountID = 1;
    UPDATE Accounts
    SET Balance = Balance + 100
    WHERE AccountID = 2;
COMMIT TRANSACTION;
```
In this example, two updates are made to the Accounts table as part of a single transaction. If both updates are successful, the transaction is committed, and the changes are saved. If either update fails, the transaction can be rolled back to maintain data integrity.
```sql
ROLLBACK TRANSACTION;
```
In this case, if an error occurs during either of the update operations, the ROLLBACK command can be executed to undo all changes made during the transaction, ensuring that the database remains in a consistent state.
Transactions are essential for maintaining the reliability and integrity of data in multi-user database environments.

What are ACID properties in SQL?
ACID properties in SQL refer to a set of four key principles that ensure reliable processing of database transactions. ACID stands for Atomicity, Consistency, Isolation, and Durability. These properties are essential for maintaining data integrity and ensuring that database transactions are processed correctly, even in the presence of errors, power failures, or other issues.
1. Atomicity: This property ensures that a transaction is treated as a single, indivisible unit of work. Either all operations within the transaction are completed successfully, or none of them are applied. If any part of the transaction fails, the entire transaction is rolled back to its previous state.
2. Consistency: This property ensures that a transaction brings the database from one valid state to another valid state. It guarantees that any data written to the database must adhere to all defined rules, constraints, and triggers, maintaining the integrity of the database.
3. Isolation: This property ensures that the operations of one transaction are isolated from those of other concurrent transactions. This means that the intermediate state of a transaction is not visible to other transactions until the transaction is committed. Isolation levels can be adjusted to balance performance and consistency.
4. Durability: This property ensures that once a transaction has been committed, the changes made are permanent and will survive any subsequent system failures, such as power outages or crashes. The changes are typically written to non-volatile storage to ensure their persistence.
Together, these ACID properties provide a framework for reliable transaction processing in relational database management systems,ensuring that data remains accurate, consistent, and secure even in complex multi-user environments.

How do you implement error handling in SQL?
Error handling in SQL can be implemented using various techniques depending on the database management system (DBMS) being used. Common methods include using TRY...CATCH blocks, error codes, and transaction control statements. Below are examples of how to implement error handling in SQL Server and PL/SQL (Oracle).
1. SQL Server (T-SQL) using TRY...CATCH:
```sql
BEGIN TRY
    BEGIN TRANSACTION;
    
    -- Your SQL statements here
    UPDATE Accounts
    SET Balance = Balance - 100
    WHERE AccountID = 1;

    UPDATE Accounts
    SET Balance = Balance + 100
    WHERE AccountID = 2;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;

    -- Capture error information
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    -- Raise the error
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
```
In this example, if any error occurs during the transaction, the CATCH block rolls back the transaction and captures the error details, which can then be raised or logged.
2. PL/SQL (Oracle) using EXCEPTION block:
```sqlBEGIN
    -- Your SQL statements here
    UPDATE Accounts
    SET Balance = Balance - 100
    WHERE AccountID = 1;

    UPDATE Accounts
    SET Balance = Balance + 100
    WHERE AccountID = 2;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;

        -- Capture error information
        DECLARE
            v_error_message VARCHAR2(4000);
        BEGIN
            v_error_message := SQLERRM;
            -- Log or raise the error message
            RAISE_APPLICATION_ERROR(-20001, v_error_message);
        END;
END;
```
In this PL/SQL example, if an error occurs, the EXCEPTION block rolls back the transaction and captures the error message, which can then be logged or raised.
These techniques help ensure that errors are properly managed, and the database remains in a consistent state even when unexpected issues arise during SQL operations.

What is normalization in SQL? Explain different normal forms.
Normalization in SQL is the process of organizing the data in a database to reduce redundancy and improve data integrity. The goal of normalization is to divide large tables into smaller, related tables and define relationships between them. This helps to minimize data duplication and ensures that data is stored efficiently.
There are several normal forms, each with specific rules that must be followed to achieve a certain level of normalization. The most commonly used normal forms are:
1. First Normal Form (1NF):
- A table is in 1NF if it contains only atomic (indivisible) values and each column contains unique values. There should be no repeating groups or arrays.
Example:
| StudentID | Course1 | Course2 |
|-----------|---------|---------|
| 1         | Math    | Science |
To convert to 1NF:
| StudentID | Course  |
|-----------|---------|
| 1         | Math    |
| 1         | Science |
2. Second Normal Form (2NF):
- A table is in 2NF if it is in 1NF and all non-key attributes are fully functionally dependent on the primary key. This means that there should be no partial dependency on a composite key.
Example:
| StudentID | Course  | Instructor |
|-----------|---------|------------|
To convert to 2NF:
| StudentID | Course  |
|-----------|---------|
| 1         | Math    |
| 1         | Science |
| Course    | Instructor |
|-----------|------------|
| Math      | Mr. A     |
| Science   | Ms. B     |
3. Third Normal Form (3NF):
- A table is in 3NF if it is in 2NF and all the attributes are functionally dependent only on the primary key. There should be no transitive dependency.
Example:
| StudentID | Course  | Instructor | InstructorPhone |
|-----------|---------|------------|------------------|
To convert to 3NF:
| StudentID | Course  |
|-----------|---------|
| 1         | Math    |
| 1         | Science |
| Course    | Instructor |
|-----------|------------|
| Math      | Mr. A     |
| Science   | Ms. B     |
| Instructor | InstructorPhone |
|------------|------------------|
| Mr. A      | 123-456-7890     |
| Ms. B      | 987-654-3210     |
4. Boyce-Codd Normal Form (BCNF):
- A table is in BCNF if it is in 3NF and for every functional dependency, the left-hand side is a superkey. This is a stricter version of 3NF.
Normalization helps to ensure that the database is efficient, reduces data anomalies, and maintains data integrity by organizing the data into well-structured tables.

What is denormalization in SQL?
Denormalization in SQL is the process of intentionally introducing redundancy into a database by combining tables or adding duplicate data to improve read performance. While normalization focuses on reducing data redundancy and ensuring data integrity, denormalization aims to optimize query performance, especially in read-heavy applications where complex joins can slow down data retrieval.
Denormalization is typically used in scenarios where the performance of read operations is more critical than the efficiency of write operations. By reducing the number of joins required to retrieve data, denormalization can lead to faster query response times.
Here are some common techniques used in denormalization:
1. Combining Tables: Merging two or more related tables into a single table to eliminate the need for joins.
2. Adding Redundant Columns: Including additional columns in a table that duplicate data from related tables to speed up data access.
3. Precomputing Aggregates: Storing pre-calculated summary data (e.g., totals, averages) in a table to avoid recalculating them during queries.
4. Using Materialized Views: Creating materialized views that store the results of complex queries for faster access.
While denormalization can improve read performance, it also has some drawbacks, such as increased storage requirements, potential data inconsistencies, and more complex data maintenance. Therefore, it is essential to carefully evaluate the trade-offs before implementing denormalization in a database design.
