WITH ADD_WEEKEND AS (
  SELECT  total_bill
          ,CASE
            WHEN day IN ('Sat', 'Sun') THEN 'weekend'
            ELSE 'weekday'
           END AS IS_WEEKEND
    FROM  tips
)
SELECT  IS_WEEKEND AS week
        ,SUM(total_bill) AS sales
  FROM  ADD_WEEKEND
 GROUP
    BY  IS_WEEKEND
 ORDER
    BY  sales DESC;