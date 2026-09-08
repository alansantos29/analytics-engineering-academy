SELECT
        salesperson,
        amount,
        Case  
            When amount >= 700 THEN 'Excellent'
            WHEN amount >=500 THEN 'Good'
            ELSE 'Low' 
        END AS Performance
FROM sales;