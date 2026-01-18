WITH avgs AS (
  SELECT  species
          ,AVG(flipper_length_mm) AS length_avg
          ,AVG(body_mass_g) AS mass_avg
    FROM  penguins
   GROUP
      BY  species
),
diff AS (
  SELECT  p.species
          ,p.flipper_length_mm - a.length_avg AS length_diff
          ,p.body_mass_g - a.mass_avg AS mass_diff
    FROM  penguins AS p
    LEFT
    JOIN  avgs AS a
      ON  p.species = a.species
)
SELECT  species
        ,ROUND(
          SUM(length_diff * mass_diff) / 
          (SQRT(SUM(POWER(length_diff, 2))) * SQRT(SUM(POWER(mass_diff, 2))))
          , 3) AS corr
  FROM  diff
 GROUP
    BY  species