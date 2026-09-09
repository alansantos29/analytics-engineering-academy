/*
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
*/

-- 1.Count rows where this condition is true.

SELECT

   SUM(
    CASE
        WHEN region = 'North' THEN 1 
        ELSE 0
    END ) AS Northy,

    SUM(
    CASE
        WHEN region = 'South' THEN 1 
        ELSE 0
    END ) AS Southy



FROM sales;