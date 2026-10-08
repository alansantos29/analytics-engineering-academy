
-- =====================================================
-- MODULE 13: STRING FUNCTIONS
-- Analytics Engineer Academy
-- PostgreSQL
-- =====================================================

-- 1. UPPER() AND LOWER()
-- Standardise text capitalization

SELECT
    customer_id,
    UPPER(customer_name) AS uppercase_name,
    LOWER(email) AS lowercase_email
FROM customers;


-- 2. TRIM()
-- Remove leading and trailing spaces

SELECT
    customer_id,
    TRIM(customer_name) AS trimmed_name,
    TRIM(LOWER(email)) AS clean_email
FROM customers;


-- 3. LENGTH()
-- Count characters, including internal spaces

SELECT
    customer_id,
    customer_name,
    LENGTH(TRIM(customer_name)) AS name_length
FROM customers;


-- 4. CONCAT()
-- Combine text values

SELECT
    customer_id,
    CONCAT(
        TRIM(UPPER(customer_name)),
        ' - ',
        TRIM(UPPER(city))
    ) AS customer_description
FROM customers;


-- 5. REPLACE()
-- Remove hyphens from phone numbers

SELECT
    customer_id,
    phone,
    REPLACE(phone, '-', '') AS clean_phone
FROM customers;


-- 6. SUBSTRING()
-- Extract the first four characters

SELECT
    customer_id,
    phone,
    SUBSTRING(phone FROM 1 FOR 4) AS country_code
FROM customers;


-- 7. POSITION()
-- Find the position of @ in an email address

SELECT
    customer_id,
    email,
    POSITION('@' IN email) AS at_position
FROM customers;


-- 8. SUBSTRING() + POSITION()
-- Extract email usernames after cleaning

SELECT
    customer_id,
    email,
    SUBSTRING(
        TRIM(LOWER(email))
        FROM 1
        FOR POSITION('@' IN TRIM(LOWER(email))) - 1
    ) AS email_username
FROM customers;


-- 9. SPLIT_PART()
-- PostgreSQL alternative for extracting usernames

SELECT
    customer_id,
    email,
    SPLIT_PART(TRIM(LOWER(email)), '@', 1)
        AS email_username
FROM customers;


-- =====================================================
-- FINAL CHALLENGE: CUSTOMER DATA CLEANING
-- =====================================================

SELECT
    customer_id,
    TRIM(UPPER(customer_name)) AS clean_name,
    TRIM(LOWER(email)) AS clean_email,
    TRIM(UPPER(city)) AS clean_city,
    REPLACE(phone, '-', '') AS clean_phone,
    SUBSTRING(
        TRIM(LOWER(email))
        FROM 1
        FOR POSITION('@' IN TRIM(LOWER(email))) - 1
    ) AS email_username
FROM customers;


-- =====================================================
-- KEY TAKEAWAYS
-- =====================================================

-- TRIM() removes leading and trailing spaces.
-- LOWER() and UPPER() standardise capitalization.
-- LENGTH() counts characters.
-- CONCAT() combines text.
-- REPLACE() substitutes or removes characters.
-- SUBSTRING() extracts part of a string.
-- POSITION() finds a character's location.
-- SPLIT_PART() splits text using a delimiter.
--
-- Clean text before extracting components.
-- SELECT transformations do not modify source data.
-- =====================================================
