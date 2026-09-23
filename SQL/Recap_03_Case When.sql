-- =====================================================
-- ANALYTICS ENGINEER ACADEMY
-- Topic: CASE WHEN and Conditional Aggregation
-- =====================================================


-- 1. Basic CASE WHEN
-- Classify each sale according to its amount.

SELECT
    salesperson,
    amount,
    CASE
        WHEN amount >= 700 THEN 'Excellent'
        WHEN amount >= 500 THEN 'Good'
        ELSE 'Low'
    END AS performance
FROM sales;


-- =====================================================
-- CASE IS EVALUATED TOP TO BOTTOM
-- =====================================================

-- SQL stops at the first TRUE condition.
--
-- For amount = 800:
--
-- amount >= 700 -> TRUE
--
-- SQL returns 'Excellent' and stops checking.


-- =====================================================
-- 2. CONDITIONAL AGGREGATION
-- =====================================================

-- Count high-value and low-value sales.
--
-- High-value = amount >= 600
-- Low-value  = amount < 600

SELECT
    SUM(
        CASE
            WHEN amount >= 600 THEN 1
            ELSE 0
        END
    ) AS high_value_sales,

    SUM(
        CASE
            WHEN amount < 600 THEN 1
            ELSE 0
        END
    ) AS low_value_sales
FROM sales;


-- =====================================================
-- HOW SUM(CASE...) WORKS
-- =====================================================

-- CASE converts a condition into numbers:
--
-- TRUE  -> 1
-- FALSE -> 0
--
-- Example:
--
-- amount
-- ------
-- 800   -> 1
-- 500   -> 0
-- 900   -> 1
-- 300   -> 0
--
-- SUM = 2
--
-- Therefore:
--
-- SUM(CASE WHEN condition THEN 1 ELSE 0 END)
--
-- means:
--
-- "Count the rows where this condition is TRUE."


-- =====================================================
-- 3. COUNT SALES BY REGION IN ONE SUMMARY ROW
-- =====================================================

SELECT
    SUM(CASE WHEN region = 'North' THEN 1 ELSE 0 END)
        AS north_sales,

    SUM(CASE WHEN region = 'South' THEN 1 ELSE 0 END)
        AS south_sales
FROM sales;


-- =====================================================
-- IMPORTANT: GRAIN
-- =====================================================

-- Notice that the query above does NOT use:
--
-- GROUP BY region
--
-- This is intentional.
--
-- We want:
--
-- north_sales | south_sales
-- ------------+------------
--      3      |      3
--
-- One row = one overall summary.
--
-- If we GROUP BY region, the grain changes to:
--
-- one row = one region
--
-- Always ask:
--
-- "What should one row in my final result represent?"