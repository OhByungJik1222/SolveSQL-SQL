WITH over_10 AS (
  SELECT  order_date
          ,COUNT(DISTINCT order_id) as order_cnt
    FROM  records
   GROUP
      BY  order_date
  HAVING  order_cnt >= 10
),
f_cnt AS (
  SELECT  order_date
          ,COUNT(DISTINCT order_id) AS fur
    FROM  records
   WHERE  category = 'Furniture'
   GROUP
      BY  order_date
)
SELECT  o.order_date
        ,f.fur AS furniture
        ,ROUND(f.fur / o.order_cnt * 100, 2) AS furniture_pct
  FROM  over_10 AS o
  JOIN  f_cnt AS f
    ON  o.order_date = f.order_date
 WHERE  ROUND(f.fur / o.order_cnt * 100, 2) >= 40
 ORDER
    BY  furniture_pct DESC;