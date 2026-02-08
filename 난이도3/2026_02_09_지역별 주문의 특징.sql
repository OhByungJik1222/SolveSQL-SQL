WITH grouped AS (
  SELECT  order_id
          ,region
          ,category
    FROM  records
   GROUP
      BY  order_id
          ,region
          ,category
)
SELECT  region AS Region
        ,SUM(
          CASE WHEN category = 'Furniture' THEN 1
               ELSE 0 END
        ) AS Furniture
        ,SUM(
          CASE WHEN category = 'Office Supplies' THEN 1
               ELSE 0 END
        ) AS `Office Supplies`
        ,SUM(
          CASE WHEN category = 'Technology' THEN 1
               ELSE 0 END
        ) AS Technology
  FROM  grouped
 GROUP
    BY  region
 ORDER
    BY  Region;