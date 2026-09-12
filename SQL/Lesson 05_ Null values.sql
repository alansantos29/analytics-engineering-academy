SELECT 
    Employee,
    COALESCE(bonus, 0)

FROM employee
WHERE manager IS NULL;