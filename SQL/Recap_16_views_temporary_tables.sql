
-- ============================================================
-- ANALYTICS ENGINEER ACADEMY
-- MODULE 16: VIEWS AND TEMPORARY TABLES
-- Database: PostgreSQL
-- ============================================================

-- PREREQUISITE:
-- The customer_sales table must already exist with:
-- customer_id, customer_name, total_spent, total_orders


-- ============================================================
-- LESSON 1: CREATE VIEW
-- ============================================================

-- A standard VIEW saves a SQL query definition.
-- It does not store a separate copy of the result rows.

CREATE OR REPLACE VIEW customer_spending_summary AS
SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    ROUND(
        total_spent::NUMERIC / NULLIF(total_orders, 0),
        2
    ) AS average_order_value
FROM customer_sales;


-- ============================================================
-- LESSON 2: QUERYING VIEWS
-- ============================================================

-- Display all records.

SELECT *
FROM customer_spending_summary;


-- Find customers whose average order value exceeds 500.

SELECT
    customer_id,
    customer_name,
    average_order_value
FROM customer_spending_summary
WHERE average_order_value > 500
ORDER BY average_order_value DESC;


-- ============================================================
-- LESSON 3: AGGREGATING DATA FROM VIEWS
-- ============================================================

SELECT
    COUNT(customer_id) AS total_customers,
    SUM(total_spent) AS total_revenue,
    ROUND(AVG(total_spent), 2) AS average_customer_spending,
    MAX(average_order_value) AS highest_order_value
FROM customer_spending_summary;


-- ============================================================
-- LESSON 4: CREATE OR REPLACE VIEW
-- ============================================================

-- Add spending_category to the existing view.
-- PostgreSQL requires existing view columns to retain
-- their names, order, and data types.
-- New columns can be appended at the end.

CREATE OR REPLACE VIEW customer_spending_summary AS
SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    ROUND(
        total_spent::NUMERIC / NULLIF(total_orders, 0),
        2
    ) AS average_order_value,
    CASE
        WHEN total_spent >= 3000 THEN 'High Spender'
        WHEN total_spent >= 1000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS spending_category
FROM customer_sales;


-- Verify the updated view.

SELECT *
FROM customer_spending_summary;


-- ============================================================
-- LESSON 5: TEMPORARY TABLES
-- ============================================================

-- Temporary tables store rows within the current
-- PostgreSQL database session.
-- They are automatically removed when that session ends.

DROP TABLE IF EXISTS pg_temp.medium_spending_customers;

CREATE TEMP TABLE medium_spending_customers AS
SELECT
    customer_id,
    customer_name,
    total_spent,
    average_order_value
FROM customer_spending_summary
WHERE spending_category = 'Medium Spender';


-- Query the temporary table in the same session.

SELECT *
FROM medium_spending_customers;


-- ============================================================
-- LESSON 6: CTE VS VIEW VS TEMPORARY TABLE
-- ============================================================

-- OPTION A: CTE
-- Useful for organising a single SQL statement.

WITH high_spenders AS (
    SELECT *
    FROM customer_spending_summary
    WHERE total_spent >= 3000
)
SELECT *
FROM high_spenders;


-- OPTION B: VIEW
-- Useful for reusable reporting logic across sessions.

CREATE OR REPLACE VIEW high_spenders_view AS
SELECT *
FROM customer_spending_summary
WHERE total_spent >= 3000;


SELECT *
FROM high_spenders_view;


-- OPTION C: TEMPORARY TABLE
-- Useful for intermediate datasets in one session.

DROP TABLE IF EXISTS pg_temp.high_spenders_temp;

CREATE TEMP TABLE high_spenders_temp AS
SELECT *
FROM customer_spending_summary
WHERE total_spent >= 3000;


SELECT *
FROM high_spenders_temp;


-- ============================================================
-- FINAL CHALLENGE: CUSTOMER REPORTING LAYER
-- ============================================================

-- PART 1: CREATE A REPORTING VIEW

CREATE OR REPLACE VIEW customer_reporting AS
SELECT
    customer_id,
    customer_name,
    total_spent,
    average_order_value,
    spending_category
FROM customer_spending_summary;


-- PART 2: CREATE A TEMPORARY TABLE

DROP TABLE IF EXISTS pg_temp.high_value_customers;

CREATE TEMP TABLE high_value_customers AS
SELECT
    customer_id,
    customer_name,
    total_spent,
    average_order_value,
    spending_category
FROM customer_reporting
WHERE spending_category = 'High Spender';


-- PART 3: MANAGEMENT SUMMARY

SELECT
    COUNT(customer_id) AS total_high_value_customers,
    SUM(total_spent) AS total_high_value_revenue,
    ROUND(AVG(total_spent), 2) AS average_high_value_spending
FROM high_value_customers;


-- ============================================================
-- KEY TAKEAWAYS
-- ============================================================

-- 1. CREATE VIEW defines a reusable SQL query.
--
-- 2. CREATE OR REPLACE VIEW updates an existing
--    view definition without modifying source data.
--
-- 3. A standard view does not store its result rows.
--
-- 4. CREATE TEMP TABLE stores an intermediate dataset
--    for the current database session.
--
-- 5. Temporary tables do not automatically reflect
--    subsequent changes in their source tables.
--
-- 6. CTEs organise logic within one SQL statement.
--
-- 7. Views provide reusable business logic.
--
-- 8. Temporary tables support intermediate processing.
--
-- 9. Views can be used as sources for other views
--    and temporary tables.
--
-- 10. Querying temporary tables requires the same
--     database session in which they were created.
--
-- ============================================================
-- END OF MODULE 16
-- ============================================================
