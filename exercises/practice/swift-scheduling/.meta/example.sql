UPDATE "swift-scheduling"
   SET result =
       STRFTIME('%Y-%m-%dT%H:%M:%S', DATETIME(meeting_start, '+2 HOUR'))
 WHERE date_description = 'NOW'
;

UPDATE "swift-scheduling"
   SET result = STRFTIME(
     '%Y-%m-%dT%H:%M:%S',
     IIF(
       TIME(meeting_start) < TIME('13:00'),
       DATETIME(meeting_start, 'START OF DAY', '+17 HOUR'),
       DATETIME(meeting_start, '+1 DAY', 'START OF DAY', '+13 HOUR')
     )
   )
 WHERE date_description = 'ASAP'
;

UPDATE "swift-scheduling"
   SET result = STRFTIME(
     '%Y-%m-%dT%H:%M:%S',
       IIF(
         STRFTIME('%u', meeting_start) * 1  BETWEEN 1 AND 3,
         DATETIME(meeting_start, 'WEEKDAY 5', 'START OF DAY', '+17 HOUR'),
         DATETIME(meeting_start, 'WEEKDAY 0', 'START OF DAY', '+20 HOUR')
       )
   )
 WHERE date_description = 'EOW'
;

UPDATE "swift-scheduling"
   SET result = (
     WITH cte (date_time) AS (
       SELECT
         IIF(
           STRFTIME('%m', meeting_start) * 1 <
           REPLACE(date_description, 'D', '') * 1,
           DATETIME(
             meeting_start,
             'START OF YEAR',
             PRINTF('+%d MONTH', REPLACE(date_description, 'D', '') - 1),
             '+8 HOUR'
           ),
           DATETIME(
             meeting_start,
             'START OF YEAR',
             '+1 YEAR',
             PRINTF('+%d MONTH', REPLACE(date_description, 'D', '') - 1),
             '+8 HOUR'
           )
         )
     )
     SELECT STRFTIME(
       '%Y-%m-%dT%H:%M:%S',
       IIF(
         STRFTIME('%u', date_time) * 1 IN (6, 7),
         DATETIME(date_time, 'WEEKDAY 1'),
         date_time
       )
     )
       FROM cte
   )
 WHERE SUBSTRING(date_description, -1) = 'M';

DROP TABLE IF EXISTS quarters;
CREATE TEMPORARY TABLE quarters (
    quarter INTEGER NOT NULL,
    month   INTEGER UNIQUE NOT NULL
);
INSERT INTO quarters
VALUES (1,  1), (1,  2), (1,  3),
       (2,  4), (2,  5), (2,  6),
       (3,  7), (3,  8), (3,  9),
       (4, 10), (4, 11), (4, 12);

UPDATE "swift-scheduling"
   SET result = (
     WITH cte (date_time) AS (
       SELECT
         IIF(
           (SELECT quarter <= SUBSTRING(date_description, 2, 1) * 1
              FROM quarters
             WHERE month = STRFTIME('%m', meeting_start) * 1
           ),
           DATETIME(
             meeting_start,
             'START OF YEAR',
             (SELECT PRINTF('+%d MONTH', month)
                FROM quarters
               WHERE quarter = SUBSTRING(date_description, 2, 1) * 1
               ORDER BY month DESC
               LIMIT 1
             ),
             '-1 DAY',
             '+8 HOUR'
           ),
           DATETIME(
             meeting_start,
             'START OF YEAR',
             '+1 YEAR',
             (SELECT PRINTF('+%d MONTH', month)
                FROM quarters
               WHERE quarter = SUBSTRING(date_description, 2, 1) * 1
               ORDER BY month DESC
               LIMIT 1
             ),
             '-1 DAY',
             '+8 HOUR'
           )
         )
     )
     SELECT STRFTIME(
       '%Y-%m-%dT%H:%M:%S',
       IIF(
         STRFTIME('%u', date_time) * 1 IN (6, 7),
         DATETIME(date_time, '-3 DAY', 'WEEKDAY 5'),
         date_time
       )
     )
       FROM cte
   )
 WHERE SUBSTRING(date_description, 1, 1) = 'Q';
