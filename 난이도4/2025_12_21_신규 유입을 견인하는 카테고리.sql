WITH FIRST_ORDER AS (
  SELECT  DISTINCT r.order_id
          ,r.category
          ,r.sub_category
    FROM  records AS r
    JOIN  customer_stats AS c
      ON  r.customer_id = c.customer_id
   WHERE  r.order_date = c.first_order_date
)
SELECT  category
        ,sub_category
        ,COUNT(order_id) AS cnt_orders
  FROM  FIRST_ORDER
 GROUP
    BY  category
        ,sub_category
 ORDER
    BY  cnt_orders DESC;