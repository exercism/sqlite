UPDATE "grade-school"
   SET result = (
     WITH
       list (row_id, student) AS (
         SELECT j.key, JSON_EXTRACT(j.value, '$[0]')
           FROM JSON_EACH(JSON_EXTRACT(input, '$.students')) j
       ),
       duplicates AS (
         SELECT student, COUNT(*) count FROM list GROUP BY student
       ),
       can_add (bool) AS (
         SELECT (count = 1
                 OR row_id = (SELECT MIN(row_id)
                                FROM list
                               WHERE list.student = tbl.student)
                )
           FROM (
             SELECT row_id, student, count
               FROM list LEFT JOIN duplicates USING(student)
           ) tbl
       )
     SELECT JSON_GROUP_ARRAY(JSON(IIF(bool = 1, 'true', 'false')))
       FROM can_add
   )
 WHERE property = 'add'
;

UPDATE "grade-school"
   SET result = (
     WITH rows (student, grade) AS (
       SELECT JSON_EXTRACT(j.value, '$[0]'),
              JSON_EXTRACT(j.value, '$[1]')
         FROM JSON_EACH(JSON_EXTRACT(input, '$.students')) j
     )
     SELECT JSON_GROUP_ARRAY(student)
       FROM (
         SELECT student
           FROM rows
          GROUP BY student
          ORDER BY grade, student
       )
   )
 WHERE property = 'roster'
;

UPDATE "grade-school"
   SET result = (
     WITH list (student, grade) AS (
       SELECT JSON_EXTRACT(j.value, '$[0]'),
              JSON_EXTRACT(j.value, '$[1]')
         FROM JSON_EACH(JSON_EXTRACT(input, '$.students')) j
     )
     SELECT JSON_GROUP_ARRAY(student)
       FROM (
         SELECT student, JSON_GROUP_ARRAY(grade) grades
           FROM list
          GROUP BY student
          ORDER BY student
       )
      WHERE JSON_EXTRACT(grades, '$[0]') =
            JSON_EXTRACT(input, '$.desiredGrade')
   )
 WHERE property = 'grade'
;
