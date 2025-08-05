DROP TABLE IF EXISTS tmp;
CREATE TEMPORARY TABLE tmp (
  p  TEXT UNIQUE NOT NULL,
  op REAL        NOT NULL
);
INSERT INTO tmp (p, op)
VALUES ('Mercury',   0.2408467 ),
       ('Venus'  ,   0.61519726),
       ('Earth'  ,   1.0       ),
       ('Mars'   ,   1.8808158 ),
       ('Jupiter',  11.862615  ),
       ('Saturn' ,  29.447498  ),
       ('Uranus' ,  84.016846  ),
       ('Neptune', 164.79132   );

UPDATE "space-age"
   SET result = JSON_OBJECT('error', 'not a planet')
 WHERE NOT EXISTS (SELECT 1 FROM tmp WHERE p = planet)
;

UPDATE "space-age"
   SET result = JSON_OBJECT(
     'age',
     ROUND("space-age".seconds / 31557600.0 / tmp.op, 2)
   )
  FROM tmp
 WHERE "space-age".planet = tmp.p
   AND "space-age".result ISNULL
;
