-- Select Statement

Select * From actor;
Select first_name From actor;
Select first_name,last_name From actor;

-- Select Distinct

Select Distinct release_year
From film

Select Distinct rental_rate
From film

-- Count & Where

Select Count(*)
 From payment
 
 Select Count(Distinct amount)
 From payment
 
 Select * From customer
Where first_name = 'Jared'

Select * From film
Where rental_rate > 4 AND replacement_cost >= 19.99
AND rating = 'R'

Select * From film
Where rating = 'R' OR rating = 'PG-13'

Select * From film
Where rating != 'R'

-- Order By & Limit

Select store_id, first_name, last_name
From customer
Order By store_id, first_name

Select *
From payment
Where amount != 0.00
Order By payment_date
Limit 10

-- Between & In

Select * From payment
Where payment_date Between '2007-02-01' And '2007-02-15'

Select Count(*) From payment
Where amount IN(0.99,1.98,1.99)

Select Count(*) From payment
Where amount NOT IN(0.99,1.98,1.99)

Select * From customer
Where first_name IN('John','Jake','Julie')

-- Like & ILike

Select * From customer
Where first_name Like 'J%' And last_name ILike 's%'

Select * From customer
Where first_name Like '_her%'

Select * From customer
Where first_name Like 'A%' And last_name Not Like 'B%'
Order By last_name

-- Aggregate Functions & Group By

Select Max(replacement_cost), Min(replacement_cost)
From film

Select Round(Avg(replacement_cost),2)
From film

Select Sum(replacement_cost)
From film

-- Having

Select customer_id,Sum(amount)
From payment
Group By customer_id
Having Sum(amount) > 100

Select store_id,Count(customer_id)
From customer
Group By store_id
Having Count(customer_id) > 300

-- JOINS

Select * 
From payment
Inner Join customer
ON payment.customer_id = customer.customer_id

Select payment_id,payment.customer_id,first_name 
From payment
Inner Join customer
ON payment.customer_id = customer.customer_id

Select *
From customer
Full Outer Join payment
ON customer.customer_id = payment.customer_id
Where customer.customer_id IS null OR payment.payment_id IS null

Select film.film_id,title,inventory_id,store_id
From film
Left Join inventory 
ON inventory.film_id = film.film_id
Where inventory.film_id IS null

-- Timestamp & Extract

Select NOW()
Select TIMEOFDAY()
Select CURRENT_TIME()
Select CURRENT_DATE()

Select Extract(YEAR FROM payment_date) as year
From payment

Select Age(payment_date)
From payment

Select TO_CHAR(payment_date, 'Month-YYYY')
From payment

Select TO_CHAR(payment_date, 'MM/dd/YYYY')
From payment

-- Mathematical Functions, String Functions & Operators

Select Round(rental_rate/replacement_cost,2)*100 AS percent_cost 
From film

Select 0.1 * replacement_cost AS deposit
From film

Select CONCAT(first_name,' ',last_name) AS full_name
From customer

Select first_name || ' ' || last_name AS full_name
From customer

Select LENGTH(first_name)
From customer

Select lower(left(first_name,1)) || lower(last_name) || '@gmail.com' AS employee_email
From customer

-- SubQueries

Select title, rental_rate
From film
Where rental_rate > (Select AVG(rental_rate) From film)

Select film_id, title
From film
Where film_id IN
(Select inventory.film_id
From rental
Inner Join inventory ON inventory.inventory_id = rental.inventory_id
Where return_date Between '2005-05-29' AND '2005-05-30')
Order By title

Select first_name, last_name
From customer AS c
Where Exists
(Select * From payment as p
Where p.customer_id = c.customer_id AND amount > 11)
 
-- Also can do Not Exists ^

-- Self Join

Select f1.title, f2.title, f1.length
From film AS f1
Inner Join film AS f2 ON
f1.film_id != f2.film_id
AND f1.length = f2.length

-- Create Table

Create Table account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
)

Create Table job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
)

Create Table account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
)

-- Insert & Update

Insert Into account(username,password,email,created_on)
Values 
('Jose','password','jose@gmail.com',CURRENT_TIMESTAMP),
('John','password123','john@gmail.com',CURRENT_TIMESTAMP)

Insert Into job(job_name)
Values
('Astronaut'),
('President')

Insert Into account_job(user_id,job_id,hire_date)
Values
(1,1,CURRENT_TIMESTAMP)
(3,1,CURRENT_TIMESTAMP)

Update account
SET last_login = CURRENT_TIMESTAMP

Update account_job
Set hire_date = account.created_on
From account
Where account_job.user_id = account.user_id

Update account
Set last_login = CURRENT_TIMESTAMP
RETURNING email,created_on,last_login

-- Delete

Insert Into job(job_name)
VALUES
('Cowboy')

Delete From job
Where job_name = 'Cowboy'
Returning job_id,job_name

Delete From account_job
Where user_id = 3

Delete From account
Where username = 'John'

-- Altar & Drop

Create Table information(
	info_id SERIAL PRIMARY KEY,
	title VARCHAR(500) NOT NULL,
	person VARCHAR(50) NOT NULL UNIQUE
)

Alter Table information
Rename To new_info

Alter Table new_info
Rename Column person TO people

Alter Table new_info
Alter Column people Drop NOT NULL   < -- Can also add by using SET

Alter Table new_info
Drop Column people

Alter Table new_info
Drop Column If Exists people

-- Check

Create Table employees(
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birthdate DATE CHECK (birthdate > '1900-01-01'),
	hire_date DATE Check (hire_date > birthdate),
	salary INTEGER Check (salary > 0)
)

-- Case

Select customer_id,
CASE 
	When (customer_id <= 100) THEN 'Premium'
	When (customer_id BETWEEN 100 and 200) THEN 'Plus'
	ELSE 'Normal'
END AS customer_class
From customer

Select customer_id,
CASE customer_id
	When 2 Then 'Winner'
	When 5 Then 'Second Place'
	Else 'Normal'
END AS raffle_results
From customer

Select 
SUM(CASE rental_rate
	When 0.99 Then 1
	Else 0
END) AS bargains,
SUM(CASE rental_rate
   	When 2.99 Then 1
   	Else 0
END) as regular,
SUM(CASE rental_rate
   	When 4.99 Then 1
   	Else 0
END) as premium
From film

-- Cast & NULLIF

Select Cast('5' AS INTEGER)

Select '5'::INTEGER

Select CHAR_LENGTH(Cast(inventory_id AS VARCHAR))
From rental


Create Table depts(
first_name VARCHAR(50),
department VARCHAR(50)
)

Insert Into depts(
first_name,
department
)
VALUES
('Vinton', 'A'),
('Lauren','A'),
('Claire', 'B')

Select (
SUM(CASE When department = 'A' Then 1 Else 0 END)/
SUM(CASE When department = 'B' Then 1 Else 0 End)
) AS department_ratio
From depts

DELETE From depts
Where department = 'B'

Select (
SUM(CASE When department = 'A' Then 1 Else 0 END)/
NULLIF(SUM(CASE When department = 'B' Then 1 Else 0 End),0)
) AS department_ratio
From depts

-- Views

Create View customer_info AS
Select first_name,last_name,address
From customer
Inner Join address
ON customer.address_id = address.address_id

Select * From customer_info

Create OR Replace View customer_info AS
Select first_name,last_name,address,district
From customer
Inner Join address
ON customer.address_id = address.address_id

Drop View If Exists customer_info

Alter View customer_info Rename To c_info

-- Importing & Exporting

Create Table simple(
a INTEGER,
b INTEGER,
c INTEGER
)

Select * From simple

