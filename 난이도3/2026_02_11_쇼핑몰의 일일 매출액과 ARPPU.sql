SELECT  DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-%d') AS dt
        ,COUNT(DISTINCT o.customer_id) AS pu
        ,SUM(p.payment_value) AS revenue_daily
        ,ROUND(SUM(p.payment_value) / COUNT(DISTINCT o.customer_id), 2) AS arppu
  FROM  olist_orders_dataset AS o
  JOIN  olist_order_payments_dataset AS p
    ON  o.order_id = p.order_id
 WHERE  o.order_purchase_timestamp >= '2018-01-01'
 GROUP
    BY  dt
 ORDER
    BY  dt;