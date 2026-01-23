WITH flow AS (
  SELECT  YEAR(acquisition_date) AS year
          ,COUNT(*) AS flow_cnt
    FROM  artworks
   WHERE  acquisition_date IS NOT NULL
   GROUP
      BY  YEAR(acquisition_date)
)
SELECT  year AS 'Acquisition year'
        ,flow_cnt AS 'New acquisitions this year (Flow)'
        ,SUM(flow_cnt) OVER (
          ORDER BY year
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS 'Total collection size (Stock)'
  FROM  flow
 ORDER
    BY  year;