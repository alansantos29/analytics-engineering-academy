--Common Table Expressions
--=============================================
--CTE Of employess in the IT Department
--============================================
--only employees from the IT department.
/*
WITH it_employees AS(

SELECT 
        employee,
        department,
        salary
FROM employees
WHERE department = 'IT'
)

SELECT *
FROM it_employees;
*/



--===============================================

--CTE of First identify employees earning more
-- than 70,000. Then, from those employees, 
--return only employees from Finance.

/*
WITH high_salary_employees AS (
    SELECT
            employee,
            department,
            salary
    FROM employees
    WHERE salary >70000
)

SELECT *
FROM high_salary_employees
WHERE department = 'Finance';
*/

--=============================================
--aggregation inside a CTE
--Calculate the total salary for each department, 
--and then return only departments whose total 
--salary is greater than 150000.

/*
WITH department_totals AS(
    SELECT
        department,
        Sum(salary) AS total

    FROM employees
    GROUP BY department
)

SELECT *
FROM department_totals
WHERE total >150000;
*/

--============================================
--Multiple CTEs
/*
WITH department_totals AS(
    SELECT
        department,
        Sum(salary) AS total

    FROM employees
    GROUP BY department
),

large_departments AS (
    SELECT *

    FROM department_totals
    WHERE total >150000
)

SELECT *
FROM large_departments;
*/

--=========================================
--Calculate how many projects each employee has, 
--then return only employees who have more than 
--one project.
/*
WITH employee_projects AS (
    SELECT
        i.employee,
        o.project_id

    FROM employees i
    JOIN projects o
    ON i.employee_id = o.employee_id
),

employee_projects2 AS (
    SELECT
        employee,
        count(project_id) AS Number_of_Projects
    FROM employee_projects
    GROUP BY employee
)

 
SELECT *
FROM employee_projects2
WHERE Number_of_Projects >1;
*/

--============================================
--Shows every department and the total number of 
--projects assigned to employees in that department,
-- including departments whose employees have no 
--projects.

WITH department_projects AS (
    SELECT
            e.department,
            COUNT(i.project_id)
    FROM employees e
    LEFT JOIN projects i
    ON e.employee_id = i.employee_id
    GROUP BY e.department
)

SELECT *
FROM department_projects;



