SELECT  t.measured_at AS today
        ,n.measured_at AS next_day
        ,t.pm10 AS pm10
        ,n.pm10 AS next_pm10
  FROM  measurements AS t
  LEFT
  JOIN  measurements AS n
    ON  DATE_ADD(t.measured_at, INTERVAL 1 DAY) = n.measured_at
 WHERE  t.pm10  < n.pm10;