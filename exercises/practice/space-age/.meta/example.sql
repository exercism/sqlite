DROP TABLE IF EXISTS planets;
CREATE TEMPORARY TABLE planets (
  name   TEXT UNIQUE NOT NULL,
  period REAL        NOT NULL
);
INSERT INTO planets (name, period)
VALUES ('Mercury',   0.2408467 ),
       ('Venus'  ,   0.61519726),
       ('Earth'  ,   1.0       ),
       ('Mars'   ,   1.8808158 ),
       ('Jupiter',  11.862615  ),
       ('Saturn' ,  29.447498  ),
       ('Uranus' ,  84.016846  ),
       ('Neptune', 164.79132   );

UPDATE "space-age"
   SET result = ROUND("space-age".seconds / 31557600.0 / planets.period, 2)
       FROM planets
 WHERE "space-age".planet = planets.name
   AND "space-age".result ISNULL
       ;
