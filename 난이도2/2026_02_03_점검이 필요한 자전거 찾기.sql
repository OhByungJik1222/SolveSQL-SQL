SELECT  bike_id
  FROM  rental_history
 WHERE  LEFT(rent_at, 7) = '2021-01'
 GROUP
    BY  bike_id
HAVING  SUM(distance) >= 50000;