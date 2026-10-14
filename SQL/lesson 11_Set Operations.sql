--Set Operations
--=================================================
--Exercise 1: Combining Customer Data
--Management wants a single list 
--of unique customers, without duplicates.
/*
SELECT 
    customer_id,
    name 
FROM online_customers

UNION

SELECT 
    customer_id,
    name 
FROM store_customers
ORDER BY customer_id;
*/

--Module 15 — Exercise 2: UNION ALL
--Now management wants to see every 
--customer record from both systems, including duplicates.
/*
SELECT 
    customer_id,
    name 
FROM online_customers

UNION ALL

SELECT 
    customer_id,
    name 
FROM store_customers
ORDER BY customer_id ASC;
*/

--Exercise 3 — Find shared customers
--Management wants a report 
--identifying customers registered in both systems.

/*
SELECT 
    customer_id,
    name 
FROM online_customers

INTERSECT 

SELECT 
    customer_id,
    name 
FROM store_customers
ORDER BY customer_id DESC;
*/

--Exercise 4 — Identify missing customers
--Management now wants to identify 
--customers who are registered in physical stores
-- but not in the online system
/*
SELECT 
    customer_id,
    name 
FROM store_customers

EXCEPT

SELECT 
    customer_id,
    name 
FROM online_customers
ORDER BY customer_id ASC;
*/


--Combining Set Operations with CTEs
--Write a query using two CTEs:
--1. online_only — customers in online_customers but
-- not in store_customers.
--2. store_only — customers in store_customers 
--but not in online_customers.
--Then combine the results from both 
--CTEs using UNION and sort by customer_id ascending.
/*
WITH online_only AS (
SELECT 
    customer_id,
    name 
FROM online_customers

EXCEPT

  SELECT
   customer_id,
    name 
FROM store_customers
),

store_only AS (
  SELECT
  customer_id,
    name 
FROM store_customers

EXCEPT

SELECT 
    customer_id,
    name 
FROM online_customers
)

SELECT 
    customer_id,
    name 

FROM online_only
UNION ALL
SELECT 
    customer_id,
    name 
FROM store_only
ORDER BY customer_id ASC;
*/

--Final Challenge: Customer Reconciliation Report
--Create three CTEs:
--1. online_only — use EXCEPT to identify customers 
--only in the online system.
--2. store_only — use EXCEPT to identify customers 
--only in the store system.
--3. both_systems — use INTERSECT to identify customers 
--appearing in both systems.
--Then combine all three CTEs into one report 
--using UNION ALL.

With online_only AS (
SELECT
   customer_id,
    name
    
FROM    
    online_customers

EXCEPT

SELECT
   customer_id,
    name
    
FROM    
    store_customers
),


store_only AS (

SELECT
   customer_id,
    name
    
    
FROM    
    store_customers

EXCEPT

SELECT
   customer_id,
    name
    
FROM    
    online_customers
),



both_systems AS (
SELECT
   customer_id,
    name
    
FROM    
    online_customers

INTERSECT

SELECT
   customer_id,
    name
    
    
FROM    
    store_customers
)


SELECT 
    customer_id,
    name,
    'Online Only' AS registration_status

FROM online_only

UNION ALL 

SELECT 
    customer_id,
    name,
    'Store Only' AS registration_status

FROM store_only

UNION ALL

SELECT
    customer_id,
    name,
    'Both' AS registration_status


FROM
    both_systems
ORDER BY customer_id ASC;