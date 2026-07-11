-- Left Join 
/*SELECT
    e.name,
    d.department_name
FROM Employees AS e
LEFT JOIN Departments AS d
ON e.department_id = d.department_id;*/

--Left Join
/*SELECT E.Employee_name,
E.employee_derpartment_id,
D.department_name
FROM Employees AS E
LEFT JOIN Departments AS D
ON E.department_id = D.department_id;*/

--Which employees have not yet been assigned to a department?
SELECT
    E.employee_name,
    D.department_name
FROM Employees AS E
LEFT JOIN Departments AS D
ON E.department_id = D.department_id
WHERE D.department_id IS NULL;