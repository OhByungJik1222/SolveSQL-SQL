WITH after_2000_with_medal AS (
  SELECT  r.*
    FROM  records AS r
    JOIN  games AS g
      ON  r.game_id = g.id
   WHERE  g.year >= 2000
     AND  r.medal IS NOT NULL
),
grouped AS (
  SELECT  athlete_id
          ,team_id
    FROM  after_2000_with_medal
   GROUP
      BY  athlete_id, team_id
),
strange_player AS (
  SELECT  athlete_id
          ,COUNT(*) AS diff_cnt
    FROM  grouped
   GROUP
      BY  athlete_id
  HAVING  diff_cnt >= 2
)
SELECT  a.name
  FROM  strange_player AS s
  JOIN  athletes AS a
    ON  s.athlete_id = a.id
 ORDER
    BY  a.name;