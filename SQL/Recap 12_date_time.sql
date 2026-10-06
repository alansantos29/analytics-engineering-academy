/*
============================================================
12 - DATE & TIME FUNCTIONS
============================================================

Common PostgreSQL date/time types:

DATE        = date only
TIME        = time only
TIMESTAMP   = date + time

Date functions are essential for:
- Monthly reporting
- Period comparisons
- Delivery times
- Recent activity
- Revenue trends
- Time-based KPIs
*/


-- =========================================================
-- 1. CURRENT DATE
-- =========================================================

SELECT
    order_id,
    customer,
    order_date,
    CURRENT_DATE AS today
FROM orders;


/*
CURRENT_DATE
    Returns today's date.

CURRENT_TIMESTAMP
    Returns the current date and time.
*/


-- =========================================================
-- 2. EXTRACT DATE COMPONENTS
-- =========================================================

SELECT
    order_id,
    customer,
    order_date,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month
FROM orders;


/*
EXTRACT allows us to retrieve individual components
from a date.

Examples:

EXTRACT(YEAR FROM order_date)
EXTRACT(MONTH FROM order_date)
EXTRACT(DAY FROM order_date)
*/


-- =========================================================
-- 3. FILTER BY YEAR AND MONTH
-- =========================================================

SELECT
    order_id,
    customer,
    order_date,
    amount
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2026
  AND EXTRACT(MONTH FROM order_date) = 2;


/*
This returns orders from February 2026.
*/


-- =========================================================
-- 4. DATE_TRUNC
-- =========================================================

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(amount) AS total_sales
FROM orders
GROUP BY month
ORDER BY month;


/*
DATE_TRUNC groups dates into reporting periods.

Example:

2026-01-15
2026-01-28

Both become:

2026-01-01 00:00:00


Common examples:

DATE_TRUNC('month', order_date)
DATE_TRUNC('year', order_date)
*/


-- =========================================================
-- 5. YEARLY SALES
-- =========================================================

SELECT
    DATE_TRUNC('year', order_date) AS year,
    SUM(amount) AS total_sales
FROM orders
GROUP BY year
ORDER BY year;


/*
Important distinction:

EXTRACT()
    Retrieves one component from a date.

DATE_TRUNC()
    Converts dates to a common reporting period.
*/


-- =========================================================
-- 6. DATE ARITHMETIC
-- =========================================================

SELECT
    order_id,
    order_date,
    delivery_date,
    delivery_date - order_date AS delivery_days
FROM orders;


/*
Date subtraction can answer different questions:

CURRENT_DATE - order_date
    = days since the order

CURRENT_DATE - delivery_date
    = days since delivery

delivery_date - order_date
    = delivery duration
*/


-- =========================================================
-- 7. INTERVAL
-- =========================================================

SELECT
    order_id,
    order_date,
    order_date + INTERVAL '10 days' AS ten_days_after_order
FROM orders;


/*
INTERVAL represents a period of time.

Examples:

INTERVAL '10 days'
INTERVAL '30 days'
INTERVAL '3 months'
INTERVAL '1 year'
*/


-- =========================================================
-- 8. ORDERS FROM THE LAST 30 DAYS
-- =========================================================

SELECT
    order_id,
    customer,
    order_date,
    amount
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';


-- =========================================================
-- 9. ORDERS FROM THE LAST 90 DAYS
-- =========================================================

SELECT
    order_id,
    customer,
    order_date,
    amount
FROM orders
WHERE order_date BETWEEN CURRENT_DATE - INTERVAL '90 days'
                     AND CURRENT_DATE;


/*
BETWEEN includes both boundaries.
*/


-- =========================================================
-- 10. FIXED DATE RANGE
-- =========================================================

SELECT *
FROM orders
WHERE order_date BETWEEN '2026-01-01' AND '2026-03-31';


-- =========================================================
-- 11. MONTHLY SALES + PREVIOUS MONTH
-- =========================================================

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(amount) AS total_sales
    FROM orders
    GROUP BY month
)

SELECT
    month,
    total_sales,

    LAG(total_sales) OVER (
        ORDER BY month
    ) AS previous_month_sales

FROM monthly_sales;


/*
Notice that we do NOT use:

PARTITION BY month

because every month is already one row.

We want one continuous timeline:

Jan -> Feb -> Mar -> Apr
*/


-- =========================================================
-- 12. MONTH-OVER-MONTH SALES CHANGE
-- =========================================================

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(amount) AS total_sales
    FROM orders
    GROUP BY month
)

SELECT
    month,
    total_sales,

    LAG(total_sales) OVER (
        ORDER BY month
    ) AS previous_month_sales,

    total_sales - LAG(total_sales) OVER (
        ORDER BY month
    ) AS sales_change

FROM monthly_sales;


-- =========================================================
-- 13. MONTH-OVER-MONTH PERCENTAGE CHANGE
-- =========================================================

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(amount) AS total_sales
    FROM orders
    GROUP BY month
)

SELECT
    month,
    total_sales,

    LAG(total_sales) OVER (
        ORDER BY month
    ) AS previous_month_sales,

    total_sales - LAG(total_sales) OVER (
        ORDER BY month
    ) AS sales_change,

    (
        total_sales - LAG(total_sales) OVER (ORDER BY month)
    ) * 100.0
    / NULLIF(
        LAG(total_sales) OVER (ORDER BY month),
        0
    ) AS percentage_change

FROM monthly_sales;


/*
Percentage change:

(current - previous)
-------------------- x 100
      previous


NULLIF(previous, 0)

protects us from division by zero.
*/


-- =========================================================
-- 14. FINAL CHALLENGE
-- MONTHLY DELIVERY PERFORMANCE
-- =========================================================

SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(order_id) AS number_of_orders,
    SUM(amount) AS total_sales,
    AVG(delivery_date - order_date) AS average_delivery_days
FROM orders
GROUP BY DATE_TRUNC('month', order_date);


/*
Original grain:
    1 row = 1 order

Final grain:
    1 row = 1 month


This query combines:

DATE_TRUNC()
COUNT()
SUM()
Date arithmetic
AVG()
GROUP BY
*/


/*
============================================================
KEY TAKEAWAYS
============================================================

CURRENT_DATE
    Today's date.

CURRENT_TIMESTAMP
    Current date + time.

EXTRACT()
    Pull a component from a date.

DATE_TRUNC()
    Convert dates into reporting periods.

INTERVAL
    Represent periods such as 30 days or 1 year.

Date subtraction
    Calculate duration between dates.

BETWEEN
    Filter within a date range.

Dates + CTEs + Window Functions
    Allow us to build time-based business metrics.


ANALYTICS ENGINEERING USES:

- Monthly revenue
- Year-over-year reporting
- Month-over-month growth
- Customer activity periods
- Delivery performance
- Rolling reporting periods
- Recent transactions
- Time-series KPIs

============================================================
END OF DATE & TIME FUNCTIONS
============================================================
*/