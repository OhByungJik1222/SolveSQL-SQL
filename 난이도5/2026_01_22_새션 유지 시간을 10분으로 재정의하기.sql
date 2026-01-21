WITH particular_user AS (
  SELECT  user_pseudo_id
          ,event_timestamp_kst
          ,event_name
          ,ga_session_id
    FROM  ga
   WHERE  user_pseudo_id = 'a8Xu9GO6TB'
),
add_prev AS (
  SELECT  user_pseudo_id
          ,event_timestamp_kst
          ,event_name
          ,ga_session_id
          ,LAG(event_timestamp_kst) OVER (
            ORDER BY event_timestamp_kst
          ) AS prev
    FROM  particular_user
),
is_over10 AS (
  SELECT  *
          ,CASE WHEN prev IS NULL THEN 1
                WHEN TIMESTAMPDIFF(
                  MINUTE
                  ,prev
                  ,event_timestamp_kst
                ) > 10 THEN 1
                ELSE 0
           END AS is_new
    FROM  add_prev
),
add_new AS (
  SELECT  *
          ,SUM(is_new) OVER (
            ORDER BY event_timestamp_kst
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
          ) AS new_session_id
    FROM is_over10
)
SELECT  user_pseudo_id
        ,event_timestamp_kst
        ,event_name
        ,ga_session_id
        ,new_session_id
  FROM  add_new
 ORDER
    BY  event_timestamp_kst;