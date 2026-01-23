WITH unioned AS (
  SELECT  user_a_id
          ,user_b_id
    FROM  edges
  
  UNION

  SELECT  user_b_id
          ,user_a_id
    FROM  edges
)
SELECT  u1.user_a_id AS user_a_id
        ,u1.user_b_id AS user_b_id
        ,u2.user_b_id AS user_c_id
  FROM  unioned AS u1
  JOIN  unioned AS u2
    ON  u1.user_b_id = u2.user_a_id
  JOIN  unioned AS u3
    ON  u1.user_a_id = u3.user_a_id
   AND  u2.user_b_id = u3.user_b_id
 WHERE  u1.user_a_id < u1.user_b_id
   AND  u1.user_b_id < u2.user_b_id
   AND  3820 IN (u1.user_a_id, u1.user_b_id, u2.user_b_id);