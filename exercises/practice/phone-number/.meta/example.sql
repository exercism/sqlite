DROP TABLE IF EXISTS cleanup;
CREATE TEMPORARY TABLE cleanup (
    string TEXT PRIMARY KEY,
    digits TEXT
);
INSERT INTO cleanup (string, digits)
SELECT phrase,
       (WITH RECURSIVE to_digits (string, chr) AS (
         VALUES (phrase, NULL)
         UNION ALL
         SELECT SUBSTR(string, 2),
                IIF(
                  UNICODE(string) BETWEEN UNICODE(0) AND UNICODE(9),
                  SUBSTR(string, 1, 1),
                  NULL
                )
           FROM to_digits
          WHERE string <> ''
       )
       SELECT GROUP_CONCAT(chr, '') AS digits
         FROM to_digits
       )
  FROM "phone-number"
;

UPDATE "phone-number" AS pn
   SET error = (
       CASE
       WHEN LENGTH(digits) < 10
         THEN
           CASE
           WHEN GLOB('*[A-Za-z]*', phrase) THEN 'letters not permitted'
           WHEN REGEXP('[!"#$%&''()*,./:;<=>?@\[\\\]^_`\{|\}~]', phrase)
             THEN 'punctuations not permitted'
           ELSE 'must not be fewer than 10 digits'
           END
       WHEN LENGTH(digits) > 11 THEN 'must not be greater than 11 digits'
       WHEN LENGTH(digits) = 11 AND NOT GLOB('1*', digits)
         THEN '11 digits must start with 1'
       WHEN SUBSTR(digits, -10, 1) = '0'
         THEN 'area code cannot start with zero'
       WHEN SUBSTR(digits, -10, 1) = '1'
         THEN 'area code cannot start with one'
       WHEN SUBSTR(digits, -7, 1) = '0'
         THEN 'exchange code cannot start with zero'
       WHEN SUBSTR(digits, -7, 1) = '1'
         THEN 'exchange code cannot start with one'
       END
       )
  FROM cleanup AS cl
 WHERE pn.phrase = cl.string
;

UPDATE "phone-number" AS pn
   SET result = SUBSTR(digits, -10)
  FROM cleanup AS cl
 WHERE pn.phrase = cl.string
   AND pn.error ISNULL
;
