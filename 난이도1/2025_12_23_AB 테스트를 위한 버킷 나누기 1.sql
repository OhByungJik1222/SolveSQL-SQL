SELECT  DISTINCT customer_id
        ,CASE
          WHEN  customer_id % 10 = 0 THEN 'A'
          ELSE 'B'
         END AS bucket
  FROM  transactions
 ORDER
    BY  customer_id