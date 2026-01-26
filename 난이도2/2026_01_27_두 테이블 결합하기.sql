SELECT  DISTINCT R.athlete_id
  FROM  records AS R
  LEFT
  JOIN  events AS E
    ON  R.event_id = E.id
 WHERE  E.sport = 'Golf'