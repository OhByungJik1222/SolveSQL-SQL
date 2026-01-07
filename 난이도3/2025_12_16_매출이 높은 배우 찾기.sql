WITH film_revenue AS (
    SELECT  F.film_id
            ,SUM(P.amount) AS revenue
      FROM  rental AS R
      JOIN  inventory AS I
        ON  R.inventory_id = I.inventory_id
      JOIN  film AS F
        ON  I.film_id = F.film_id
      JOIN  payment AS P
        ON  R.rental_id = P.rental_id
     GROUP
        BY  F.film_id
)
SELECT  A.first_name
        ,A.last_name
        ,SUM(FR.revenue) AS total_revenue
  FROM  film_revenue AS FR
  JOIN  film_actor AS FA
    ON  FR.film_id = FA.film_id
  JOIN  actor AS A
    ON  FA.actor_id = A.actor_id
 GROUP 
    BY  A.actor_id, A.first_name, A.last_name
 ORDER 
    BY  total_revenue DESC
 LIMIT  5;