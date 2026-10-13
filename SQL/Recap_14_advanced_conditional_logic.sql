
-- =====================================================
-- MODULE 14: ADVANCED CONDITIONAL LOGIC
-- Analytics Engineer Academy
-- Database: PostgreSQL
-- =====================================================


-- 1. CASE WHEN: CUSTOMER SEGMENTATION
-- VIP: Spending >= 3000 AND orders >= 10
-- Regular: Spending >= 1000 OR orders >= 5
-- Basic: Everyone else

SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    CASE
        WHEN total_spent >= 3000
             AND total_orders >= 10 THEN 'VIP'
        WHEN total_spent >= 1000
             OR total_orders >= 5 THEN 'Regular'
        ELSE 'Basic'
    END AS customer_segment
FROM customer_sales;


-- 2. COMBINING AND, OR AND PARENTHESES
-- Identify customers eligible for loyalty rewards.

SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    CASE
        WHEN
            (total_spent >= 3000 AND total_orders >= 10)
            OR
            (total_spent >= 1000 AND total_orders >= 7)
        THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS reward_status
FROM customer_sales;


-- 3. NESTED CASE WHEN
-- Classify customers using nested business rules.

SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    CASE
        WHEN total_spent >= 3000 THEN
            CASE
                WHEN total_orders >= 10 THEN 'VIP'
                ELSE 'High Spender'
            END
        WHEN total_orders >= 5 THEN 'Frequent Buyer'
        ELSE 'Standard'
    END AS customer_category
FROM customer_sales;


-- 4. COALESCE()
-- Replace NULL values with zero in query results.

SELECT
    customer_id,
    customer_name,
    COALESCE(total_spent, 0) AS adjusted_spending,
    COALESCE(total_orders, 0) AS adjusted_orders
FROM customer_sales;


-- 5. NULLIF()
-- Prevent division-by-zero errors.

SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    ROUND(
        total_spent::NUMERIC / NULLIF(total_orders, 0),
        2
    ) AS average_order_value
FROM customer_sales;


-- =====================================================
-- FINAL CHALLENGE: CUSTOMER PERFORMANCE REPORT
-- =====================================================
-- Requirements:
-- 1. Replace missing spending and orders with zero.
-- 2. Classify customers as VIP, Regular or Basic.
-- 3. Determine loyalty reward eligibility.
-- 4. Calculate average order value safely.
-- =====================================================

WITH clean_customer_sales AS (

    SELECT
        customer_id,
        customer_name,
        COALESCE(total_spent, 0) AS adjusted_spending,
        COALESCE(total_orders, 0) AS adjusted_orders
    FROM customer_sales

)

SELECT
    customer_id,
    customer_name,
    adjusted_spending,
    adjusted_orders,

    CASE
        WHEN adjusted_spending >= 3000
             AND adjusted_orders >= 10 THEN 'VIP'
        WHEN adjusted_spending >= 1000
             OR adjusted_orders >= 5 THEN 'Regular'
        ELSE 'Basic'
    END AS customer_segment,

    CASE
        WHEN
            (adjusted_spending >= 3000 AND adjusted_orders >= 10)
            OR
            (adjusted_spending >= 1000 AND adjusted_orders >= 7)
        THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS reward_status,

    ROUND(
        adjusted_spending::NUMERIC /
        NULLIF(adjusted_orders, 0),
        2
    ) AS average_order_value

FROM clean_customer_sales;


-- =====================================================
-- KEY TAKEAWAYS
-- =====================================================

-- CASE WHEN applies conditional business rules.
-- SQL checks WHEN conditions from top to bottom.
-- AND requires both conditions to be TRUE.
-- OR requires at least one condition to be TRUE.
-- Parentheses make complex conditions explicit.
-- Nested CASE supports hierarchical classifications.
-- COALESCE returns the first non-NULL value.
-- NULLIF returns NULL when two values are equal.
-- ::NUMERIC ensures decimal division.
-- ROUND(value, 2) rounds numeric results.
-- CTEs help separate data preparation from business logic.
-- SELECT transformations do not change source tables.

-- =====================================================
-- END OF MODULE 14
-- =====================================================
