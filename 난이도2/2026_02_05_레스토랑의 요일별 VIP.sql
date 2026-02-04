WITH vip AS (
  SELECT  day
          ,MAX(total_bill) AS max_bill
    FROM  tips
   GROUP  
      BY  day
)
SELECT  A.*
  FROM  tips AS A
  JOIN  vip AS B
    ON  A.day = B.day
 WHERE  A.total_bill = B.max_bill