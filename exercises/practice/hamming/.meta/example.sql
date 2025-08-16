UPDATE hamming
   SET result = (
     WITH RECURSIVE rcte(string1, string2, char1, char2) AS (
       VALUES(strand1, strand2, '', '')
       UNION ALL
       SELECT SUBSTRING(string1, 2),    SUBSTRING(string2, 2),
              SUBSTRING(string1, 1, 1), SUBSTRING(string2, 1, 1)
         FROM rcte
        WHERE string1 <> ''
     )
     SELECT COUNT(*)
       FROM rcte
      WHERE char1 != char2
);
