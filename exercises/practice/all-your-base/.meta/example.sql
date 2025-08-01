UPDATE "all-your-base"
   SET result = JSON_OBJECT('error', 'input base must be >= 2')
 WHERE input_base < 2
   AND result = ''
;
UPDATE "all-your-base"
   SET result = JSON_OBJECT('error', 'output base must be >= 2')
 WHERE output_base < 2
   AND result = ''
;
UPDATE "all-your-base"
   SET result = JSON_OBJECT(
     'error', 'all digits must satisfy 0 <= d < input base'
   )
 WHERE (
   SELECT COUNT(*)
     FROM (
       SELECT input_base, j.VALUE AS digit
         FROM JSON_EACH(digits) j
     )
    WHERE digit < 0 OR digit >= input_base
 ) != 0
   AND result = ''
;

UPDATE "all-your-base"
   SET result = JSON_ARRAY(0)
 WHERE (
   SELECT COUNT(v)
     FROM (
       SELECT j.VALUE v FROM JSON_EACH(digits) j
     )
    WHERE v != 0
 ) = 0
   AND result = ''
       ;

UPDATE "all-your-base"
   SET result = (
     WITH RECURSIVE rcte (n, d) AS (
       VALUES((
         SELECT
           CAST(SUM(digit * POW(input_base, row_number - 1)) AS INTEGER)
           FROM (
             SELECT row_number() over() AS row_number, *
               FROM (
                 SELECT j.VALUE AS digit
                   FROM json_each(digits) j
                  ORDER BY rowid DESC
               )
           )
       ), -1)
       UNION ALL
       SELECT
         CAST(n % pow(10, CAST(log10(n) AS INT)) AS INT),
         CAST(n / pow(10, CAST(log10(n) AS INT)) AS INT)
       FROM rcte
       WHERE n != 0
     )
     SELECT JSON_GROUP_ARRAY(d) FROM rcte WHERE d > -1
   )
 WHERE output_base = 10
   AND result = ''
       ;

UPDATE "all-your-base"
   SET result = (
     WITH RECURSIVE rcte (n, d) AS (
       VALUES((
         SELECT GROUP_CONCAT(j.VALUE, '') * 1
           FROM JSON_EACH(digits) j
       ), -1)
       UNION ALL
       SELECT n / output_base, n % output_base
       FROM rcte
       WHERE n > 0
     )
     SELECT JSON_GROUP_ARRAY(d)
       FROM (
         SELECT d
           FROM rcte
          WHERE d > -1
          ORDER BY row_number() OVER () DESC
       )
   )
 WHERE input_base = 10
   AND result = ''
       ;

UPDATE "all-your-base"
   SET result = (
     WITH RECURSIVE rcte (n, d) AS (
       VALUES((
         SELECT
           CAST(SUM(digit * POW(input_base, row_number - 1)) AS INTEGER)
           FROM (
             SELECT row_number() over() AS row_number, *
               FROM (
                 SELECT j.VALUE AS digit
                   FROM json_each(digits) j
                  ORDER BY rowid DESC
               )
           )
       ), -1)
       UNION ALL
       SELECT n / output_base, n % output_base
       FROM rcte
       WHERE n > 0
     )
     SELECT JSON_GROUP_ARRAY(d)
       FROM (
         SELECT d
           FROM rcte
          WHERE d > -1
          ORDER BY row_number() OVER () DESC
       )
   )
 WHERE input_base  != 10
   AND output_base != 10
   AND result       = ''
;
