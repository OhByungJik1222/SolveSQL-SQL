SELECT  a.station_id
        ,a.name
  FROM  station AS a
  JOIN  station AS b
    ON  a.station_id <> b.station_id
   AND  a.updated_at < b.updated_at
   AND  2 * 6356 * ASIN(
          SQRT(
            POWER(SIN((RADIANS(a.lat) - RADIANS(b.lat)) / 2), 2) +
            COS(RADIANS(a.lat)) * COS(RADIANS(b.lat)) *
            POWER(SIN((RADIANS(a.lng) - RADIANS(b.lng)) / 2), 2)
          )
        ) <= 0.3
 GROUP
    BY  a.station_id
        ,a.name
HAVING  COUNT(*) >= 5;