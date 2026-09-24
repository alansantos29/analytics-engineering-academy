--====================================
--Window function
--OVER()
--Calculate this as a window function
-- while keeping the individual rows."
--======================================
--Show every employee, their department, 
--their salary, and the highest salary in 
--their department.

/*
SELECT 
        employee,
        department,
        salary,
        MAX(salary) OVER (
            PARTITION BY department) AS 
            highest_department_salary


FROM 
        employees;
        */

--=======================================

SELECT
        employee,
        department,
        salary,
        AVG(salary) OVER () AS Company_wide_avg,
        AVG(salary) OVER (PARTITION BY department) 
        AS department_avg 

FROM 
        employees;    

--=============================================
-- ROW_NUMBER()
--==============================================
