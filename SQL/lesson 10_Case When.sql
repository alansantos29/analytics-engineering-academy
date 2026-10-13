--Advanced Conditional Logic
--===================================
--Advanced CASE WHEN
--=====================================
--Customer Segmentation

--Create table Customer_sales
/*
CREATE TABLE IF NOT EXISTS customer_sales (
    customer_id INT GENERATED ALWAYS AS IDENTITY 
    PRIMARY KEY,
    customer_name VARCHAR(50),
    total_spent DECIMAL(5,2),
    total_orders INT
);
*/

--Alter data type on Total_spent column
/*
ALTER TABLE customer_sales
ALTER COLUMN total_spent TYPE NUMERIC(12,2);
*/


--Add values to the table
/*
INSERT INTO customer_sales (customer_name,
total_spent,total_orders)
VALUES 
('Alan', 5000, 12),
('Maria', 2500, 4),
('Peter', 800, 10),
('Sarah', 1500, 7),
('João', 400, 2),
('Ana',	6000, 3);
*/

--Apply these rules in order:
--1. VIP: total_spent >= 3000 AND total_orders >= 10.
--2. Regular: total_spent >= 1000 OR total_orders >= 5.
--3. Basic: Everyone else
/*
SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    CASE 
        WHEN total_spent >= 3000 AND total_orders >= 10 THEN 'VIP'
        WHEN total_spent >= 1000 OR total_orders >= 5 THEN 'Regular'
        ELSE 'Basic'

    END AS Customer_segment

FROM customer_sales;
*/

--Lesson 3: Combining AND and OR
/*
SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    CASE
        WHEN (total_spent >= 3000 AND total_orders >= 10)
    OR
    (total_spent >= 1000 AND total_orders >= 7) THEN 'Eligible'

    ELSE 'Not Eligible'
    END AS reward_status
    


FROM 
    customer_sales;
*/

--Lesson 3: Nested CASE WHEN
/*
SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    CASE
        WHEN total_spent >= 3000 THEN
                CASE 
                    WHEN total_orders >=10 THEN 'VIP'
                    WHEN total_orders <10 THEN 'High Spender'
                    END
        
        WHEN total_spent <3000 AND total_orders >=5 THEN 'Frequent Buyer'        

        ELSE 'Standard'
    END AS customer_category


FROM 
    customer_sales;
    */


--Lesson 4: Advanced NULL Handling
/*
SELECT
    customer_id,
    customer_name,
    COALESCE(total_spent,0) AS adjusted_spending,
    COALESCE(total_orders,0) AS adjusted_orders


FROM customer_sales;
*/

--Lesson 5: NULLIF()
/*
SELECT
    customer_id,
    customer_name,
    total_spent,
    total_orders,
    ROUND(total_spent::NUMERIC/NULLIF(total_orders,0),2) AS average_order_value


FROM
    customer_sales;
    */


--Final Challenge: Customer Performance Report

WITH clean_customer_sales AS (
    
    SELECT
        customer_id,
        customer_name,
        COALESCE(total_spent,0) AS adjusted_spending,
        COALESCE(total_orders,0) AS adjusted_orders

    FROM customer_sales
)




SELECT
    customer_id,
    customer_name,
    adjusted_spending,
    adjusted_orders,

    CASE
        WHEN adjusted_spending>=3000 AND adjusted_orders>=10 THEN 'VIP'
        WHEN adjusted_spending >=1000 OR adjusted_orders>=5 THEN 'Regular'
        ELSE 'Basic'
    END AS customer_segment,
    
    CASE
        WHEN (adjusted_spending>=3000 AND adjusted_orders>=10) OR (adjusted_spending>=1000 AND adjusted_orders>=7) THEN 'Eligible'
        ELSE 'Not Eligible'

    END AS reward_status,

    ROUND(adjusted_spending::NUMERIC/NULLIF(adjusted_orders,0),2) AS average_order_value


FROM
    clean_customer_sales;
