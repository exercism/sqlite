UPDATE "dnd-character"
   SET modifier = FLOOR((constitution - 10) / 2.0)
 WHERE property = 'modifier'
   AND input    = 'score'
       ;

UPDATE "dnd-character"
   SET wisdom = (
     SELECT SUM(score)
       FROM (
         SELECT ABS(RANDOM()) % (6 - 1) + 1 AS score
           FROM generate_series(1, 4) AS times
          ORDER BY score DESC
          LIMIT 3
       )
   )
 WHERE property = 'ability'
   AND input    = 'random'
       ;


UPDATE "dnd-character"
   SET
     strength = (
       SELECT SUM(score)
         FROM (
           SELECT ABS(RANDOM()) % (6 - 1) + 1 AS score
             FROM generate_series(1, 4) AS times
            ORDER BY score DESC
            LIMIT 3
         )
     ),
     dexterity = (
       SELECT SUM(score)
         FROM (
           SELECT ABS(RANDOM()) % (6 - 1) + 1 AS score
             FROM generate_series(1, 4) AS times
            ORDER BY score DESC
            LIMIT 3
         )
     ),
     constitution = (
       SELECT SUM(score)
         FROM (
           SELECT ABS(RANDOM()) % (6 - 1) + 1 AS score
             FROM generate_series(1, 4) AS times
            ORDER BY score DESC
            LIMIT 3
         )
     ),
     intelligence = (
       SELECT SUM(score)
         FROM (
           SELECT ABS(RANDOM()) % (6 - 1) + 1 AS score
             FROM generate_series(1, 4) AS times
            ORDER BY score DESC
            LIMIT 3
         )
     ),
     wisdom = (
       SELECT SUM(score)
         FROM (
           SELECT ABS(RANDOM()) % (6 - 1) + 1 AS score
             FROM generate_series(1, 4) AS times
            ORDER BY score DESC
            LIMIT 3
         )
     ),
     charisma = (
       SELECT SUM(score)
         FROM (
           SELECT ABS(RANDOM()) % (6 - 1) + 1 AS score
             FROM generate_series(1, 4) AS times
            ORDER BY score DESC
            LIMIT 3
         )
     )
 WHERE property = 'character'
   AND input    = 'random'
       ;
UPDATE "dnd-character"
   SET modifier = FLOOR((constitution - 10) / 2.0)
 WHERE property = 'character'
   AND input    = 'random'
       ;
UPDATE "dnd-character"
   SET hitpoints = 10 + modifier
 WHERE property = 'character'
   AND input    = 'random'
       ;

UPDATE "dnd-character" AS a
   SET strength     = b.strength,
       dexterity    = b.dexterity,
       constitution = b.constitution,
       intelligence = b.intelligence,
       wisdom       = b.wisdom,
       charisma     = b.charisma
  FROM "dnd-character" AS b
 WHERE a.property = b.property
   AND a.property = 'character'
   AND a.input    = ''
   AND b.input    = 'random'
;
