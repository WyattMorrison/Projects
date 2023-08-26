
-- CLEANING FUNCTIONS & FORMULAS

-- Insert Into & Update

Insert Into customer_data.customer_address
	(customer_id, address, city, state, zipcode, country)
Values
	(2645, '333 SQL Road', 'Jackson', 'MI', 49202, 'US')

Update customer_data.customer_address
Set address = '123 New Address'
Where customer_id = 2645

-- Length, SUBSTRING, & Trim

Select Length(country) as letters_in_country
From customer_data.customer_address

Select country
From customer_data.customer_address
Where Length(country) > 2

Select DISTINCT customer_id
From customer_data.customer_address
Where SUBSTRING(country, 1, 2) = 'US'

Select DISTINCT customer_id
From customer_data.customer_address
Where TRIM(state) = 'OH'


-- CAST & BETWEEN

Select Cast(purchase_price as FLOAT64)
From customer_data.customer_purchase
Order by Cast(purchase_price as FLOAT64) DESC

Select date,
       purchase_price
From customer_data.customer_purchase
Where date BETWEEN '2020-12-01' AND '2020-12-31'

Select CAST(date as date) as date_only,
	purchase_price
From customer_data.customer_purchase
Where date BETWEEN '2020-12-01' AND '2020-12-31'


-- CONCAT & COALESCE

Select CONCAT(product_code, product_color) as new_product_code
From customer_data.customer_purchase
Where product = 'couch'


Select CONCAT(first_name, ' ', COALESCE(middle_name, ''), ' ', last_name)
From student;


Select Movie_Title,
       Release_date,
       Genre,
       CONCAT(Director__1_, ": ", COALESCE(Director__2_, '')) AS director_1_and_2
From movie_data.movies


-- CASE

Select customer_id,
	CASE When first_name = 'Tnoy' THEN 'Tony'
	     ELSE first_name
	     END AS cleaned_name
From customer_data.customer_name


Select customer_id,
	CASE When first_name = 'Tnoy' THEN 'Tony'
	     When first_name = 'Tmo' THEN 'Tom'
	     When first_name = 'Rachle' THEN 'Rachel'
	     ELSE first_name
	     END AS cleaned_name
From customer_data.customer_name



Select CASE When name = 'Aav' THEN 'Ava'
	    When name = 'Brooklyn' THEN 'Brook'
	    ELSE name
	    END AS cleaned_name,
	gender,
	count
From babynames.names_2010
LIMIT 1000


Select *,
	CASE When Director__2_ IS NULL Then 1
	     ELSE 0
	     END
From movie_data.movies
Order by Movie_Title


-- COALESCE & CASE

Select Movie_Title,
       Release_Date,
       Genre,
       Director__1_,
       COALESCE(Director__2_) as Director_2
From movie_data.movies
Order by
	CASE WHEN Director_2 IS NULL Then 1
	ELSE 0
	END


-- String_AGG

Select String_AGG(Director__2_, ", ")
From movie_data.movies

