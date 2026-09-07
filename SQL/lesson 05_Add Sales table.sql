/*CREATE TABLE sales (
    sales_id SERIAL PRIMARY KEY,
    salesperson VARCHAR(100) NOT NULL,
    region VARCHAR(20),
    amount DECIMAL(10,2)
);
*/

INSERT INTO sales (
    sales_id,
    salesperson,
    region,
    amount
)
VALUES
    (1, 'Alan', 'South', 500),
    (2, 'Maria', 'North', 800),
    (3, 'Alan', 'South', 700),
    (4, 'Peter', 'North', 400),
    (5, 'Maria', 'North', 600),
    (6, 'Peter', 'South', 300);