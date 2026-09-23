-- =====================================================
-- ANALYTICS ENGINEER ACADEMY
-- Topic: Subqueries, IN and NOT IN
-- =====================================================


-- A subquery is a query inside another query.


-- =====================================================
-- 1. SCALAR SUBQUERY
-- =====================================================

-- Find employees earning above the company average.

SELECT
    employee,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


-- The inner query returns ONE value:
--
-- SELECT AVG(salary)
--
-- Example:
-- 90000
--
-- The outer query then compares each salary with it.


-- =====================================================
-- 2. MAX() IN A SUBQUERY
-- =====================================================

-- Find employees earning more than the highest
-- salary in HR.

SELECT
    employee,
    salary
FROM employees
WHERE salary > (
    SELECT MAX(salary)
    FROM employees
    WHERE department = 'HR'
);


-- Find employees whose salary is exactly equal
-- to the highest salary in HR.

SELECT
    employee,
    salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department = 'HR'
);


-- =====================================================
-- 3. MULTI-ROW SUBQUERY WITH IN
-- =====================================================

-- Find customers who have placed an order.

SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);


-- The inner query may return:
--
-- 1
-- 3
-- 3
--
-- IN asks:
--
-- "Is this value among the values returned?"


-- =====================================================
-- 4. NOT IN
-- =====================================================

-- Find customers whose IDs do not appear in orders.

SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);


-- IMPORTANT:
--
-- NOT IN can behave unexpectedly when the subquery
-- contains NULL.
--
-- We will cover the safer NOT EXISTS pattern in:
--
-- 08_exists_not_exists.sql


-- =====================================================
-- CHOOSING THE OPERATOR
-- =====================================================

-- Before choosing =, >, <, IN, etc., ask:
--
-- 1. What does the inner query return?
-- 2. What does the business question want me to do
--    with that result?


-- Examples:
--
-- salary > (one average)
-- -> >
--
-- salary = (one maximum)
-- -> =
--
-- customer_id IN (many customer IDs)
-- -> IN


-- =====================================================
-- MENTAL MODEL
-- =====================================================

-- Scalar subquery:
--
-- Outer query
--      ↓
-- compare against
--      ↓
-- one value produced by inner query


-- Multi-row subquery:
--
-- Outer value
--      ↓
-- compare against
--      ↓
-- a set of values produced by inner query