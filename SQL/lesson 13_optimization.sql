--Creating your first Index

--Create table
/*
CREATE TABLE transactions (
    transaction_id INT,
    customer_id INT,
    amount NUMERIC(10,2),
    transaction_date DATE
);
*/


--Create an Index
/*
CREATE INDEX idx_transactions_customer
ON transactions(customer_id);
*/

--Inspect your first execution plan
/*
EXPLAIN ANALYZE
SELECT *
FROM transactions
WHERE customer_id = 100;
*/

-- Check all transactions on the transaction  table
SELECT *
FROM transactions;
