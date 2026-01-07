WITH AVG_SUGAR_DENSITY AS (
  SELECT  AVG(residual_sugar) AS SUGAR_AVG
          ,AVG(density) AS DENSITY_AVG
    FROM  wines
),
AVG_WHITE_PH_ACID AS (
  SELECT  AVG(W.pH) AS PH_AVG
          ,AVG(W.citric_acid) AS ACID_AVG
    FROM  (SELECT  pH
                   ,citric_acid
             FROM  wines
            WHERE  color = 'white') AS W
)
SELECT  *
  FROM  wines
 WHERE  color = 'white'
   AND  quality >= 7
   AND  density > (SELECT DENSITY_AVG FROM AVG_SUGAR_DENSITY)
   AND  residual_sugar > (SELECT SUGAR_AVG FROM AVG_SUGAR_DENSITY)
   AND  pH < (SELECT PH_AVG FROM AVG_WHITE_PH_ACID)
   AND  citric_acid > (SELECT ACID_AVG FROM AVG_WHITE_PH_ACID)