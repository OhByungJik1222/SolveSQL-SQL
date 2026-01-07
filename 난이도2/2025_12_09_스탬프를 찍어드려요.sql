WITH STAMP_CNT AS (
  SELECT  *
          ,CASE
              WHEN total_bill >= 25 THEN 2
              WHEN total_bill >= 15 THEN 1
              ELSE 0
           END AS stamp
    FROM  tips
)
SELECT  stamp
        ,COUNT(*) AS count_bill
  FROM  STAMP_CNT
 GROUP
    BY  stamp
 ORDER
    BY  stamp ASC;