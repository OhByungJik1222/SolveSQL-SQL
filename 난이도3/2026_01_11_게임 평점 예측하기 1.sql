WITH AVG_INFO AS (
  SELECT  genre_id
          ,ROUND(AVG(critic_score), 3) AS AVG_CS
          ,CEIL(AVG(critic_count)) AS AVG_CC
          ,ROUND(AVG(user_score), 3) AS AVG_US
          ,CEIL(AVG(user_count)) AS AVG_UC
    FROM  games
   GROUP
      BY  genre_id
),
NULL_GAMES AS (
  SELECT  game_id
          ,genre_id
          ,name
          ,critic_score
          ,critic_count
          ,user_score
          ,user_count
    FROM  games
   WHERE  year >= 2015
     AND  (critic_score IS NULL
      OR   critic_count IS NULL
      OR   user_score IS NULL
      OR   user_count IS NULL)
)
SELECT  A.game_id
        ,A.name
        ,IFNULL(A.critic_score, B.AVG_CS) AS critic_score
        ,IFNULL(A.critic_count, B.AVG_CC) AS critic_count
        ,IFNULL(A.user_score, B.AVG_US) AS user_score
        ,IFNULL(A.user_count, B.AVG_UC) AS user_count
  FROM  NULL_GAMES AS A
  JOIN  AVG_INFO AS B
    ON  A.genre_id = B.genre_id