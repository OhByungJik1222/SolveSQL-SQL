WITH DEC_SAL AS (
  SELECT  *
    FROM  records
   WHERE  LEFT(order_date, 7) = '2020-12'
)
SELECT  customer_id
  FROM  DEC_SAL
 GROUP
    BY  customer_id
HAVING  SUM(sales) >= 1000;