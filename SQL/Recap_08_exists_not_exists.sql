-- =====================================================
-- ANALYTICS ENGINEER ACADEMY
-- Topic: EXISTS and NOT EXISTS
-- =====================================================


-- EXISTS asks:
-- "Does at least ONE matching row exist?"
--
-- 0 matching rows  -> FALSE
-- 1+ matching rows -> TRUE


-- =====================================================
-- 1. CUSTOMERS WHO HAVE AT LEAST ONE ORDER
-- =====================================================

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- The inner query is correlated with the outer query.
--
-- For customer_id = 3, SQL effectively checks:
--
-- Is there at least one order where customer_id = 3?
--
-- It does NOT matter whether there are:
--
-- 1 order
-- 2 orders
-- 100 orders
--
-- EXISTS only cares whether at least one row exists.


-- =====================================================
-- 2. WHY SELECT 1?
-- =====================================================

-- SELECT 1 does NOT count rows.
--
-- It simply returns the literal value 1 for every
-- matching row.
--
-- EXISTS does not care about the value being selected.
--
-- These can all work:
--
-- SELECT 1
-- SELECT customer_id
-- SELECT *
--
-- SELECT 1 is commonly used because it communicates:
--
-- "I only care whether a row exists."


-- =====================================================
-- 3. CUSTOMERS WHO HAVE NEVER PLACED AN ORDER
-- =====================================================

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- NOT EXISTS asks:
--
-- "Are there ZERO matching rows?"
--
-- 0 matching rows  -> TRUE
-- 1+ matching rows -> FALSE


-- =====================================================
-- 4. IN VS EXISTS
-- =====================================================

-- IN cares about the VALUES returned by the subquery.

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM orders o
);


-- EXISTS cares about whether a matching ROW exists.

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- Mental model:
--
-- IN
-- -> "Is my value among these returned values?"
--
-- EXISTS
-- -> "Does at least one matching row exist?"


-- =====================================================
-- 5. THE NOT IN + NULL PROBLEM
-- =====================================================

-- Imagine the subquery returns:
--
-- 1
-- 3
-- NULL
--
-- This can be dangerous:

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE c.customer_id NOT IN (
    SELECT o.customer_id
    FROM orders o
);


-- For customer_id = 2, SQL conceptually encounters:
--
-- 2 <> 1      -> TRUE
-- 2 <> 3      -> TRUE
-- 2 <> NULL   -> UNKNOWN
--
-- Because NULL means unknown, the overall condition
-- may become UNKNOWN.
--
-- WHERE only keeps TRUE rows.
--
-- This means NOT IN can unexpectedly return no rows
-- when NULL exists in the subquery result.


-- =====================================================
-- 6. SAFER ANTI-JOIN PATTERN
-- =====================================================

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- NOT EXISTS is commonly used for questions such as:
--
-- Customers with no orders
-- Employees with no projects
-- Products with no sales
-- Students with no exams
-- Accounts with no transactions


-- =====================================================
-- KEY RULE
-- =====================================================

-- EXISTS
-- -> Does a related row exist?
--
-- NOT EXISTS
-- -> Does NO related row exist?
--
-- NOT IN
-- -> Be careful when the subquery can contain NULL.