WITH USER_FRIEND_CNT AS (
    SELECT  user_a_id AS user_id
            ,COUNT(*) AS FRIEND_CNT
      FROM  edges
     GROUP
        BY  user_a_id

    UNION ALL

    SELECT  user_b_id AS user_id
            ,COUNT(*) AS FRIEND_CNT
      FROM  edges
     GROUP
        BY  user_b_id
),
INFLUENCER AS (
    SELECT  user_id
            ,SUM(FRIEND_CNT) AS friends
      FROM  USER_FRIEND_CNT
     GROUP
        BY  user_id
    HAVING  SUM(FRIEND_CNT) >= 100
),
CANDIDATE_FRIENDS AS (
    SELECT  e.user_a_id AS candidate_id
            ,e.user_b_id AS friend_id
      FROM  edges AS e
     INNER
      JOIN  INFLUENCER AS inf
        ON  e.user_a_id = inf.user_id

    UNION ALL

    SELECT  e.user_b_id AS candidate_id
            ,e.user_a_id AS friend_id
      FROM  edges AS e
     INNER
      JOIN  INFLUENCER AS inf
        ON  e.user_b_id = inf.user_id
),
FRIENDS_OF_FRIENDS_SUM AS (
    SELECT  cf.candidate_id
            ,SUM(ufc.FRIEND_CNT) AS friends_of_friends
      FROM  CANDIDATE_FRIENDS AS cf
     INNER
      JOIN  USER_FRIEND_CNT AS ufc
        ON  cf.friend_id = ufc.user_id
     GROUP
        BY  cf.candidate_id
)
SELECT  inf.user_id
        ,inf.friends
        ,fof.friends_of_friends
        ,ROUND(CAST(fof.friends_of_friends AS FLOAT)/inf.friends,2) AS ratio
  FROM  INFLUENCER AS inf
 INNER
  JOIN  FRIENDS_OF_FRIENDS_SUM AS fof
    ON  inf.user_id = fof.candidate_id
 ORDER
    BY  ratio DESC
 LIMIT  5;