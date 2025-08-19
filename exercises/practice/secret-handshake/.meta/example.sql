UPDATE "secret-handshake"
   SET result = (
     SELECT COALESCE(GROUP_CONCAT(j.value, ', '), '')
       FROM (
         SELECT
           JSON_ARRAY(
             IIF((number >> 3) & 1, 'jump'           , NULL),
             IIF((number >> 2) & 1, 'close your eyes', NULL),
             IIF((number >> 1) & 1, 'double blink'   , NULL),
             IIF((number >> 0) & 1, 'wink'           , NULL)
           ) AS commands
       ), JSON_EACH(commands) j
      WHERE j.value NOTNULL
   )
 WHERE (number >> 4) & 1 = 1
;

UPDATE "secret-handshake"
   SET result = (
     SELECT COALESCE(GROUP_CONCAT(j.value, ', '), '')
       FROM (
         SELECT
           JSON_ARRAY(
             IIF((number >> 0) & 1, 'wink'           , NULL),
             IIF((number >> 1) & 1, 'double blink'   , NULL),
             IIF((number >> 2) & 1, 'close your eyes', NULL),
             IIF((number >> 3) & 1, 'jump'           , NULL)
           ) AS commands
       ), JSON_EACH(commands) j
      WHERE j.value NOTNULL
   )
 WHERE (number >> 4) & 1 = 0
;
