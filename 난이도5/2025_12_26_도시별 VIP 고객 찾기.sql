WITH customer_sales AS (
  SELECT  city_id
          ,customer_id
          ,SUM(total_price - discount_amount) AS total_spent
    FROM  transactions
   WHERE  is_returned = 0
   GROUP 
      BY  city_id, customer_id
),
RANKED AS (
  SELECT  city_id
          ,customer_id
          ,total_spent
          ,RANK() OVER (PARTITION BY city_id ORDER BY total_spent DESC) AS RNK
    FROM  customer_sales
)
SELECT  city_id,
        customer_id,
        total_spent 
  FROM  RANKED
 WHERE  RNK = 1;
