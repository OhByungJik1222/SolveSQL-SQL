SELECT  YEAR(purchased_at) as year
        ,SUM(CASE WHEN shipping_method = 'Standard' THEN 1 END) +
         SUM(CASE WHEN is_returned = 1 THEN 1 END) AS standard
        ,SUM(CASE WHEN shipping_method = 'Express' THEN 1 END) AS express
        ,SUM(CASE WHEN shipping_method = 'Overnight' THEN 1 END) AS overnight
  FROM  transactions
 WHERE  is_online_order = 1
 GROUP
    BY  YEAR(purchased_at)
 ORDER
    BY  year