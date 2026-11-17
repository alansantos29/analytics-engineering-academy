--Views and Temporary Tables
--====================================
--Exercise 1 — Create your first SQL View
/*
CREATE OR REPLACE VIEW customer_spending_summary AS

SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    ROUND(total_spent::NUMERIC/NULLIF(total_orders,0),2) AS average_order_value


FROM 
    customer_sales;
*/



--Delete View
    --DROP VIEW customer_spending_summary;


--Exercise 2 — Filtering a View
/*
SELECT  
    customer_id,
    customer_name,
    average_order_value
FROM    
    customer_spending_summary
WHERE average_order_value > 500
ORDER BY average_order_value DESC;
*/


--Exercise 3 — Customer Performance Summary
/*
SELECT 
    Count(customer_id) AS total_customers,
    SUM(total_spent) AS total_revenue,
    Round(avg(total_spent),2) AS average_customer_spending,
    MAX(average_order_value) AS highest_order_value




FROM 
    customer_spending_summary;
*/


--Lesson 4 — Updating SQL Views
/*
CREATE OR REPLACE VIEW customer_spending_summary AS

SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    ROUND(total_spent::NUMERIC/NULLIF(total_orders,0),2) AS average_order_value,
    CASE
        WHEN total_spent >=3000 then 'High Spender'
        WHEN total_spent >=1000 then 'Medium Spender'
        Else 'Low Spender'
    END AS spending_category

FROM 
    customer_sales;
*/

--Lesson 5: Temporary Tables
-- create a temporary table named 
--medium_spending_customers using the 
--customer_spending_summary view.
/*

CREATE TEMP TABLE medium_spending_customers AS

SELECT
    customer_id,
    customer_name,
    total_spent,
    average_order_value

FROM customer_spending_summary
WHERE spending_category = 'Medium Spender';


--Display the TEMP table
SELECT *
FROM medium_spending_customers;
*/

--Module 16 — Final Challenge: Customer Reporting Layer
--Part 1 — Create a reporting View
/*CREATE OR REPLACE VIEW customer_reporting AS

Select 
    customer_id,
    customer_name,
    total_spent,
    average_order_value,
    spending_category

FROM
    customer_spending_summary;
    */

--Part 2 — Create a Temporary Table

CREATE TEMP TABLE high_value_customers AS 

Select 
    customer_id,
    customer_name,
    total_spent,
    average_order_value,
    spending_category

FROM
    customer_reporting
WHERE
    spending_category = 'High Spender';
    

--Part 3 — Management Summary
SELECT
    count(customer_id) AS total_high_value_customers,
    sum(total_spent) AS total_high_value_revenue,
    ROUND(AVG(total_spent),2) AS average_high_value_spending


FROM  
    high_value_customers;




