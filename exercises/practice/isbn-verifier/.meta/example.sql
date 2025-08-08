UPDATE "isbn-verifier"
   SET result = FALSE
 WHERE GLOB('[0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9]-[0-9X]', isbn) = 0
   AND GLOB('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9X]'   , isbn) = 0
;

UPDATE "isbn-verifier"
   SET result = (
     WITH RECURSIVE verifier(isbn, digit, pos) AS (
       VALUES((
         WITH RECURSIVE cleaner(string, char) AS (
           VALUES(isbn, '')
           UNION ALL
           SELECT SUBSTRING(string, 2), SUBSTRING(string, 1, 1)
             FROM cleaner
            WHERE string <> ''
         )
         SELECT GROUP_CONCAT(char, '')
           FROM cleaner WHERE GLOB('[0-9X]', char)
       ), '', 11)
       UNION ALL
       SELECT
         SUBSTRING(isbn, 2),
         IIF(SUBSTRING(isbn, 1, 1) = 'X', 10, SUBSTRING(isbn, 1, 1)),
         pos - 1
         FROM verifier
        WHERE isbn <> ''
     ) SELECT SUM(digit * pos) % 11 = 0 FROM verifier WHERE digit <> ''
   )
 WHERE result ISNULL
;
