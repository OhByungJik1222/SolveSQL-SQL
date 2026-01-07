SELECT  title
  FROM  film
 WHERE  rating IN ('R', 'NC-17')
   AND  RIGHT(title, 1) NOT IN ('A', 'a', 'E', 'e', 'I', 'i', 'O', 'o', 'U', 'u')