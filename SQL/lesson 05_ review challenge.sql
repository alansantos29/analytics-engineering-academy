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




--Create table projects

CREATE Table projects (
project_id INT GENERATED ALWAYS AS IDENTITY (START WITH 101 INCREMENT BY 1) PRIMARY KEY,
employee_id INT,
FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id)

);



--Add values to the project table
INSERT INTO projects (employee_id)
values
(1),
(2),
(2),
(3),
(5);

*/


SELECT 
        employee,
        department,
        salary,
        COALESCE (e.bonus, 0) AS Bonus
FROM  employees e
WHERE salary > (
                        SELECT 
                            AVG(salary)
                        FROM employees i 
                        WHERE e.department = i.department
                    )
AND EXISTS (SELECT 
                    employee_id
              FROM projects a
              WHERE e.employee_id = a.employee_id
                );
