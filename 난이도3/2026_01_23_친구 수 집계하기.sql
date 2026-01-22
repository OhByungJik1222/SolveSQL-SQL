WITH union_edge AS (
  SELECT  user_a_id
          ,user_b_id
    FROM  edges
  
UNION ALL

  SELECT  user_b_id
          ,user_a_id
    FROM  edges
),
cnt AS (
  SELECT  user_a_id AS user_id
          ,COUNT(*) AS num_friends
    FROM  union_edge
   GROUP
      BY  user_a_id
)
SELECT  A.user_id
        ,COALESCE(C.num_friends, 0) AS num_friends
  FROM  users AS A
  LEFT
  JOIN  cnt AS C
    ON  A.user_id = C.user_id
 ORDER
    BY  num_friends DESC
        ,user_id ASC;