-- =====================================================
-- ANALYTICS ENGINEER ACADEMY
-- Topic: DISTINCT and COUNT(DISTINCT)
-- =====================================================


-- 1. Return unique salespeople

SELECT DISTINCT
    salesperson
FROM sales;


-- 2. Return unique combinations

SELECT DISTINCT
    salesperson,
    region
FROM sales;

-- DISTINCT applies to the entire combination of
-- selected columns.


-- =====================================================
-- COUNTING
-- =====================================================

-- 3. Count all rows

SELECT
    COUNT(*) AS total_rows
FROM sales;


-- 4. Count non-NULL values

SELECT
    COUNT(salesperson) AS salesperson_count
FROM sales;


-- 5. Count unique non-NULL values

SELECT
    COUNT(DISTINCT salesperson) AS unique_salespeople
FROM sales;


-- =====================================================
-- KEY DIFFERENCE
-- =====================================================

-- COUNT(*)
-- -> Counts rows.

-- COUNT(column)
-- -> Counts non-NULL values in that column.

-- COUNT(DISTINCT column)
-- -> Counts unique non-NULL values.


-- Example:
--
-- salesperson
-- -----------
-- Alan
-- Alan
-- Maria
-- Peter
-- Peter
-- NULL
--
-- COUNT(*)                    = 6
-- COUNT(salesperson)          = 5
-- COUNT(DISTINCT salesperson) = 3


-- =====================================================
-- MENTAL MODEL
-- =====================================================

-- DISTINCT:
-- "Give me unique values/combinations."

-- COUNT(DISTINCT column):
-- "How many unique values are there?"