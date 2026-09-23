-- =====================================================
-- ANALYTICS ENGINEER ACADEMY
-- Topic: WHERE vs HAVING
-- =====================================================

-- WHERE filters individual rows BEFORE aggregation.
-- HAVING filters groups AFTER aggregation.


-- 1. Filter individual sales before grouping

SELECT
    salesperson,
    SUM(amount) AS total_sales
FROM sales
WHERE amount > 400
GROUP BY salesperson;


-- 2. Filter aggregated results

SELECT
    salesperson,
    SUM(amount) AS total_sales
FROM sales
GROUP BY salesperson
HAVING SUM(amount) > 700;


-- 3. WHERE + HAVING together

SELECT
    salesperson,
    SUM(amount) AS total_sales
FROM sales
WHERE amount > 400
GROUP BY salesperson
HAVING SUM(amount) > 700;


-- =====================================================
-- EXECUTION MENTAL MODEL
-- =====================================================

-- FROM
--   ↓
-- WHERE
--   ↓
-- GROUP BY
--   ↓
-- HAVING
--   ↓
-- SELECT
--   ↓
-- ORDER BY
--   ↓
-- LIMIT


-- =====================================================
-- IMPORTANT
-- =====================================================

-- WHERE:
-- "Which individual rows should participate?"

-- HAVING:
-- "Which groups should remain after aggregation?"

-- Example:
--
-- WHERE amount > 400
-- removes individual sales <= 400 first.
--
-- HAVING SUM(amount) > 700
-- removes groups whose final total is <= 700.


-- =====================================================
-- ALTERNATIVE USING A SUBQUERY
-- =====================================================

SELECT
    salesperson,
    total_sales
FROM (
    SELECT
        salesperson,
        SUM(amount) AS total_sales
    FROM sales
    WHERE amount > 400
    GROUP BY salesperson
) AS s
WHERE total_sales > 700;

-- Why WHERE in the outer query?
--
-- Because total_sales has already been calculated by
-- the inner query. To the outer query, total_sales is
-- now simply a column.