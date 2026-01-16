WITH USAGE_2018 AS (
    SELECT  station_id
            ,COUNT(*) AS cnt_2018
      FROM  (
            SELECT  rent_station_id AS station_id
              FROM  rental_history
             WHERE  rent_at >= '2018-10-01'
               AND  rent_at <  '2018-11-01'

            UNION ALL

            SELECT  return_station_id AS station_id
              FROM  rental_history
             WHERE  rent_at >= '2018-10-01'
               AND  rent_at <  '2018-11-01'
            ) AS A
     GROUP
        BY  station_id
),
USAGE_2019 AS (
    SELECT  station_id
            ,COUNT(*) AS cnt_2019
      FROM  (
            SELECT  rent_station_id AS station_id
              FROM  rental_history
             WHERE  rent_at >= '2019-10-01'
               AND  rent_at <  '2019-11-01'

            UNION ALL

            SELECT  return_station_id AS station_id
              FROM  rental_history
             WHERE  rent_at >= '2019-10-01'
               AND  rent_at <  '2019-11-01'
            ) AS B
     GROUP
        BY  station_id
)
SELECT  S.station_id
        ,S.name
        ,S.local
        ,ROUND(U19.cnt_2019 / U18.cnt_2018 * 100, 2) AS usage_pct
  FROM  USAGE_2018 AS U18
  JOIN  USAGE_2019 AS U19
    ON  U18.station_id = U19.station_id
  JOIN  station AS S
    ON  U18.station_id = S.station_id
 WHERE  U18.cnt_2018 > 0
   AND  U19.cnt_2019 > 0
   AND  U19.cnt_2019 / U18.cnt_2018 <= 0.5
 ORDER
    BY  usage_pct;