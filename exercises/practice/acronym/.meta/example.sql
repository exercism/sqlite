UPDATE acronym
   SET result = (
     WITH RECURSIVE
       rcte(string, abbr) AS (
         VALUES(' ' || phrase, '')
         UNION ALL
         SELECT
           SUBSTR(string,2),
           abbr ||
           CASE
           WHEN GLOB('[ _-]',    SUBSTR(string, 1, 1))
            AND GLOB('[A-Za-z]', SUBSTR(string, 2, 1))
           THEN SUBSTR(string, 2, 1)
         ELSE ''
         END
         FROM rcte
         WHERE string GLOB '*[ _-]*'
       )
     SELECT UPPER(abbr) FROM rcte WHERE string NOT GLOB '*[ _-]*'
   );
