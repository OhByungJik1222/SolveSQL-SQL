WITH DIVIDED AS (
  SELECT  DISTINCT customer_id
          ,CASE
            WHEN customer_id % 10 = 0 THEN 'A'
            ELSE 'B'
          END AS bucket
    FROM  transactions
),
GROUPED AS (
  SELECT  customer_id
          ,COUNT(transaction_id) AS ORDER_CNT
          ,SUM(total_price) AS TOTAL
    FROM  transactions
   WHERE  is_returned = 0
   GROUP
      BY  customer_id
),
JOINED AS (
  SELECT  G.customer_id
          ,D.bucket
          ,G.ORDER_CNT
          ,G.TOTAL
    FROM  GROUPED AS G
    LEFT
    JOIN  DIVIDED AS D
      ON  G.customer_id = D.customer_id
)
SELECT  bucket
        ,COUNT(customer_id) AS user_count
        ,ROUND(AVG(ORDER_CNT), 2) AS avg_orders
        ,ROUND(AVG(TOTAL), 2) AS avg_revenue
  FROM  JOINED
 GROUP
    BY  bucket;