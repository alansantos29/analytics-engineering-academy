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
/*
SELECT
        employee,
        department,
        salary,
        AVG(salary) OVER () AS Company_wide_avg,
        AVG(salary) OVER (PARTITION BY department) 
        AS department_avg 

FROM 
        employees;    
*/
--=============================================
-- ROW_NUMBER()
--==============================================
/*
SELECT
    employee,
    department,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC
        ) AS salary_position

FROM 
    employees;
*/

--=============================================
--ROW_NUMBER() vs RANK() vs DENSE_RANK()
/*
SELECT
    employee,
    department,
    salary,
    ROW_NUMBER () OVER (
        ORDER BY salary DESC),
    RANK () OVER (
        ORDER BY salary DESC),
    DENSE_RANK () OVER(
        ORDER BY salary DESC)

FROM
    employees;
    */

    --========================================
    --Return the highest-paid employee
    -- in each department.
    --======================================
/*
   WITH ranked_employess AS (
    
    SELECT
            ROW_NUMBER() OVER (
                PARTITION BY department
                ORDER BY salary DESC) AS salary_position
    FROM employees
)

SELECT *
FROM ranked_employess
WHERE salary_position =1;
*/

--==========================================
--Running totals with SUM() OVER()

/*
WITH running_sales AS (
    
        SELECT 
            month,
            sales,
            ROW_NUMBER() OVER () AS month_number

        FROM
            monthly_sales
)

SELECT 
        month,
        sales,
        SUM(sales) OVER(
            ORDER BY month_number )

FROM running_sales;
*/

--Another Sum() over()
/*
SELECT
    month,
    salesperson,
    sales,
    sum(sales) OVER (PARTITION BY salesperson
    ORDER BY month_number) AS running_total

FROM monthly_sales;
*/

--============================================
--LAG()
/*
SELECT
    month,
    salesperson,
    sales,
    LAG(sales) OVER (
        PARTITION BY salesperson
        order BY month_number) AS previous_month_sales


FROM 
    monthly_sales;
    */

--============================================
--subtract that directly from the current sales
/*
SELECT
    month,
    salesperson,
    sales,
    Sales - LAG(sales) OVER (PARTITION BY salesperson
    ORDER By month_number) AS sales_change


FROM
    monthly_sales;
*/
--===========================================
--Moving Averages
/*
SELECT
    month,
    salesperson,
    sales,
    AVG(sales) OVER (
        PARTITION BY salesperson
        ORDER BY month_number
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)

FROM
    monthly_sales;
*/

--===========================================
--Final Challenge

SELECT
    month,
    salesperson,
    region,
    sales,
    SUM(sales) OVER(PARTITION BY salesperson
    ORDER BY month_number) AS running_total,
    LAG(sales)OVER(PARTITION BY salesperson
    ORDER BY month_number) AS previous_month_sales,
    sales-LAG(sales) OVER (PARTITION BY salesperson
    ORDER BY month_number) AS sales_change


FROM
    monthly_sales;
