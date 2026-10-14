
-- =====================================================
-- MODULE 15: SQL SET OPERATIONS
-- Analytics Engineer Academy
-- Database: PostgreSQL
-- =====================================================

-- TABLES USED:
-- online_customers(customer_id, name)
-- store_customers(customer_id, name)


-- =====================================================
-- 1. UNION
-- =====================================================
-- Combines query results and removes duplicate rows.
-- Duplicate detection considers all selected columns.

SELECT
    customer_id,
    name
FROM online_customers

UNION

SELECT
    customer_id,
    name
FROM store_customers

ORDER BY customer_id ASC;


-- =====================================================
-- 2. UNION ALL
-- =====================================================
-- Combines query results and preserves duplicates.
-- Usually more efficient than UNION.

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


-- =====================================================
-- 3. INTERSECT
-- =====================================================
-- Returns rows appearing in both query results.

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


-- =====================================================
-- 4. EXCEPT
-- =====================================================
-- Returns rows from the first query that do not
-- appear in the second query.
-- The order of the queries matters.

-- Customers registered online but not in stores

SELECT
    customer_id,
    name
FROM online_customers

EXCEPT

SELECT
    customer_id,
    name
FROM store_customers

ORDER BY customer_id ASC;


-- Customers registered in stores but not online

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


-- =====================================================
-- 5. SET OPERATIONS WITH CTES
-- =====================================================
-- Identify customers appearing in only one system.

WITH online_only AS (

    SELECT customer_id, name
    FROM online_customers

    EXCEPT

    SELECT customer_id, name
    FROM store_customers

),

store_only AS (

    SELECT customer_id, name
    FROM store_customers

    EXCEPT

    SELECT customer_id, name
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


-- =====================================================
-- FINAL CHALLENGE: CUSTOMER RECONCILIATION REPORT
-- =====================================================
-- Classify customers according to registration:
--
-- Online Only
-- Store Only
-- Both
--
-- Expected columns:
-- customer_id, name, registration_status
-- =====================================================

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

),

both_systems AS (

    SELECT
        customer_id,
        name
    FROM online_customers

    INTERSECT

    SELECT
        customer_id,
        name
    FROM store_customers

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
FROM both_systems

ORDER BY customer_id ASC;


-- =====================================================
-- KEY TAKEAWAYS
-- =====================================================

-- UNION removes duplicate rows.
-- UNION ALL preserves duplicate rows.
-- INTERSECT returns rows present in both results.
-- EXCEPT returns rows from the first result
-- that are absent from the second.
--
-- Set operations require the same number of columns
-- with compatible data types.
--
-- Set operations compare complete selected rows.
-- They do not automatically match on primary keys.
--
-- ORDER BY at the end sorts the combined result.
--
-- CTEs make complex reconciliation queries
-- easier to read and maintain.
--
-- =====================================================
-- END OF MODULE 15
-- =====================================================
