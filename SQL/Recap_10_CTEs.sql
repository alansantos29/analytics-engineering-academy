-- ============================================================
-- 10. COMMON TABLE EXPRESSIONS (CTEs)
-- ============================================================

-- A CTE is a named temporary result set that exists only
-- during the execution of the query.
--
-- Basic structure:
--
-- WITH cte_name AS (
--     SELECT ...
-- )
-- SELECT *
-- FROM cte_name;


-- ============================================================
-- 1. BASIC CTE
-- ============================================================

WITH it_employees AS (
    SELECT
        employee,
        department,
        salary
    FROM employees
    WHERE department = 'IT'
)

SELECT *
FROM it_employees;


-- ============================================================
-- 2. USING A CTE AS INPUT FOR ANOTHER TRANSFORMATION
-- ============================================================

WITH high_salary_employees AS (
    SELECT
        employee,
        department,
        salary
    FROM employees
    WHERE salary > 70000
)

SELECT *
FROM high_salary_employees
WHERE department = 'Finance';


-- ============================================================
-- 3. AGGREGATION INSIDE A CTE
-- ============================================================

WITH department_totals AS (
    SELECT
        department,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department
)

SELECT *
FROM department_totals
WHERE total_salary > 150000;


-- ============================================================
-- 4. MULTIPLE CTEs
-- ============================================================

-- WITH is written only once.
-- Additional CTEs are separated by commas.
--
-- A later CTE can use the result of an earlier CTE.

WITH department_totals AS (
    SELECT
        department,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department
),

large_departments AS (
    SELECT *
    FROM department_totals
    WHERE total_salary > 150000
)

SELECT *
FROM large_departments;


-- ============================================================
-- 5. CTE + JOIN + GROUP BY
-- ============================================================

WITH employee_projects AS (
    SELECT
        e.employee,
        p.project_id
    FROM employees e
    JOIN projects p
        ON e.employee_id = p.employee_id
),

project_counts AS (
    SELECT
        employee,
        COUNT(project_id) AS number_of_projects
    FROM employee_projects
    GROUP BY employee
)

SELECT *
FROM project_counts
WHERE number_of_projects > 1;


-- ============================================================
-- 6. LEFT JOIN INSIDE A CTE
-- ============================================================

-- LEFT JOIN keeps employees even when they have no projects.
--
-- COUNT(p.project_id) counts only non-NULL project IDs.
-- COUNT(*) would also count the preserved LEFT JOIN row.

WITH department_projects AS (
    SELECT
        e.department,
        COUNT(p.project_id) AS number_of_projects
    FROM employees e
    LEFT JOIN projects p
        ON e.employee_id = p.employee_id
    GROUP BY e.department
)

SELECT *
FROM department_projects;


-- ============================================================
-- KEY CTE CONCEPTS
-- ============================================================

-- 1. CTEs start with WITH.
--
-- 2. A CTE is not a permanent table.
--
-- 3. The main query can use the CTE like a table.
--
-- 4. Multiple CTEs are separated by commas.
--
-- 5. A later CTE can read from an earlier CTE.
--
-- 6. A CTE does not automatically depend on another CTE.
--    The dependency is created explicitly:
--
--    FROM previous_cte
--
-- 7. CTEs are useful for breaking complex transformations
--    into understandable steps.
--
-- 8. Always think about grain:
--
--    "What does one row represent at this stage?"
--
-- Example transformation pipeline:
--
-- raw data
--    ↓
-- cleaned_data
--    ↓
-- aggregated_data
--    ↓
-- filtered_data
--    ↓
-- final result