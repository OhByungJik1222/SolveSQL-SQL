WITH prev AS (
  SELECT  user_pseudo_id,
          event_timestamp_kst,
          LAG(event_timestamp_kst) OVER (
              PARTITION BY user_pseudo_id
              ORDER BY event_timestamp_kst
          ) AS prev_time
    FROM  ga
   WHERE  user_pseudo_id = 'S3WDQCqLpK'
),
is_over AS (
  SELECT  *,
          CASE WHEN prev_time IS NULL THEN 1
               WHEN TIMESTAMPDIFF(
                 MINUTE
                 ,prev_time
                 ,event_timestamp_kst
               ) > 60 THEN 1
               ELSE 0 
          END AS is_new_session
    FROM  prev
),
session_idx AS (
  SELECT  *,
          SUM(is_new_session) OVER (
              ORDER BY event_timestamp_kst
          ) AS session_id
    FROM  is_over
)
SELECT  user_pseudo_id,
        MIN(event_timestamp_kst) AS session_start,
        MAX(event_timestamp_kst) AS session_end
  FROM  session_idx
 GROUP 
    BY  user_pseudo_id
        ,session_id
 ORDER 
    BY  session_start;
