SELECT  DATE_FORMAT(measured_at, '%Y-%m-%d') AS good_day
  FROM  measurements
 WHERE  LEFT(measured_at, 7) = '2022-12'
   AND  pm2_5 <= 9
 ORDER
    BY  measured_at;