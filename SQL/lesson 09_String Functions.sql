--String fucntions
--========================================
--Update existing customers table
/*
ALTER TABLE customers 
ADD COLUMN email varchar(50),
ADD COLUMN city varchar(20),
ADD COLUMN phone varchar(50);
*/

-- Add values to the table
/*
UPDATE customers
SET 
    customer_name = 'Alan Santos',
    email = 'ALAN.SANTOS@EMAIL.COM',
    city = 'MAPUTO',
    phone = '+258-84-123-4567'
WHERE customer_name = 'Alan Santos';


UPDATE customers
SET 
    customer_name = 'maria silva',
    email= 'maria.silva@email.com',
    city='maputo',
    phone='+258-82-987-6543'
WHERE customer_name = 'Maria';

UPDATE customers
SET 
    customer_name = 'PETER JONES',
    email= 'PETER.JONES@EMAIL.COM',
    city='Matola',
    phone='+258-86-555-1234'
WHERE customer_name = 'Peter';


UPDATE customers
SET 
    customer_name = 'Sarah Costa',
    email= 'sarah.costa@email.com',
    city='MAPUTO',
    phone='+258-84-777-8899'
WHERE customer_name = 'Sarah';


INSERT INTO customers (customer_id, customer_name, 
email, city, phone)

VALUES

(5,'joao manuel','JOAO.MANUEL@EMAIL.COM','Beira','+258-87-222-3344'),
(6,'ANA PAULO','ana.paulo@email.com','beira','+258-82-444-5566');

*/

--=========================================
--Exercises
--==========================================

--text customers
--Exercise 1 — TRIM() + LOWER()
/*
SELECT
    customer_id,
    customer_name,

    TRIM(LOWER(customer_name)) AS clean_name
FROM 
customers;
*/

-- Exercise 2 — Cleaning emails
/*
SELECT
    customer_id,
    email,
    TRIM(LOWER(email)) AS clean_email
FROM 
    customers;
    */


-- Exercise 3 — LENGTH()
/*
SELECT
    customer_name,
    TRIM(LOWER(customer_name)) AS clean_name,
    LENGTH(TRIM(customer_name))


FROM
    customers;
    */


--Exercise 4 — CONCAT()
/*
SELECT
    customer_id,
    customer_name,
    city,
    CONCAT(TRIM(UPPER(customer_name)),' - ',UPPER(city)) AS customer_description


FROM
    customers;
 */

 --Exercise 5 — REPLACE()
/*

 SELECT
    customer_id,
    phone,
    REPLACE(phone, '-','')


 FROM 
    customers;
*/

--Exercise 6 — SUBSTRING()
/*
SELECT
    customer_id,
    phone,
    SUBSTRING(phone FROM 1 FOR 4) AS country_code


FROM
    customers;
    */

--Exercise 7 — A more useful SUBSTRING()
/*
SELECT
    customer_id,
    email,
    SUBSTRING(TRIM(LOWER(email)) FROM 1 FOR 5) AS email_prefix


FROM 
    customers;
    */


-- Exercise 9
/*
SELECT
    customer_id,
    email,
    TRIM(LOWER(SUBSTRING(email FROM 1 
    FOR POSITION('@' IN email)-1
            ))) AS email_username


FROM
    customers;
*/

--Final Challenge — Customer Data Cleaning

SELECT
    customer_id,
    TRIM(Upper(customer_name)) AS clean_name,
    TRIM(LOWER(email)) AS clean_email,
    TRIM(UPPER(city)) AS clean_city,
    REPLACE(phone,'-','') AS clean_phone,
    SUBSTRING(TRIM(LOWER(email)) FROM 1
    FOR POSITION('@' IN TRIM(LOWER(email)))-1) AS email_username
    


FROM
    customers;