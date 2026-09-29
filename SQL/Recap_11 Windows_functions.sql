/*
============================================================
11 - WINDOW FUNCTIONS
============================================================

Window functions perform calculations across related rows
WITHOUT collapsing the original rows.

GROUP BY:
    Changes the grain of the result.

WINDOW FUNCTION:
    Keeps the original rows and adds calculations to them.

Basic structure:

    FUNCTION(column) OVER (
        PARTITION BY ...
        ORDER BY ...
    )

Mental model:

    PARTITION BY = WHO gets a separate calculation?
    ORDER BY     = IN WHAT ORDER?
    FUNCTION     = WHAT calculation?
*/


-- =========================================================
-- 1. DEPARTMENT AVERAGE
-- =========================================================

SELECT
    employee,
    department,
    salary,
    AVG(salary) OVER (
        PARTITION BY department
    ) AS department_average
FROM employees;


-- =========================================================
-- 2. COMPANY VS DEPARTMENT AVERAGE
-- =========================================================

SELECT
    employee,
    department,
    salary,
    AVG(salary) OVER () AS company_wide_avg,
    AVG(salary) OVER (
        PARTITION BY department
    ) AS department_avg
FROM employees;


/*
OVER()
    = entire result set

OVER(PARTITION BY department)
    = separate window for each department
*/


-- =========================================================
-- 3. MAXIMUM SALARY PER DEPARTMENT
-- =========================================================

SELECT
    employee,
    department,
    salary,
    MAX(salary) OVER (
        PARTITION BY department
    ) AS highest_department_salary
FROM employees;


-- =========================================================
-- 4. ROW_NUMBER
-- =========================================================

SELECT
    employee,
    department,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS salary_position
FROM employees;


/*
ROW_NUMBER gives every row a unique position.

ORDER BY salary DESC:
    highest salary = position 1
*/


-- =========================================================
-- 5. ROW_NUMBER VS RANK VS DENSE_RANK
-- =========================================================

SELECT
    employee,
    department,
    salary,

    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS row_number_position,

    RANK() OVER (
        ORDER BY salary DESC
    ) AS rank_position,

    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS dense_rank_position

FROM employees;


/*
If salaries are:

100000
90000
90000
80000

ROW_NUMBER:
1, 2, 3, 4

RANK:
1, 2, 2, 4

DENSE_RANK:
1, 2, 2, 3
*/


-- =========================================================
-- 6. TOP N PER GROUP
-- =========================================================

WITH ranked_employees AS (
    SELECT
        employee,
        department,
        salary,

        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_position

    FROM employees
)

SELECT *
FROM ranked_employees
WHERE salary_position <= 2;


/*
Pattern:

1. Rank rows within each group.
2. Put the ranking in a CTE.
3. Filter the ranking outside the CTE.

This returns the top 2 employees per department.
*/


-- =========================================================
-- 7. RUNNING TOTAL
-- =========================================================

SELECT
    month,
    sales,
    SUM(sales) OVER (
        ORDER BY month_number
    ) AS running_total
FROM monthly_sales;


/*
Example:

Jan  1000  -> 1000
Feb  1500  -> 2500
Mar   800  -> 3300
Apr  1200  -> 4500
*/


-- =========================================================
-- 8. RUNNING TOTAL PER SALESPERSON
-- =========================================================

SELECT
    month,
    salesperson,
    sales,

    SUM(sales) OVER (
        PARTITION BY salesperson
        ORDER BY month_number
    ) AS running_total

FROM monthly_sales;


/*
PARTITION BY salesperson:
    Running total restarts for every salesperson.

ORDER BY month_number:
    Calculation follows chronological order.
*/


-- =========================================================
-- 9. LAG - PREVIOUS ROW
-- =========================================================

SELECT
    month,
    salesperson,
    sales,

    LAG(sales) OVER (
        PARTITION BY salesperson
        ORDER BY month_number
    ) AS previous_month_sales

FROM monthly_sales;


/*
LAG looks BACKWARDS.

For the first row of each salesperson:
previous_month_sales = NULL

This is because there is no previous row.
*/


-- =========================================================
-- 10. MONTH-OVER-MONTH CHANGE
-- =========================================================

SELECT
    month,
    salesperson,
    sales,

    sales - LAG(sales) OVER (
        PARTITION BY salesperson
        ORDER BY month_number
    ) AS sales_change

FROM monthly_sales;


/*
Formula:

current sales - previous sales

Positive = increase
Negative = decrease
*/


-- =========================================================
-- 11. LEAD - NEXT ROW
-- =========================================================

SELECT
    month,
    salesperson,
    sales,

    LEAD(sales) OVER (
        PARTITION BY salesperson
        ORDER BY month_number
    ) AS next_month_sales

FROM monthly_sales;


/*
LAG  = previous row
LEAD = next row
*/


-- =========================================================
-- 12. MOVING / ROLLING AVERAGE
-- =========================================================

SELECT
    month,
    salesperson,
    sales,

    AVG(sales) OVER (
        PARTITION BY salesperson
        ORDER BY month_number
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_average

FROM monthly_sales;


/*
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW

means:

previous 2 rows
+
current row

Maximum window size = 3 rows.

At the beginning of the dataset SQL uses the rows
that are available.
*/


-- =========================================================
-- 13. FINAL CHALLENGE
-- =========================================================

SELECT
    month,
    salesperson,
    region,
    sales,

    SUM(sales) OVER (
        PARTITION BY salesperson
        ORDER BY month_number
    ) AS running_total,

    LAG(sales) OVER (
        PARTITION BY salesperson
        ORDER BY month_number
    ) AS previous_month_sales,

    sales - LAG(sales) OVER (
        PARTITION BY salesperson
        ORDER BY month_number
    ) AS sales_change

FROM monthly_sales;


/*
============================================================
KEY TAKEAWAYS
============================================================

GROUP BY
    Collapses multiple rows into fewer rows.

WINDOW FUNCTIONS
    Keep individual rows while calculating across related rows.


OVER()
    Defines the window.

PARTITION BY
    Splits rows into independent groups.

ORDER BY
    Defines sequence inside the window.

ROW_NUMBER()
    Unique sequential position.

RANK()
    Same rank for ties, with gaps.

DENSE_RANK()
    Same rank for ties, without gaps.

LAG()
    Previous row.

LEAD()
    Next row.

ROWS BETWEEN
    Defines the window frame.


VERY IMPORTANT MENTAL MODEL:

PARTITION BY = WHO?
ORDER BY     = IN WHAT ORDER?
FUNCTION     = WHAT CALCULATION?


Common Analytics Engineering uses:

- Running revenue
- Month-over-month growth
- Customer rankings
- Top products by category
- Previous-period comparisons
- Moving averages
- Deduplication
- Latest record per customer
- Cohort and time-series analysis

============================================================
END OF WINDOW FUNCTIONS
============================================================
*/