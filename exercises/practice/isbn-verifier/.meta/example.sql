UPDATE "isbn-verifier"
   SET result = FALSE
 WHERE GLOB(
         '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9X]',
         REPLACE(isbn, '-', '')
       ) = 0
;

UPDATE "isbn-verifier"
   SET result = (
     SUBSTRING(REPLACE(isbn,'-', ''), -10, 1) * 10 +
     SUBSTRING(REPLACE(isbn,'-', ''),  -9, 1) *  9 +
     SUBSTRING(REPLACE(isbn,'-', ''),  -8, 1) *  8 +
     SUBSTRING(REPLACE(isbn,'-', ''),  -7, 1) *  7 +
     SUBSTRING(REPLACE(isbn,'-', ''),  -6, 1) *  6 +
     SUBSTRING(REPLACE(isbn,'-', ''),  -5, 1) *  5 +
     SUBSTRING(REPLACE(isbn,'-', ''),  -4, 1) *  4 +
     SUBSTRING(REPLACE(isbn,'-', ''),  -3, 1) *  3 +
     SUBSTRING(REPLACE(isbn,'-', ''),  -2, 1) *  2 +
     IIF(
       SUBSTRING(REPLACE(isbn,'-', ''), -1, 1) = 'X',
       10,
       SUBSTRING(REPLACE(isbn,'-', ''), -1, 1)
     )
   ) % 11 = 0
 WHERE result ISNULL
;
