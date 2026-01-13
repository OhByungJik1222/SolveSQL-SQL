SELECT
    classification,
    SUM(CASE WHEN YEAR(acquisition_date) = 2014 THEN 1 ELSE 0 END) AS `2014`,
    SUM(CASE WHEN YEAR(acquisition_date) = 2015 THEN 1 ELSE 0 END) AS `2015`,
    SUM(CASE WHEN YEAR(acquisition_date) = 2016 THEN 1 ELSE 0 END) AS `2016`
FROM artworks
GROUP BY classification
ORDER BY classification;

--------------------------------------------------------------------------------

WITH artworks_2014 AS (
  SELECT  classification
          ,COUNT(*) AS cnt_2014
    FROM  artworks
   WHERE  YEAR(acquisition_date) = 2014
   GROUP
      BY  classification 
),
artworks_2015 AS (
  SELECT  classification
          ,COUNT(*) AS cnt_2015
    FROM  artworks
   WHERE  YEAR(acquisition_date) = 2015
   GROUP
      BY  classification 
),
artworks_2016 AS (
  SELECT  classification
          ,COUNT(*) AS cnt_2016
    FROM  artworks
   WHERE  YEAR(acquisition_date) = 2016
   GROUP
      BY  classification 
)
SELECT  A.classification
        ,IFNULL(B.cnt_2014, 0) AS '2014'
        ,IFNULL(C.cnt_2015, 0) AS '2015'
        ,IFNULL(D.cnt_2016, 0) AS '2016'
  FROM  (SELECT DISTINCT(classification) FROM artworks) AS A
  LEFT
  JOIN  artworks_2014 AS B
    ON  A.classification = B.classification
  LEFT
  JOIN  artworks_2015 AS C
    ON  A.classification = C.classification
  LEFT
  JOIN  artworks_2016 AS D
    ON  A.classification = D.classification
 ORDER
    BY  A.classification