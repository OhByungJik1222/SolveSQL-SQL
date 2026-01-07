WITH GIFT_CNT AS (
  SELECT  COUNT(*) AS gift_cnt
    FROM  artworks
   WHERE  LOWER(credit) LIKE '%gift%'
)
SELECT  ROUND((SELECT gift_cnt FROM GIFT_CNT) / COUNT(*) * 100, 3) AS ratio
  FROM  artworks;