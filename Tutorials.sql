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


-- FUNCTIONS in MySQL - These are routines in MySQL which accepts input values and perform some operation and return a single value. They are similar to functions in programming languages. They return a value and cannot modify data.
