--============================================
--PostgreSQL date/time data types

--First I need to delete a table Orders that exists
/*
DROP TABLE IF EXISTS orders;
*/

--Creating a new table for the exercise
/*
CREATE TABLE IF NOT EXISTS orders (
order_id INT GENERATED ALWAYS AS IDENTITY
(START WITH 100 iNCREMENT BY 1) 
PRIMARY KEY,
customer VARCHAR(10),
order_date DATE,
amount decimal(10,2)
);
*/


--Add values to the table
/*
INSERT INTO orders (customer,order_date,amount)
values
('Alan','2026-01-15',500),
('Maria','2026-01-28',800),
('Peter','2026-02-10',400),
('Alan','2026-02-22',700),
('Maria','2026-03-05',600);
*/

--from orders, where today should contain the current date.
/*
SELECT
    order_id,
    customer,
    order_date,
    CURRENT_DATE AS today


FROM 
    orders;
*/

--EXTRACT() year/month/day
/*
SELECT
    order_id,
    customer,
    order_date,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month

FROM
    orders;
*/

--Show all orders made in February 2026.
/*
SELECT
    order_id,
    customer,
    order_date,
    amount

FROM    
    orders
WHERE EXTRACT(YEAR FROM order_date) = 2026 
AND EXTRACT(MONTH FROM order_date) = 2;
*/


--Calculate total sales amount per month.
/*
SELECT
    DATE_TRUNC('month',order_date) AS months,
    SUM(amount)

FROM
    orders
GROUP BY months;
*/

--Date Arithmetic
--How many days did each order take to be delivered?
/*
SELECT
    order_id,
    order_date,
    delivery_date - order_date AS delivery_days


FROM
    orders;
    */

--INTERVAL
/*
SELECT 
    order_id,
    customer,
    order_date,
    amount

FROM
    orders

WHERE order_date>= CURRENT_DATE - INTERVAL '30 days';
*/

--date ranges.
--All orders made between 1 January 2026 and 31 March 2026.
/*
SELECT
    *

FROM orders
WHERE order_date BETWEEN '2026-01-01' AND '2026-03-31';
*/

--Dates + Window Functions

WITH monthly_sales AS (
        SELECT
            DATE_TRUNC('month',order_date) AS month,
            sum(amount) AS total_sales
            FROM orders
            GROUP BY month
)


SELECT 
    month,

    total_sales,

    LAG(total_sales) OVER (
    ORDER BY month) AS previous_month_sales,

    total_sales - LAG(total_sales) OVER (
    ORDER BY month) AS sales_change,

    (total_sales - LAG(total_sales) OVER (
    ORDER BY month))/ LAG(total_sales) OVER (
    ORDER BY month) * 100.0 AS percentage_change



FROM 
    monthly_sales;
        



