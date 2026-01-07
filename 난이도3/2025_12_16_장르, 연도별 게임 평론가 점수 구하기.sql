SELECT  GEN.name AS genre
        ,ROUND(AVG(CASE WHEN year = 2011 THEN GAM.critic_score END), 2) as score_2011
        ,ROUND(AVG(CASE WHEN year = 2012 THEN GAM.critic_score END), 2) as score_2012
        ,ROUND(AVG(CASE WHEN year = 2013 THEN GAM.critic_score END), 2) as score_2013
        ,ROUND(AVG(CASE WHEN year = 2014 THEN GAM.critic_score END), 2) as score_2014
        ,ROUND(AVG(CASE WHEN year = 2015 THEN GAM.critic_score END), 2) as score_2015
  FROM  games as GAM
  JOIN  genres as GEN
    ON  GAM.genre_id = GEN.genre_id
 WHERE  GAM.critic_score IS NOT NULL 
 GROUP
    BY  GEN.name;