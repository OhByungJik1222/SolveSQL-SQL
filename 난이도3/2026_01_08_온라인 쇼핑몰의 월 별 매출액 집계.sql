WITH ORDERED AS (
  SELECT  DATE_FORMAT(A.order_date, '%Y-%m') AS order_month
          ,SUM(B.price * B.quantity) AS ordered_amount
    FROM  orders AS A
    JOIN  order_items AS B
      ON  A.order_id = B.order_id
   WHERE  A.order_id NOT LIKE ('C%')
   GROUP
      BY  DATE_FORMAT(A.order_date, '%Y-%m')
),
CANCELED AS (
  SELECT  DATE_FORMAT(A.order_date, '%Y-%m') AS order_month
          ,SUM(B.price * B.quantity) AS canceled_amount
    FROM  orders AS A
    JOIN  order_items AS B
      ON  A.order_id = B.order_id
   WHERE  A.order_id LIKE ('C%')
   GROUP
      BY  DATE_FORMAT(A.order_date, '%Y-%m')
)
SELECT  A.order_month
        ,A.ordered_amount
        ,B.canceled_amount
        ,A.ordered_amount + B.canceled_amount AS total_amount
  FROM  ORDERED AS A
  JOIN  CANCELED AS B
    ON  A.order_month = B.order_month
 ORDER
    BY  A.order_month;