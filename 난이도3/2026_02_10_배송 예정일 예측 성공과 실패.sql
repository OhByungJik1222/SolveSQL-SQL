SELECT  DATE_FORMAT(order_purchase_timestamp, '%Y-%m-%d') AS purchase_date
        ,COUNT(CASE WHEN order_estimated_delivery_date > order_delivered_customer_date THEN 1 END) AS success
        ,COUNT(CASE WHEN order_estimated_delivery_date <= order_delivered_customer_date THEN 1 END) AS fail
  FROM  olist_orders_dataset
 WHERE  order_purchase_timestamp LIKE ('2017-01%')
 GROUP
    BY  purchase_date
 ORDER
    BY  purchase_date ASC;