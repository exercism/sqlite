UPDATE "run-length-encoding"
   SET result = ''
 WHERE string = ''
;

UPDATE "run-length-encoding"
   SET result = (
     WITH RECURSIVE rcte (input, chr, next_chr, idx, grp) AS (
       VALUES (string, NULL, NULL, 0, 1)
       UNION ALL
       SELECT SUBSTR(input, 2),
              SUBSTR(input, 1, 1),
              SUBSTR(input, 2, 1),
              idx + 1,
              IIF(chr <> next_chr, grp + 1, grp)
         FROM rcte
        WHERE input <> ''
     )
     SELECT GROUP_CONCAT(PRINTF('%s%s', IIF(cnt = 1, '', cnt), chr), '')
       FROM (
         SELECT COUNT(*) cnt, chr
           FROM rcte
          WHERE chr NOT NULL
          GROUP BY chr, grp
          ORDER BY idx
       )
   )
 WHERE property = 'encode'
   AND string <> ''
;

UPDATE "run-length-encoding"
   SET result = (
     WITH RECURSIVE rcte (input, num, chr) AS (
       VALUES (REPLACE(string, ' ', CHAR(7)), NULL, NULL)
       UNION ALL
       SELECT SUBSTR(LTRIM(input, CAST(input AS INT)), 2),
              CAST(input AS INT),
              SUBSTR(LTRIM(input, CAST(input AS INT)), 1, 1)
         FROM rcte
        WHERE input <> ''
     )
     SELECT REPLACE(GROUP_CONCAT(PRINTF('%.*c', num, chr), ''), CHAR(7), ' ')
       FROM rcte
      WHERE chr NOT NULL
   )
 WHERE property = 'decode'
   AND string <> ''
;

UPDATE "run-length-encoding"
   SET result = (
     WITH RECURSIVE rcte (input, num, chr) AS (
       VALUES (REPLACE(
         (
           WITH RECURSIVE rcte (input, chr, next_chr, idx, grp) AS (
             VALUES (string, NULL, NULL, 0, 1)
             UNION ALL
             SELECT SUBSTR(input, 2),
                    SUBSTR(input, 1, 1),
                    SUBSTR(input, 2, 1),
                    idx + 1,
                    IIF(chr <> next_chr, grp + 1, grp)
               FROM rcte
              WHERE input <> ''
           )
           SELECT GROUP_CONCAT(PRINTF('%s%s', IIF(cnt = 1, '', cnt), chr), '')
             FROM (
               SELECT COUNT(*) cnt, chr
                 FROM rcte
                WHERE chr NOT NULL
                GROUP BY chr, grp
                ORDER BY idx
             )
         ), ' ', CHAR(7)), NULL, NULL)
         UNION ALL
         SELECT SUBSTR(LTRIM(input, CAST(input AS INT)), 2),
                CAST(input AS INT),
                SUBSTR(LTRIM(input, CAST(input AS INT)), 1, 1)
           FROM rcte
          WHERE input <> ''
     )
     SELECT REPLACE(GROUP_CONCAT(PRINTF('%.*c', num, chr), ''), CHAR(7), ' ')
       FROM rcte
      WHERE chr NOT NULL
   )
 WHERE property = 'consistency'
;
