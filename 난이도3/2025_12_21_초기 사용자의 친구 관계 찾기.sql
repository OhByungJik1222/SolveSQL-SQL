WITH SUM_RN AS (
  SELECT  user_a_id
          ,user_b_id
          ,SUM(user_a_id + user_b_id) AS id_sum
          ,ROW_NUMBER() OVER (ORDER BY SUM(user_a_id + user_b_id)) as RN
    FROM  edges
   GROUP
      BY  user_a_id, user_b_id
  )
SELECT  user_a_id
        ,user_b_id
        ,id_sum
  FROM  SUM_RN
 WHERE  RN / (SELECT COUNT(*) FROM SUM_RN) * 100 < 0.1