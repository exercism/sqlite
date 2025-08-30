UPDATE "ocr-numbers"
   SET error = 'Number of input lines is not a multiple of four'
 WHERE (LENGTH(input) - LENGTH(REPLACE(input, CHAR(10), '')) + 1) % 4 != 0
;
UPDATE "ocr-numbers"
   SET error = 'Number of input columns is not a multiple of three'
 WHERE LENGTH(REPLACE(input, CHAR(10), '')) % 3 != 0
;


DROP TABLE IF EXISTS dict;
CREATE TEMPORARY TABLE dict AS
WITH RECURSIVE rcte (string, idx, font, digit) AS (
  VALUES (
    (WITH cte (fonts) AS (
      VALUES
      ('    _  _     _  _  _  _  _  _ '),
      ('  | _| _||_||_ |_   ||_||_|| |'),
      ('  ||_  _|  | _||_|  ||_| _||_|'),
      ('                              '))
    SELECT GROUP_CONCAT(fonts, CHAR(10)) FROM cte),
    1, NULL, 0
  )
  UNION ALL
  SELECT string,
         idx + 3,
         REPLACE(
           PRINTF('%s\n%s\n%s\n%s',
             SUBSTR(string, INSTR(string, CHAR(10)) * 0 + idx, 3),
             SUBSTR(string, INSTR(string, CHAR(10)) * 1 + idx, 3),
             SUBSTR(string, INSTR(string, CHAR(10)) * 2 + idx, 3),
             SUBSTR(string, INSTR(string, CHAR(10)) * 3 + idx, 3)
           ),
           '\n',
           CHAR(10)
         ),
         IIF(digit + 1 = 10, 0, digit + 1)
    FROM rcte
   WHERE idx < 30
) SELECT font, digit FROM rcte WHERE font NOTNULL;

UPDATE "ocr-numbers"
   SET result = (
         WITH
           split_lines AS (
             WITH RECURSIVE rcte (string, idx, line) AS (
               VALUES (input, 0, NULL)
               UNION ALL
               SELECT string,
                      idx + 4,
                      LTRIM(
                        PRINTF(
                          '%s%s%s%s',
                          SUBSTR(
                            string,
                            INSTR(string, char(10)) * (idx + 0),
                            INSTR(string, char(10))
                          ),
                          SUBSTR(
                            string,
                            INSTR(string, char(10)) * (idx + 1),
                            INSTR(string, char(10))
                          ),
                          SUBSTR(
                            string,
                            INSTR(string, char(10)) * (idx + 2),
                            INSTR(string, char(10))
                          ),
                          SUBSTR(
                            string,
                            INSTR(string, char(10)) * (idx+3),
                            INSTR(string, char(10))
                          )
                        ),
                        CHAR(10)
                      )
                 FROM rcte
                 WHERE idx <=
                       LENGTH(string) - LENGTH(replace(string, char(10),''))
            ) SELECT line FROM rcte WHERE line NOTNULL
          ),
          converter AS (
            SELECT line,
                   (WITH RECURSIVE split_numbers (string, idx, font) AS (
                     VALUES (line, 1, NULL)
                     UNION ALL
                     SELECT string,
                            idx + 3,
                            REPLACE(
                              PRINTF(
                                '%s\n%s\n%s\n%s',
                                SUBSTR(
                                  string,
                                  INSTR(string, CHAR(10)) * 0 + idx, 3
                                ),
                                SUBSTR(
                                  string,
                                  INSTR(string, CHAR(10)) * 1 + idx, 3
                                ),
                                SUBSTR(
                                  string,
                                  INSTR(string, CHAR(10)) * 2 + idx, 3
                                ),
                                SUBSTR(
                                  string,
                                  INSTR(string, CHAR(10)) * 3 + idx, 3
                                )
                              ),
                              '\n',
                              CHAR(10)
                            )
               FROM split_numbers
               WHERE idx < (SELECT INSTR(string, CHAR(10)))
           )
           SELECT GROUP_CONCAT(digit, '') AS number
             FROM (
               SELECT COALESCE(
                        (SELECT digit
                           FROM dict
                          WHERE dict.font = split_numbers.font),
                          '?'
                      ) AS digit
                 FROM split_numbers WHERE font NOTNULL
             )
                   ) AS number
              FROM split_lines
          ) SELECT GROUP_CONCAT(number) AS number FROM converter
   )
 WHERE error ISNULL
;
