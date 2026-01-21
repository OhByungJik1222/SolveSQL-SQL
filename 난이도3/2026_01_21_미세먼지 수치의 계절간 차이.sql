WITH add_season AS (
  SELECT  measured_at
          ,pm10
          ,CASE WHEN MONTH(measured_at) BETWEEN 3 AND 5 THEN 'spring'
                WHEN MONTH(measured_at) BETWEEN 6 AND 8 THEN 'summer'
                WHEN MONTH(measured_at) BETWEEN 9 AND 11 THEN 'autumn'
                ELSE 'winter'
           END AS season
    FROM measurements
),
add_rnk AS (
  SELECT  season
          ,pm10
          ,ROW_NUMBER() OVER (PARTITION BY season ORDER BY pm10) AS rnk_asc
          ,COUNT(*) OVER (PARTITION BY season) AS cnt
    FROM  add_season
),
calculate_median AS (
  SELECT  season
          ,AVG(pm10) AS median
    FROM  add_rnk
   WHERE  rnk_asc IN (FLOOR((cnt + 1) / 2), CEIL((cnt + 1) / 2)) 
   GROUP
      BY  season
)
SELECT  A.season
        ,M.median AS pm10_median
        ,ROUND(AVG(pm10), 2) AS pm10_average
  FROM  add_season AS A
  LEFT
  JOIN  calculate_median AS M
    ON  A.season = M.season
 GROUP
    BY  A.season