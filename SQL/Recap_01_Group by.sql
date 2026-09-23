-- =====================================================
-- ANALYTICS ENGINEER ACADEMY
-- Topic: GROUP BY and Aggregate Functions
-- =====================================================

-- GROUP BY changes the grain of the result.
-- Example:
-- Original grain: one row = one sale
-- After GROUP BY region: one row = one region


-- 1. Total sales by region

SELECT
    region,
    SUM(amount) AS total_sales
FROM sales
GROUP BY region;


-- 2. Average sale amount by salesperson

SELECT
    salesperson,
    AVG(amount) AS average_sale
FROM sales
GROUP BY salesperson;


-- 3. Number of sales by salesperson

SELECT
    salesperson,
    COUNT(*) AS number_of_sales
FROM sales
GROUP BY salesperson;


-- 4. Multiple aggregations

SELECT
    region,
    COUNT(*) AS number_of_sales,
    SUM(amount) AS total_sales,
    AVG(amount) AS average_sale,
    MIN(amount) AS minimum_sale,
    MAX(amount) AS maximum_sale
FROM sales
GROUP BY region;


-- =====================================================
-- KEY NOTES
-- =====================================================

-- Aggregate functions:
-- SUM()   -> adds values
-- AVG()   -> calculates the average
-- COUNT() -> counts rows/values
-- MIN()   -> smallest value
-- MAX()   -> largest value

-- Mental model:
-- GROUP BY asks:
-- "What should one row in my final result represent?"

-- Example:
-- GROUP BY region
-- Grain = one row per region

-- GROUP BY salesperson
-- Grain = one row per salesperson