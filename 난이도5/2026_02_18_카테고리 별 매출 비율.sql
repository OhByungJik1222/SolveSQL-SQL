WITH sub_sales AS (
  SELECT  category
          ,sub_category
          ,SUM(sales) AS sales_sub_category
    FROM  records
  GROUP
      BY  category
          ,sub_category
),
cat_sales AS (
  SELECT  category
          ,SUM(sales) AS sales_category
    FROM  records
   GROUP
      BY  category
),
joined AS (
  SELECT  s.category
          ,s.sub_category
          ,s.sales_sub_category
          ,c.sales_category
    FROM  sub_sales AS s
    JOIN  cat_sales AS c
      ON  s.category = c.category
)
SELECT  category
        ,sub_category
        ,ROUND(sales_sub_category, 2) AS sales_sub_category
        ,ROUND(sales_category, 2) AS sales_category
        ,ROUND((SELECT SUM(sales) FROM records), 2) AS sales_total
        ,ROUND(sales_sub_category / sales_category * 100, 2) AS pct_in_category
        ,ROUND(sales_sub_category / (SELECT SUM(sales) FROM records) * 100, 2) AS pct_in_total
  FROM  joined