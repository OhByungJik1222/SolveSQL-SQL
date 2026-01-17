WITH games_2012 AS (
  SELECT  G.name AS game_name
          ,CASE WHEN P.name IN ('PS3', 'PS4', 'PSP', 'PSV') THEN 'Sony'
                WHEN P.name IN ('Wii', 'WiiU', 'DS', '3DS') THEN 'Nintendo'
                WHEN P.name IN ('X360', 'XONE') THEN 'Microsoft'
                ELSE 'Other'
            END AS company_name
    FROM  games AS G
    LEFT
    JOIN  platforms AS P
      ON  G.platform_id = P.platform_id
   WHERE  G.year >= 2012
   GROUP
      BY  game_name, company_name
),
major_company AS (
  SELECT  game_name
          ,CASE WHEN company_name != 'Other' THEN 1
                ELSE 0
            END AS is_major
    FROM  games_2012
)
SELECT  game_name AS name
  FROM  major_company
 GROUP
    BY  game_name
HAVING  SUM(is_major) >= 2;