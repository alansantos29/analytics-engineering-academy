SELECT  
        employee,
        salary

FROM employees
                 

WHERE salary in (Select
                        MAX(salary)
                FROM employees
                WHERE department ='HR');