SELECT  DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-%d') AS dt
        ,ROUND(SUM(p.payment_value), 2) AS revenue_daily
  FROM  olist_orders_dataset AS o
  JOIN  olist_order_payments_dataset AS p
    ON  o.order_id = p.order_id
 WHERE  YEAR(o.order_purchase_timestamp) >= 2018
 GROUP
    BY  dt
 ORDER
    BY  dt ASC;
