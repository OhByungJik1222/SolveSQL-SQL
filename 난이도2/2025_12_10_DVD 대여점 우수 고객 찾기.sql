WITH active_customer AS (
  SELECT  *
    FROM  customer
   WHERE  active = 1
)
SELECT  c.customer_id
  FROM  rental as r
  JOIN  active_customer as c 
    ON  r.customer_id = c.customer_id
 GROUP
    BY  c.customer_id, c.store_id
HAVING count(rental_id) >= 35;