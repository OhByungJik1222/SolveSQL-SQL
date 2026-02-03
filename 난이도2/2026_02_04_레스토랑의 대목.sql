WITH grouped AS (
  SELECT  day
    FROM  tips
   GROUP
      BY  day
  HAVING  SUM(total_bill) >= 1500
)
SELECT  *
  FROM  tips
 WHERE  day IN (SELECT day FROM grouped);