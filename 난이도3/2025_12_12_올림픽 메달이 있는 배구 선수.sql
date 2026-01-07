SELECT  A.id
        ,A.name
        ,GROUP_CONCAT(R.medal ORDER BY R.medal SEPARATOR ',') AS medals
  FROM  records AS R
  JOIN  athletes AS A
    ON  R.athlete_id = A.id
  JOIN  events AS E
    ON  R.event_id = E.id
  JOIN  teams AS T
    ON  R.team_id = T.id
 WHERE  E.event = 'Volleyball Women''s Volleyball'
   AND  team = 'KOR'
   AND  R.medal IS NOT NULL
 GROUP
    BY  A.id, A.name