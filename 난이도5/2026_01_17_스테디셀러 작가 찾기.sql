-- 재귀 O
WITH RECURSIVE author_year AS (
  SELECT  DISTINCT author
          ,year
    FROM  books
   WHERE  genre = 'Fiction'
),
seq AS (
  SELECT  ay.author
          ,ay.year
          ,ay.year AS start_year
          ,1 AS depth
    FROM  author_year AS ay

  UNION ALL

  SELECT  s.author
          ,ay.year
          ,s.start_year
          ,s.depth + 1
    FROM  seq AS s
    JOIN  author_year AS ay
      ON  ay.author = s.author
     AND  ay.year = s.year + 1
)
SELECT  author
        ,MAX(year) AS year
        ,MAX(depth) AS depth
  FROM  seq
 GROUP
    BY  author
HAVING  MAX(depth) >= 5;

-- 재귀 X
-- id에서 연속된 연도는 같은 id를 가지게 된다.
-- ex)
-- 2011, 2012, 2013, 2015 가 있을 때, ROW_NUMBER은 1, 2, 3, 4
-- 따라서 2011 - 1, 2012 - 2, 2013 - 3, 2015 - 4
-- -> 2010, 2010, 2010, 2011 이 되므로
-- MAX(depth) => 3이 된다.
WITH author_year AS (
  SELECT  DISTINCT author
          ,year
    FROM  books
   WHERE  genre = 'Fiction'
),
seq AS (
  SELECT  author
          ,year
          ,year - ROW_NUMBER() OVER (PARTITION BY author ORDER BY year) AS id
    FROM  author_year
),
grouped AS (
  SELECT  author
          ,COUNT(*) AS depth
          ,MIN(year) AS start_year
          ,MAX(year) AS end_year
    FROM  seq
   GROUP
      BY  author, id
)
SELECT  author
        ,end_year AS year
        ,depth
  FROM  grouped
 WHERE  depth >= 5;