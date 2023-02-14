
-- Basic Functions Learned in Google Data Analytics Certificate

-- Where, Count, Order By

Select *
From
	movie_data.movies
Where
	Genre = "Comedy" AND
	Release_Date = '2013-12-31'

Select 
	Movie_Title,
	Release_Date,
	Genre
From
	movie_data.movies
Where
	Genre = "Comedy" AND
	Release_Date = '2013-12-31'

Select 
	Count(Genre)
From 
	movie_data.movies
Where
	Genre = "Crime"


Select *
From movie_data.movies
Order By Release_Date DESC


Select *
From movie_data.movies
Where Genre = "Comedy"
AND Revenue > 300000000
Order By Release_Date DESC


-- CONCAT & JOIN

Select
	usertype,
	CONCAT(start_station_name, " to ", end_station_name) as route
	Count(*) as num_trips
	Round(AVG(cast(tripduration as int)/60),2) as duration
From 
	new_york_citibike.citibike_trips
Group By
	start_station_name, end_station_name, usertype
Order By
	num_trips DESC
LIMIT 10


Select
	employees.name as employee_name,
	employees.role as employee_role,
	departments.name as department_name
From employee_data.employees
Inner Join
	employee_data.departments on 
	employees.department_id = departments.department_id


Select
	employees.name as employee_name,
	employees.role as employee_role,
	departments.name as department_name
From employee_data.employees
Left Join
	employee_data.departments on 
	employees.department_id = departments.department_id


Select
	employees.name as employee_name,
	employees.role as employee_role,
	departments.name as department_name
From employee_data.employees
Right Join
	employee_data.departments on 
	employees.department_id = departments.department_id


Select
	employees.name as employee_name,
	employees.role as employee_role,
	departments.name as department_name
From employee_data.employees
Full Outer Join
	employee_data.departments on 
	employees.department_id = departments.department_id


-- Count and Union

Select
	warehouse.state as state,
	COUNT(DISTINCT order_id) as num_orders
From warehouse_orders.Orders orders
JOIN
	warehouse_orders.Warehouse warehouse ON orders.warehouse_id = warehouse.warehouse_id
Group By
	warehouse.state


Select *
From bicycle-case-study-375818.1.12-2021
UNION ALL
From bicycle-case-study-375818.1.12-2022
UNION ALL
From bicycle-case-study-375818.1.12-2023




-- Sub Queries & Having

Select
	station_id,
	num_bikes_available,
	(Select
		AVG(num_bikes_available)
	From new_york_citibike.citibike_stations) as avg_num_bikes_available
From
	new_york_citibike.citibike_stations



Select
	station_id,
	name,
	number_of_rides as number_of_rides_starting_at_station
From
	(
		Select 
			start_station_id,
			Count(*) number_of_rides
		From
			new_york_citibike.citibike_trips
		Group By 
			start_station_id
	)
	AS station_num_trips
	Inner Join
		new_york_citibike.citibike_stations ON station_id = start_station_id
	Order By
		number_of_rides desc



Select
	station_id,
	name
From
	new_york_citibike.citibike_stations
Where 
	station_id IN
	(
		Select 
			start_station_id,
		From
			new_york_citibike.citibike_trips
		Where
			usertype = 'Subscriber'
	)



Select
	Warehouse.warehouse_id,
	CONCAT(state, ': ', Warehouse.warehouse_alias) as warehouse_name,
	Count(Orders.order_id) as number_of_orders,
	(Select
		Count(*)
	From warehouse_orders.Orders as Orders)
	AS total_orders,
	Case
		When Count(Orders.order_id)/(Select Count(*) From warehouse_orders.Orders as Orders) <= 0.20
		Then "fulfilled 0-20% of orders"
		When Count(Orders.order_id)/(Select Count(*) From warehouse_orders.Orders as Orders) > 0.20
		and Count(Orders.order_id)/(Select Count(*) From warehouse_orders.Orders as Orders) <= 0.60
		Then "fulfilled 21-60% of orders"
	Else "fulfilled more than 60% of orders"
	End as fulfillment_summary

From warehouse_orders.Warehouse as Warehouse
Left Join warehouse_orders.Orders as Orders
	ON Orders.warehouse_id = warehouse.warehouse_id
Group By 
	warehouse.warehouse_id
	warehouse_name
Having
	Count (Orders.order_id) > 0



-- Calculations Using SQL

Select 
	Date,
	Region,
	Small_Bags,
	Large_Bags,
	XLarge_Bags,
	Total_Bags,
	Small_Bags + Large_Bags, XLarge_Bags as Total_Bags_Calc
From
	avacado_data.avacado_prices


Select 
	Date,
	Region,
	Small_Bags,
	Large_Bags,
	XLarge_Bags,
	Total_Bags,
	(Small_Bags / Total_Bags)*100 AS Small_Bags_Percent
From
	avacado_data.avacado_prices
Where 
	Total_Bags <> 0


Select 
	Date,
	Region,
	Small_Bags,
	Large_Bags,
	XLarge_Bags,
	Total_Bags,
	SAFE_DIVIDE(Small_Bags, Total Bags)*100 AS Small_Bag_Precent
From
	avacado_data.avacado_prices


Select
	invoice_line_id,
	invoice_id,
	unit_price,
	quantity,
	unit_price + quantity AS line_total
From invoice_item
Limit 5



-- Extract 

Select
	Extract(YEAR from STARTTIME) as year,
	Count(*) AS number_of_rides
From
	new_york_citibike.citibike_trips
Group by year
Order by year desc



Select
	Extract(Year from date) as Year,
	Round(SUM(UnitPrice * Quantity),2) as Revenue
From sales.sales_info
Group By year
Order by year desc


-- Temp Table

WITH trips_over_1_hr AS
	(Select *
	From new_york_citibike.citibike_trips
	Where	
		tripduration >= 60
	)


Select 
	Count(*) as cnt
	From
		trips_over_1_hr