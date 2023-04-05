-- We want to send out a promotional email to our existing customers.

Select first_name, last_name, email
From customer;

-- An Australian visitor isn't familiar with MPAA movie ratings (eg. PG, PG-13, R, etc...)
	-- We want to know the types of ratings we have in our databse.
  
Select Distinct rating
From film

-- A customer forgot their wallet at our store. We need to track down their email to inform them.
	-- What is the email for the customer with the name Nancy Thomas.
	
Select first_name, last_name, email
From customer
Where first_name = 'Nancy' AND last_name = 'Thomas'

-- A customer wants to know what the movie Outlaw Hanky is about.
	-- Could you give them the description for the movie Outlaw Hanky?
	
Select description
From film
Where title = 'Outlaw Hanky'

-- A customer is late on their movie return and we've mailed them a letter to their address at 259 Ipoh Drive.
-- We should also call them on the phone to let them know.
	-- Can you get the phone number for the customer who lives at 259 Ipoh Drive
	
Select phone
From address
Where address = '259 Ipoh Drive'

-- We want to reward pur first 10 paying customers. What are the customer ids of the first customers who created a payment?

Select customer_id From payment
Order By payment_date ASC
Limit 10

-- A customer wants to quickly rent a video to watch over their short lunch break.
-- What are the titles of the 5 shortest (in length of runtime) movies?

Select title, length From film
Order By length ASC
Limit 5

-- If the previous customer can watch any movie that is 50 minutes or less in runtime, how many options does she have?

Select Count(title)
From film
Where length <= 50

-- GENERAL CHALLENGE 1 --

-- How many payment transactions were greater than $5.00?
Select Count(*)
From payment
Where amount > 5.00

-- How many actors have a first name that start with the letter P?
Select Count(*)
From actor
Where first_name Like 'P%'

-- How many unique districts are our customers from?
Select Count (Distinct district)
From address

-- Retrieve the list of names for those distinct districts from the previous question.
Select Distinct district
From address

-- How many films have a rating of R and a replacement cost between $5 and $15?
Select Count(*)
From film
Where rating = 'R' And replacement_cost Between 5 And 15

-- How many films have the word Truman somewhere in the title?
Select Count(*)
From film
Where title Like '%Truman%'

-- END OF GENERAL CHALLENGE 1 --

-- We have two staff members, witth Staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments. (Number of payments processed)
-- How many payments did each staff member handle and who gets the bonus?
Select staff_id, Count(amount)
From payment
Group By staff_id
Order By Count(amount) DESC

-- Corporate HQ is conducting a study on the relationship between replacement cost and a movie MPAA rating.
-- What is the average replacement cost per MPAA rating?
Select rating, Round(Avg(replacement_cost),2) as "AVG Replacement Cost"
From film
Group By rating
Order By "AVG Replacement Cost" DESC

-- We are running a promotion to reward our top 5 customers with coupons.
-- What are the customer ids of the top 5 customers by total spend?
Select customer_id, Sum(amount)
From payment
Group By customer_id
Order By Sum(amount) DESC
Limit 5

-- We are launching a platinum service for our most loyal customers. We will assign platinum status to customers that have had 40 or more transaction payments.
-- What customer ids are eligible for platinum status?
Select customer_id, Count(amount)
From payment
Group By customer_id
Having Count(amount) >= 40

-- What are the customer ids of customers who have spent more than $100 in payment transactions with our staff_id member 2?
Select customer_id, Sum(amount)
From payment
Where staff_id = 2
Group By customer_id
Having Sum(amount) > 100

-- ASSESSMENT TEST 1 --

-- Return the customer IDs of the customers who have spent at least $110 with the staff member who has an ID of 2.
Select customer_id, Sum(amount)
From payment
Where staff_id = 2
Group By customer_id
Having Sum(amount) >= 110

-- How many films begin with the letter J?
Select Count(title)
From film
Where title Like 'J%'

-- What customer has the highest customer ID number whose name starts with an E and has an address ID lower than 500?
Select first_name, last_name
From customer
Where first_name Like 'E%' And address_id < 500
Order By customer_id DESC
Limit 1

-- END OF ASSESSMENT TEST 1 --

-- California sales tax laws have changed and we need to alert our customers to this through email.
-- What are the emails of the customers who live in California?
Select district,email 
From address
Inner Join customer
ON customer.address_id = address.address_id
Where address.district = 'California'

-- A customer walks in and is a huge fan of the actor "Nick Wahlberg" and wants to know which movies he is in.
-- Get a list of all movies "Nick Wahlberg" has been in.
Select title,first_name,last_name
From film_actor
Inner Join actor
On film_actor.actor_id = actor.actor_id
Inner Join film
On film_actor.film_id = film.film_id
Where first_name = 'Nick' AND last_name = 'Wahlberg'

-- During which months did payments occur?
-- Format your answer to return back the full month name.
Select Distinct(TO_CHAR(payment_date, 'Month'))
From payment

-- How many payments occurred on a Monday?
Select Count(*)
From payment
Where Extract(dow from payment_date) = 1

-- ASSESSMENT TEST 2 --

-- How can you rettrieve all the informattion from the cd.facilities table?
Select *
From cd.facilities

-- You want to print out a list of all of the facilities and their cost to members. How would you retrieve a list of only facility names and costs?
Select name, membercost
From cd.facilities

-- How can you produce a list of facilities that charge a fee to members?
Select *
From cd.facilities
Where membercost > 0

-- How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost?
-- Return the facid, facility name, member cost, and monthly maintenance of the facilities in question. 
Select facid, name, membercost, monthlymaintenance
From cd.facilities
Where membercost > 0 AND (membercost < monthlymaintenance/50.0)

-- How can you produce a list of all facilities with the word 'Tennis' in their name?
Select *
From cd.facilities
Where name LIKE '%Tennis%'

-- How can you retrieve the details of facilities with ID1 and 5? Try to do it without using the OR operator.
Select *
From cd.facilities
Where facid = 1 OR facid = 5

Select *
From cd.facilities
Where facid IN (1,5)


-- How can you produce a listt of members who joined after the start of September 2012? 
-- Return the memid, surname, firstname, and joindatte of the members in question.
Select memid, surname, firstname, joindate
From cd.members
Where joindate >= '2012-09-01'

-- How can you produce an ordered list of the first 10 surnames in the members table? This list mustt not contain any duplicates.
Select Distinct(surname)
From cd.members
Order By surname
Limit 10

-- You'd like to get the signup date of your last member. How can you retrieve this information.
Select joindate
From cd.members
Order By joindate DESC
Limit 1

Select MAX(joindate) AS latest_signup
From cd.members


-- Produce a count of the number of facilities that have a cost to guests of 10 or more.
Select Count(*)
From cd.facilities 
Where guestcost >= 10

-- Produce a list of the total number of slots booked per facility in the month of September 2012. 
-- Produce an output table consisting of facility id and slots, sorted by the number of slots.
Select cd.bookings.facid, SUM(cd.bookings.slots) as Total_Slots
From cd.bookings
Inner Join cd.facilities
ON cd.facilities.facid = cd.bookings.facid
Where Extract(Month from starttime) = 9
Group By cd.bookings.facid

Select facid, SUM(slots) as Total_Slots
From cd.bookings
Where starttime >= '2012-09-01' AND starttime < '2012-10-01'
Group By facid
Order By SUM(slots)

-- Produce a list of facilities with more than 1000 slots booked.
-- Produce an output table consisting of facility id and total slots, sorted by facility id.
Select cd.bookings.facid, SUM(cd.bookings.slots) as Total_Slots
From cd.bookings
Inner Join cd.facilities
ON cd.facilities.facid = cd.bookings.facid
Group By cd.bookings.facid
Having Sum(cd.bookings.slots) > 1000

Select facid, SUM(slots) as Total_Slots
From cd.bookings
Group By facid
HAVING SUM(slots) > 1000
Order By facid

-- How can you produce a list of the start times for bookings for tennis courts for the date'2012-09-21'?
-- Return a list of start ttime and facility name pairings, ordered by time.
Select cd.bookings.starttime AS start, cd.facilities.name AS name
From cd.facilities
Inner Join cd.bookings 
ON cd.bookings.facid = cd.facilities.facid
Where Date(starttime) = '2012-09-21' AND name LIKE 'Tennis Court _'
Order By starttime

Select cd.bookings.starttime AS start, cd.facilities.name AS name
From cd.facilities
Inner Join cd.bookings 
ON cd.bookings.facid = cd.facilities.facid
Where cd.facilities.facid IN (0,1)
AND cd.bookings.starttime >= '2012-09-21'
AND cd.bookings.starttime < '2012-09-22'
Order By cd.bookings.starttime

-- How can you produce a list of the start times for bookings by members named 'David Farrell'?
Select cd.bookings.starttime
From cd.bookings
Inner Join cd.members
ON cd.members.memid = cd.bookings.memid
Where cd.members.firstname = 'David' AND cd.members.surname = 'Farrell'

-- END OF ASSESSMENT TEST 2 --

-- ASSESSMENT TEST 3 --

-- Create a new database called "School" this database should have two tables: teachers and students.
-- The students table should have columns for student_id, first_name,last_name, homeroom_number, phone,email, and graduation year.
-- The teachers table should have columns for teacher_id, first_name, last_name,homeroom_number, department, email, and phone.
-- The constraints are mostly up to you, but your table constraints do have to consider the following:
   -- We must have a phone number to contact students in case of an emergency.
   -- We must have ids as the primary key of the tables and phone numbers and emails must be unique to the individual.
-- Once you've made the tables, insert a student named Mark Watney (student_id=1) who has a phone number of 777-555-1234 and doesn't have an email. He graduates in 2035 and has 5 as a homeroom number.
-- Then insert a teacher names Jonas Salk (teacher_id = 1) who as a homeroom number of 5 and is from the Biology department. His contact info is: jsalk@school.org and a phone number of 777-555-4321.

Create Table students(
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	homeroom_number integer,
	phone VARCHAR(50) NOT NULL UNIQUE,
	email VARCHAR(100) NOT NULL UNIQUE,
	graduation_year integer
)

Create Table teachers(
	teacher_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	homeroom_number integer,
	department VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	phone VARCHAR(50) NOT NULL UNIQUE
)

Alter Table students
Alter Column email DROP NOT NULL

Insert Into students(
	first_name,
	last_name,
	phone,
	graduation_year,
	homeroom_number
)
VALUES (
	'Mark',
	'Watney',
	'777-555-1234',
	'2035',
	'5'
)

Insert Into teachers(
	first_name,
	last_name,
	homeroom_number,
	department,
	email,
	phone
)
VALUES(
	'Jonas',
	'Salk',
	'5',
	'Biology',
	'jsalk@school.org',
	'777-555-4321'
)

-- END OF ASSESSMENT 3 --

-- We want to know and compare the various amounts of films we have per movie rating.
-- Use CASE and the dvdrental database.

Select 
SUM(CASE
   	When rating = 'R' Then 1
   	Else 0
END) AS R,
SUM(CASE
   	When rating = 'PG' Then 1
   	Else 0
END) AS PG,
SUM(CASE
   	When rating = 'PG-13' Then 1
   	Else 0
END) AS PG13
From film

