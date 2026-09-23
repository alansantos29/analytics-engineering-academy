-- =====================================================
-- ANALYTICS ENGINEER ACADEMY
-- Topic: NULL, IS NULL, IS NOT NULL and COALESCE
-- =====================================================


-- NULL means missing / unknown.
--
-- NULL is NOT:
-- 0
-- ''
-- FALSE
-- the text 'NULL'


-- =====================================================
-- 1. FIND NULL VALUES
-- =====================================================

SELECT
    employee,
    manager
FROM employee
WHERE manager IS NULL;


-- =====================================================
-- 2. FIND NON-NULL VALUES
-- =====================================================

SELECT
    employee,
    manager
FROM employee
WHERE manager IS NOT NULL;


-- =====================================================
-- IMPORTANT
-- =====================================================

-- Do NOT write:
--
-- WHERE manager = NULL
--
-- Use:
--
-- WHERE manager IS NULL


-- =====================================================
-- 3. NULL AND COMPARISONS
-- =====================================================

SELECT
    employee,
    manager
FROM employee
WHERE manager <> 'David';

-- A NULL manager is NOT returned by this condition.
--
-- Why?
--
-- NULL <> 'David'
--
-- does not evaluate to TRUE.
-- It evaluates to UNKNOWN.


-- To include employees whose manager is unknown:

SELECT
    employee,
    manager
FROM employee
WHERE manager <> 'David'
   OR manager IS NULL;


-- =====================================================
-- THREE-VALUED LOGIC
-- =====================================================

-- SQL conditions can evaluate to:
--
-- TRUE
-- FALSE
-- UNKNOWN
--
-- WHERE only keeps rows where the condition is TRUE.
--
-- FALSE and UNKNOWN are filtered out.


-- =====================================================
-- 4. COALESCE
-- =====================================================

-- COALESCE returns the first non-NULL value.

SELECT
    employee,
    COALESCE(bonus, 0) AS bonus
FROM employee;


-- If bonus = 500:
--
-- COALESCE(500, 0) -> 500
--
-- If bonus = NULL:
--
-- COALESCE(NULL, 0) -> 0


-- =====================================================
-- 5. COMBINE NULL FILTERING + COALESCE
-- =====================================================

-- Employees without managers, with NULL bonuses
-- displayed as 0.

SELECT
    employee,
    COALESCE(bonus, 0) AS bonus
FROM employee
WHERE manager IS NULL;


-- Employees who HAVE managers:

SELECT
    employee,
    COALESCE(bonus, 0) AS bonus
FROM employee
WHERE manager IS NOT NULL;


-- =====================================================
-- MENTAL MODEL
-- =====================================================

-- IS NULL
-- -> Is the value missing?

-- IS NOT NULL
-- -> Is there a known value?

-- COALESCE(column, replacement)
-- -> If column is NULL, use replacement.

-- Remember:
--
-- NULL = unknown
--
-- Comparisons involving unknown values can produce
-- UNKNOWN rather than TRUE or FALSE.