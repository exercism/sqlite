UPDATE matrix
   SET result = (
     SELECT j.value
       FROM JSON_EACH(
         PRINTF('[[%s]]', REPLACE(REPLACE(string, ' ', ','), CHAR(10), '],['))
       ) j
 WHERE j.key = "index" - 1
   )
 WHERE property = 'row'
;

UPDATE matrix
   SET result = (
     SELECT JSON_GROUP_ARRAY(
       JSON_EXTRACT(j.value, PRINTF('$[%d]', "index" - 1))
     )
       FROM JSON_EACH(
         PRINTF('[[%s]]', REPLACE(REPLACE(string, ' ', ','), CHAR(10), '],['))
       ) j
     )
 WHERE property = 'column'
;
