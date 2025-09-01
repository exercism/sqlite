UPDATE clock
   SET result =
       STRFTIME(
         '%H:%M',
         TIME('00:00',
              PRINTF('%d HOUR',   input->>'hour'),
              PRINTF('%d MINUTE', input->>'minute')
         )
       )
 WHERE property = 'create'
       ;

UPDATE clock
   SET result =
       STRFTIME('%H:%M',
                TIME(
                  '00:00',
                  PRINTF('%d HOUR',    input->>'hour'),
                  PRINTF('%d minute',  input->>'minute'),
                  PRINTF('+%d minute', input->>'value')
                )
       )
 WHERE property = 'add'
       ;

UPDATE clock
   SET result =
       STRFTIME('%H:%M',
                TIME(
                  '00:00',
                  PRINTF('%d HOUR',    input->>'hour'),
                  PRINTF('%d minute',  input->>'minute'),
                  PRINTF('-%d minute', input->>'value')
                )
       )
 WHERE property = 'subtract'
       ;

UPDATE clock
   SET result =
       TIME('00:00',
            PRINTF('%d HOUR',   input->'clock1'->>'hour'),
            PRINTF('%d MINUTE', input->'clock1'->>'minute')
       ) =
       TIME('00:00',
            PRINTF('%d HOUR',   input->'clock2'->>'hour'),
            PRINTF('%d MINUTE', input->'clock2'->>'minute')
       )
 WHERE property = 'equal';
