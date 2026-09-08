SELECT  
        count  (DISTINCT salesperson)


FROM  
    (
        SELECT
            salesperson,
            amount,
            CASE
                WHEN amount >= 700 THEN 'High'
                When amount >=500 THEN 'Good'
                else 'Low'
            END AS performance
            
        FROM sales
    )
WHERE performance = 'Low';