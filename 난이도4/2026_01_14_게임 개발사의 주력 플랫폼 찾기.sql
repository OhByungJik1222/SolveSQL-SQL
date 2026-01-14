WITH ranked AS (
  SELECT  developer_id
          ,platform_id
          ,SUM(
            COALESCE(sales_na, 0) 
            + COALESCE(sales_eu, 0) 
            + COALESCE(sales_jp, 0)
            + COALESCE(sales_other, 0)
          ) AS sales
          ,DENSE_RANK() OVER (
            PARTITION BY developer_id
            ORDER BY SUM(
              COALESCE(sales_na, 0)
              + COALESCE(sales_eu, 0)
              + COALESCE(sales_jp, 0)
              + COALESCE(sales_other, 0)
            ) DESC
          ) as rnk
    FROM  games
   GROUP
      BY  developer_id, platform_id
)
SELECT  C.name AS developer
        ,P.name AS platform
        ,R.sales
  FROM  ranked AS R
  JOIN  companies AS C
    ON  R.developer_id = C.company_id
  JOIN  platforms AS P
    ON  R.platform_id = P.platform_id
 WHERE  R.rnk = 1;