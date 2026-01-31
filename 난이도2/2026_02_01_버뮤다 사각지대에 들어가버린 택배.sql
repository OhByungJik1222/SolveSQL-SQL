SELECT  DATE_FORMAT(order_delivered_carrier_date, '%Y-%m-%d') AS delivered_carrier_date
        ,COUNT(DISTINCT order_id) AS orders
  FROM  olist_orders_dataset
 WHERE  LEFT(order_delivered_carrier_date, 7) = '2017-01'
   AND  order_delivered_customer_date IS NULL
 GROUP
    BY  delivered_carrier_date
 ORDER
    BY  delivered_carrier_date ASC;