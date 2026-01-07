SELECT  name AS artist
        ,title
  FROM  artists AS ART
  JOIN  artworks_artists AS AA
    ON  ART.artist_id = AA.artist_id
  JOIN  artworks AS WORK
    ON  AA.artwork_id = WORK.artwork_id
 WHERE  ART.nationality = 'Korean'
   AND  WORK.classification LIKE 'Film%'