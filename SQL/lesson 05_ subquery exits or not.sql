SELECT
        customer_id

FROM  customers o
WHERE NOT EXISTS (Select
                                        customer_id
                                FROM orders i
                                WHERE o.customer_id = i.customer_id
                                );