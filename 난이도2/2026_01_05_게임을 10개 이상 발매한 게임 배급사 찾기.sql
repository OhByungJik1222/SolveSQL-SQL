WITH OVER_10_PUB AS (
  SELECT  publisher_id
          ,COUNT(game_id) AS game_cnt
    FROM  games
   GROUP
      BY  publisher_id
  HAVING  game_cnt >= 10
)
SELECT  name
  FROM  companies AS A
  JOIN  OVER_10_PUB AS B
    ON  A.company_id = B.publisher_id;