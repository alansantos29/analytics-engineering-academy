/*
-- Add the Bonus Column to the Employees Table
ALTER TABLE employees
ADD COLUMN bonus numeric (12,2);


--Add column employee_id to employees table
ALTER TABLE employees
ADD COLUMN employee_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;


--Add Antoher value to the table

INSERT INTO value into Employees columns


UPDATE employees
SET bonus =
            CASE
                WHEN employee_id = 1 THEN 5000
                WHEN employee_id = 2 THEN NULL
                WHEN employee_id = 3 THEN 3000
                WHEN employee_id = 4 THEN NULL
                WHEN employee_id = 5 THEN 8000
            END
WHERE employee_id IN (1,2,3,4,5);

*/

SELECT *
FROM employees;

