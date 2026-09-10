-- Change columns type
/*
ALTER TABLE employees
ALTER COLUMN employess TYPE VARCHAR(20),
ALTER COLUMN manager TYPE VARCHAR(20);



--Check changes
SELECT
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'employees';

--Change tables name
ALTER TABLE employees
RENAME  TO employee;

*/

--Change column Name
ALTER TABLE employee
RENAME COLUMN employess TO employee;

