WITH PLUS_DATE AS (
    SELECT  measured_at AS measured_at_0
            ,pm10 AS pm10_0
            ,DATE_FORMAT(DATE_ADD(measured_at, INTERVAL 1 DAY), '%Y-%m-%d') AS measured_at_1
            ,DATE_FORMAT(DATE_ADD(measured_at, INTERVAL 2 DAY), '%Y-%m-%d') AS measured_at_2
      FROM  measurements
),
JOINED_1 AS (
  SELECT  A.measured_at_0
          ,A.pm10_0
          ,A.measured_at_1
          ,B.pm10 AS pm10_1
          ,A.measured_at_2
    FROM  PLUS_DATE AS A
    LEFT
    JOIN  measurements AS B
      ON  A.measured_at_1 = B.measured_at
),
JOINED_2 AS (
  SELECT  A.measured_at_0
          ,A.pm10_0
          ,A.measured_at_1
          ,A.pm10_1
          ,A.measured_at_2
          ,B.pm10 AS pm10_2
    FROM  JOINED_1 AS A
    LEFT
    JOIN  measurements AS B
      ON  A.measured_at_2 = B.measured_at
)
SELECT  measured_at_2 AS date_alert
  FROM  JOINED_2
 WHERE  pm10_0 < pm10_1
   AND  pm10_1 < pm10_2
   AND  pm10_2 >= 30;