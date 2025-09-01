UPDATE clock
   SET result =
       STRFTIME(
         '%H:%M',
         TIME('00:00',
              PRINTF('%d HOUR',   JSON_EXTRACT(input, '$.hour')),
              PRINTF('%d MINUTE', JSON_EXTRACT(input, '$.minute'))
         )
       )
 WHERE property = 'create'
       ;

UPDATE clock
   SET result =
       STRFTIME('%H:%M',
                TIME(
                  '00:00',
                  PRINTF('%d HOUR',    JSON_EXTRACT(input, '$.hour')),
                  PRINTF('%d minute',  JSON_EXTRACT(input, '$.minute')),
                  PRINTF('+%d minute', JSON_EXTRACT(input, '$.value'))
                )
       )
 WHERE property = 'add'
       ;

UPDATE clock
   SET result =
       STRFTIME('%H:%M',
                TIME(
                  '00:00',
                  PRINTF('%d HOUR',    JSON_EXTRACT(input, '$.hour')),
                  PRINTF('%d minute',  JSON_EXTRACT(input, '$.minute')),
                  PRINTF('-%d minute', JSON_EXTRACT(input, '$.value'))
                )
       )
 WHERE property = 'subtract'
       ;

UPDATE clock
   SET result =
       TIME('00:00',
            PRINTF('%d HOUR',   JSON_EXTRACT(input, '$.clock1.hour'  )),
            PRINTF('%d MINUTE', JSON_EXTRACT(input, '$.clock1.minute'))
       ) =
       TIME('00:00',
            PRINTF('%d HOUR',   JSON_EXTRACT(input, '$.clock2.hour'  )),
            PRINTF('%d MINUTE', JSON_EXTRACT(input, '$.clock2.minute'))
       )
 WHERE property = 'equal';
