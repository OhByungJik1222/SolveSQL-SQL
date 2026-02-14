WITH rnk AS (
  SELECT  day
          ,time
          ,sex
          ,total_bill
          ,DENSE_RANK() OVER (PARTITION BY DAY ORDER BY total_bill DESC) AS drnk
    FROM  tips
)
SELECT  day
        ,time
        ,sex
        ,total_bill
  FROM  rnk
 WHERE drnk <= 3;