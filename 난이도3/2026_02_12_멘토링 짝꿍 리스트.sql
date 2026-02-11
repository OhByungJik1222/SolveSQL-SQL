WITH mentee AS (
  SELECT  employee_id AS mentee_id
          ,name AS mentee_name
          ,department AS mentee_dept
    FROM  employees
   WHERE  TIMESTAMPDIFF(MONTH, join_date, '2021-12-31') < 3
),
mentor AS (
  SELECT  employee_id AS mentor_id
          ,name AS mentor_name
          ,department AS mentor_dept
    FROM  employees
   WHERE  TIMESTAMPDIFF(YEAR, join_date, '2021-12-31') >= 2
)
SELECT  e.mentee_id
        ,e.mentee_name
        ,o.mentor_id
        ,o.mentor_name
  FROM  mentee AS e
  LEFT
  JOIN  mentor AS o
    ON  e.mentee_dept != o.mentor_dept
 ORDER
    BY  e.mentee_id ASC
        ,o.mentor_id ASC