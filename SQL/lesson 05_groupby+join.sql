/*
SELECT 
    salesperson
    ,sum(amount)
FROM sales
GROUP BY salesperson;


-- 1. What is the grain of the original Sales table?
SELECT *
FROM sales;

 
-- 2. What is the grain of the result after GROUP BY region?
SELECT 
    region,
    sum(amount)
FROM sales
GROUP BY region;
*/

-- 3. What would the total sales be for North and South?
SELECT 
    region,
    sum(amount)
FROM sales
GROUP BY region
HAVING region = 'North' OR region = 'South';
