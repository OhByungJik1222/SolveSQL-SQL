WITH FICTION_BOOKS AS (
    SELECT  author
            ,user_rating
            ,reviews
      FROM  books
     WHERE  genre = 'Fiction'
),
FICTION_AUTHOR_STATS AS (
    SELECT  author
            ,AVG(user_rating) AS AVG_FICTION_RATING
            ,AVG(reviews) AS AVG_FICTION_REVIEWS
      FROM  FICTION_BOOKS
     GROUP 
        BY  author
),
FICTION_GLOBAL_AVG AS (
    SELECT  AVG(reviews) AS GLOBAL_FICTION_AVG
      FROM  FICTION_BOOKS
),
AUTHORS AS (
    SELECT  author
            ,COUNT(*) AS TOTAL_BOOKS
      FROM  books
     GROUP 
        BY  author
)
SELECT  F.AUTHOR
  FROM  FICTION_AUTHOR_STATS AS F
  JOIN  FICTION_GLOBAL_AVG AS G
    ON  F.AVG_FICTION_REVIEWS >= G.GLOBAL_FICTION_AVG
  JOIN  AUTHORS AS A
    ON  F.author = A.author
 WHERE  A.TOTAL_BOOKS >= 2        -- Top 50에 최소 두 작품 등록
   AND  F.AVG_FICTION_RATING >= 4.5     -- Fiction 평균 평점 4.5 이상
 ORDER  
    BY  F.author ASC;
