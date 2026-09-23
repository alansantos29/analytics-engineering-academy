-- =====================================================
-- ANALYTICS ENGINEER ACADEMY
-- Mixed SQL Challenge
-- =====================================================

-- BUSINESS REQUIREMENT:
--
-- Return employees who:
--
-- 1. Earn more than the average salary of their
--    own department.
--
-- 2. Are assigned to at least one project.
--
-- 3. Have NULL bonuses displayed as 0.


SELECT
    e.employee,
    e.department,
    e.salary,
    COALESCE(e.bonus, 0) AS bonus
FROM employees e
WHERE e.salary > (
    SELECT AVG(i.salary)
    FROM employees i
    WHERE i.department = e.department
)
AND EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.employee_id = e.employee_id
);


-- =====================================================
-- CONCEPT 1: CORRELATED SUBQUERY
-- =====================================================

-- The inner query:
--
-- SELECT AVG(i.salary)
-- FROM employees i
-- WHERE i.department = e.department
--
-- calculates the average salary for the department
-- of the CURRENT employee being evaluated.


-- =====================================================
-- CONCEPT 2: EXISTS
-- =====================================================

-- EXISTS checks whether at least one project exists
-- for the current employee.
--
-- It does not matter whether the employee has:
--
-- 1 project
-- 2 projects
-- 100 projects
--
-- At least one matching row means EXISTS = TRUE.


-- =====================================================
-- CONCEPT 3: COALESCE
-- =====================================================

-- COALESCE(e.bonus, 0)
--
-- If bonus has a value:
-- -> return that value.
--
-- If bonus is NULL:
-- -> return 0.


-- =====================================================
-- CONCEPT 4: AND
-- =====================================================

-- Both WHERE conditions must be TRUE:
--
-- Above department average
--            AND
-- Has at least one project
--
-- Only then is the employee returned.


-- =====================================================
-- ANALYTICAL THINKING
-- =====================================================

-- Before writing SQL, break the business requirement
-- into smaller questions:
--
-- "More than their own department average"
-- -> AVG() + correlated subquery
--
-- "At least one project"
-- -> EXISTS
--
-- "NULL bonus should display as 0"
-- -> COALESCE()