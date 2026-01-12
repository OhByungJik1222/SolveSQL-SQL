WITH WEEKDAY_ADDED AS (
  SELECT  
          ,CASE WHEN WEEKDAY(measured_at) = 0 THEN '월요일'
                WHEN WEEKDAY(measured_at) = 1 THEN '화요일'
                WHEN WEEKDAY(measured_at) = 2 THEN '수요일'
                WHEN WEEKDAY(measured_at) = 3 THEN '목요일'
                WHEN WEEKDAY(measured_at) = 4 THEN '금요일'
                WHEN WEEKDAY(measured_at) = 5 THEN '토요일'
                WHEN WEEKDAY(measured_at) = 6 THEN '일요일'
           END AS WEEK_DAY
    FROM  measurements
),
GROUPED AS (
  SELECT  WEEK_DAY AS 'weekday'
          ,ROUND(AVG(no2), 4) AS no2
          ,ROUND(AVG(o3), 4) AS o3
          ,ROUND(AVG(co), 4) AS co
          ,ROUND(AVG(so2), 4) AS so2
          ,ROUND(AVG(pm10), 4) AS pm10
          ,ROUND(AVG(pm2_5), 4) AS pm2_5
    FROM  WEEKDAY_ADDED
  GROUP
      BY  WEEK_DAY
)
SELECT  
  FROM  GROUPED
 ORDER
    BY  CASE WHEN weekday = '월요일' THEN 1
             WHEN weekday = '화요일' THEN 2
             WHEN weekday = '수요일' THEN 3
             WHEN weekday = '목요일' THEN 4
             WHEN weekday = '금요일' THEN 5
             WHEN weekday = '토요일' THEN 6
             WHEN weekday = '일요일' THEN 7
         END;