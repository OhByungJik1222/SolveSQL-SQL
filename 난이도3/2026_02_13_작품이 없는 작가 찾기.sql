WITH dead_artists AS (
  SELECT  a.artist_id
          ,a.name
          ,b.artwork_id
    FROM  artists AS a
    LEFT
    JOIN  artworks_artists AS b
      ON  a.artist_id = b.artist_id
  WHERE  a.death_year IS NOT NULL
)
SELECT  DISTINCT artist_id
        ,name
  FROM  dead_artists
 WHERE  artwork_id IS NULL;