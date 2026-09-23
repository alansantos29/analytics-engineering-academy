-- =====================================================
-- ANALYTICS ENGINEER ACADEMY
-- Topic: Correlated Subqueries
-- =====================================================


-- A correlated subquery depends on the CURRENT ROW
-- being processed by the outer query.


-- =====================================================
-- 1. EMPLOYEE VS THEIR OWN DEPARTMENT AVERAGE
-- =====================================================

-- Business question:
--
-- Find employees earning more than the average salary
-- of THEIR OWN department.

SELECT
    e.employee,
    e.department,
    e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(i.salary)
    FROM employees i
    WHERE i.department = e.department
);


-- =====================================================
-- HOW IT WORKS
-- =====================================================

-- The outer query evaluates employees one at a time.
--
-- Suppose the current employee is:
--
-- Maria | HR | 70000
--
-- At that moment:
--
-- e.department = 'HR'
--
-- Therefore the inner query effectively becomes:
--
-- SELECT AVG(salary)
-- FROM employees
-- WHERE department = 'HR';
--
-- Maria's salary is then compared with the HR average.


-- If the current employee is:
--
-- Peter | IT | 120000
--
-- e.department = 'IT'
--
-- The inner query effectively becomes:
--
-- SELECT AVG(salary)
-- FROM employees
-- WHERE department = 'IT';


-- =====================================================
-- 2. ANOTHER EXAMPLE
-- =====================================================

-- Find products priced above the average price
-- of products in THEIR OWN category.

SELECT
    p.product,
    p.category,
    p.price
FROM products p
WHERE p.price > (
    SELECT AVG(i.price)
    FROM products i
    WHERE i.category = p.category
);


-- =====================================================
-- WHEN TO THINK "CORRELATED SUBQUERY"
-- =====================================================

-- Business requirements containing ideas such as:
--
-- "their own department"
-- "their own category"
-- "for each employee"
-- "for each customer"
-- "within the same group"
-- "related to the current row"
--
-- often suggest correlation.


-- =====================================================
-- NORMAL VS CORRELATED SUBQUERY
-- =====================================================

-- Normal subquery:

SELECT
    employee,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- The inner query does NOT depend on the current
-- employee.
--
-- It calculates one company-wide average.


-- Correlated subquery:

SELECT
    e.employee,
    e.salary,
    e.department
FROM employees e
WHERE e.salary > (
    SELECT AVG(i.salary)
    FROM employees i
    WHERE i.department = e.department
);

-- The inner query DOES depend on the current employee.


-- =====================================================
-- KEY MENTAL MODEL
-- =====================================================

-- Current outer row
--        ↓
-- Take a value from that row
--        ↓
-- Use it inside the inner query
--        ↓
-- Calculate/check something related to that row
--        ↓
-- Return to the outer query and evaluate the condition


-- The defining feature is NOT that two different
-- tables are used.
--
-- The defining feature is:
--
-- The INNER query references a value from the
-- OUTER query.


-- =====================================================
-- IMPORTANT FOR LATER
-- =====================================================

-- Correlated subqueries are not always the only or
-- best way to solve these problems.
--
-- Later we will solve similar analytical problems
-- using:
--
-- JOINs
-- CTEs
-- Window Functions
--
-- and compare the approaches.