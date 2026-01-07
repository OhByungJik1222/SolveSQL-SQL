WITH ONLINE_2023 AS (
  SELECT  DATE_FORMAT(purchased_at, '%Y-%m-%d') AS order_date
          ,COUNT(transaction_id) AS num_orders_today
    FROM  transactions
   WHERE  YEAR(purchased_at) = 2023
     AND  is_online_order = 1
   GROUP
      BY  DATE_FORMAT(purchased_at, '%Y-%m-%d') 
   ORDER
      BY  order_date
),
WEEKDAY_YESTERDAY_ADDED AS (
  SELECT  order_date
          ,DATE_SUB(order_date, INTERVAL 1 DAY) AS yesterday
          ,CASE
            WHEN WEEKDAY(order_date) = 0 THEN 'Monday'
            WHEN WEEKDAY(order_date) = 1 THEN 'Tuesday'
            WHEN WEEKDAY(order_date) = 2 THEN 'Wednesday'
            WHEN WEEKDAY(order_date) = 3 THEN 'Thursday'
            WHEN WEEKDAY(order_date) = 4 THEN 'Friday'
            WHEN WEEKDAY(order_date) = 5 THEN 'Saturday'
            WHEN WEEKDAY(order_date) = 6 THEN 'Sunday'
          END AS 'weekday'
          ,num_orders_today
    FROM ONLINE_2023
)
SELECT  T.order_date
        ,T.weekday
        ,T.num_orders_today
        ,T.num_orders_today + IFNULL(Y.num_orders_today, 0) AS num_orders_from_yesterday
  FROM  WEEKDAY_YESTERDAY_ADDED AS T
  LEFT
  JOIN  WEEKDAY_YESTERDAY_ADDED AS Y
    ON  T.yesterday = Y.order_date