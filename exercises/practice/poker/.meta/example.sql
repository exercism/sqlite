DROP TABLE IF EXISTS ranking;

CREATE TEMPORARY TABLE ranking (id INTEGER PRIMARY KEY, name TEXT NOT NULL);

INSERT INTO
  ranking (id, name)
VALUES
  (10, 'straight flush'),
  (20, 'four of a kind'),
  (30, 'full house'),
  (40, 'flush'),
  (50, 'straight'),
  (60, 'three of a kind'),
  (70, 'two pair'),
  (80, 'one pair'),
  (90, 'high card');

DROP TABLE IF EXISTS tmp;

CREATE TABLE tmp (hand TEXT PRIMARY KEY, deck TEXT, name TEXT);

INSERT INTO
  tmp (hand)
SELECT DISTINCT
  (j.value)
FROM
  poker,
  JSON_TREE(hands) j
WHERE
  j.type = 'text';

UPDATE tmp
SET
  deck = (
    WITH
      to_cards (rank, suite) AS (
        WITH RECURSIVE
          to_cards (hand, card) AS (
            VALUES
              (hand || ' ', NULL)
            UNION ALL
            SELECT
              SUBSTR(hand, INSTR(hand, ' ') + 1),
              SUBSTR(hand, 1, INSTR(hand, ' ') - 1)
            FROM
              to_cards
            WHERE
              hand <> ''
            LIMIT
              10
          )
        SELECT
          SUBSTR(card, 1, LENGTH(card) - 1) AS rank,
          SUBSTR(card, -1) AS suite
        FROM
          to_cards
        WHERE
          card NOTNULL
      )
    SELECT
      JSON_GROUP_ARRAY(JSON(card))
    FROM
      (
        SELECT
          JSON_ARRAY(rank, suite) card
        FROM
          (
            SELECT
              CASE rank
                WHEN 'A' THEN 14
                WHEN 'J' THEN 11
                WHEN 'Q' THEN 12
                WHEN 'K' THEN 13
                ELSE rank
              END * 1 AS rank,
              suite
            FROM
              to_cards
          )
        ORDER BY
          rank DESC,
          suite ASC
      )
  );

ALTER TABLE tmp
ADD COLUMN is_sequential BOOLEAN;

UPDATE tmp
SET
  is_sequential = (
    SELECT
      JSON_ARRAY_LENGTH(ranks) = 5
      AND JSON_EXTRACT(ranks, '$[0]') = JSON_EXTRACT(ranks, '$[4]') + 4
    FROM
      (
        SELECT
          JSON_GROUP_ARRAY(DISTINCT (JSON_EXTRACT(j.value, '$[0]'))) AS ranks
        FROM
          JSON_EACH(deck) j
      )
  )
  OR (
    SELECT
      JSON_ARRAY_LENGTH(ranks) = 5
      AND JSON_EXTRACT(ranks, '$[0]') = JSON_EXTRACT(ranks, '$[4]') + 4
    FROM
      (
        SELECT
          JSON_GROUP_ARRAY(rank) AS ranks
        FROM
          (
            SELECT
              IIF(rank = 14, 1, rank) rank
            FROM
              (
                SELECT DISTINCT
                  (JSON_EXTRACT(j.value, '$[0]')) AS rank
                FROM
                  JSON_EACH(deck) j
              )
            ORDER BY
              rank DESC
          )
      )
  );

ALTER TABLE tmp
ADD COLUMN same_suite BOOLEAN;

UPDATE tmp
SET
  same_suite = (
    SELECT
      JSON_ARRAY_LENGTH(suites) = 1
    FROM
      (
        SELECT
          JSON_GROUP_ARRAY(DISTINCT (JSON_EXTRACT(j.value, '$[1]'))) AS suites
        FROM
          JSON_EACH(deck) j
      )
  );

UPDATE tmp
SET
  name = 'straight flush'
WHERE
  is_sequential
  AND same_suite
  AND name ISNULL;

UPDATE tmp
SET
  name = 'four of a kind'
WHERE
  (
    SELECT
      1
    FROM
      (
        SELECT
          JSON_EXTRACT(j.value, '$[0]') rank
        FROM
          JSON_EACH(deck) j
      )
    GROUP BY
      rank
    HAVING
      COUNT(*) = 4
  )
  AND name ISNULL;

UPDATE tmp
SET
  name = 'full house'
WHERE
  (
    SELECT
      GROUP_CONCAT(dup) = '3,2'
    FROM
      (
        SELECT
          dup
        FROM
          (
            SELECT
              COUNT(*) dup
            FROM
              (
                SELECT
                  JSON_EXTRACT(j.value, '$[0]') rank
                FROM
                  JSON_EACH(deck) j
              )
            GROUP BY
              rank
          )
        ORDER BY
          dup DESC
      )
  )
  AND name ISNULL;

UPDATE tmp
SET
  name = 'flush'
WHERE
  same_suite
  AND name ISNULL;

UPDATE tmp
SET
  name = 'straight'
WHERE
  is_sequential
  AND name ISNULL;

UPDATE tmp
SET
  name = 'three of a kind'
WHERE
  (
    SELECT
      1
    FROM
      (
        SELECT
          JSON_EXTRACT(j.value, '$[0]') rank
        FROM
          JSON_EACH(deck) j
      )
    GROUP BY
      rank
    HAVING
      COUNT(*) = 3
  )
  AND name ISNULL;

UPDATE tmp
SET
  name = 'two pair'
WHERE
  (
    SELECT
      GROUP_CONCAT(dup) = '2,2,1'
    FROM
      (
        SELECT
          dup
        FROM
          (
            SELECT
              COUNT(*) dup
            FROM
              (
                SELECT
                  JSON_EXTRACT(j.value, '$[0]') rank
                FROM
                  JSON_EACH(deck) j
              )
            GROUP BY
              rank
          )
        ORDER BY
          dup DESC
      )
  )
  AND name ISNULL;

UPDATE tmp
SET
  name = 'one pair'
WHERE
  (
    SELECT
      1
    FROM
      (
        SELECT
          JSON_EXTRACT(j.value, '$[0]') rank
        FROM
          JSON_EACH(deck) j
      )
    GROUP BY
      rank
    HAVING
      COUNT(*) = 2
  )
  AND name ISNULL;

UPDATE tmp
SET
  name = 'high card'
WHERE
  name ISNULL;

ALTER TABLE tmp
ADD COLUMN ranks_id INTEGER;

UPDATE tmp
SET
  ranks_id = CASE
    WHEN name NOT IN ('four of a kind', 'three of a kind', 'full house') THEN (
      (
        SELECT
          GROUP_CONCAT(rank, '')
        FROM
          (
            SELECT
              IIF(
                rank = '14'
                AND LIKE('straight%', name)
                AND JSON_EXTRACT(deck, '$[0][0]', '$[1][0]') = JSON_ARRAY(14, 5),
                1,
                rank
              ) rank
            FROM
              (
                SELECT
                  PRINTF('%02d', JSON_EXTRACT(j.value, '$[0]')) rank
                FROM
                  JSON_EACH(deck) j
              )
            ORDER BY
              rank DESC
          )
      )
    )
    ELSE (
      WITH
        by_rank AS (
          SELECT
            JSON_EXTRACT(j.value, '$[0]') rank,
            j.*
          FROM
            JSON_EACH(deck) j
        ),
        dup (rank) AS (
          SELECT
            rank
          FROM
            by_rank
          GROUP BY
            rank
          ORDER BY
            COUNT(*) DESC
          LIMIT
            1
        ),
        same (rank) AS (
          SELECT
            PRINTF('%02d', by_rank.rank)
          FROM
            by_rank,
            dup
          WHERE
            by_rank.rank = dup.rank
        ),
        kickers (rank) AS (
          SELECT
            PRINTF('%02d', by_rank.rank)
          FROM
            by_rank,
            dup
          WHERE
            by_rank.rank != dup.rank
          ORDER BY
            by_rank.rank DESC
        )
      SELECT
        GROUP_CONCAT(rank, '')
      FROM
        (
          SELECT
            rank
          FROM
            same
          UNION ALL
          SELECT
            rank
          FROM
            kickers
        )
    )
  END;

UPDATE poker
SET
  result = (
    WITH
      analysis AS (
        SELECT
          j.value hand,
          tmp.name,
          tmp.deck,
          ranking.id,
          tmp.ranks_id
        FROM
          JSON_TREE(hands) j,
          tmp,
          ranking
        WHERE
          j.value = tmp.hand
          AND tmp.name = ranking.name
          AND j.type = 'text'
      ),
      winners AS (
        SELECT
          hand,
          ranks_id
        FROM
          analysis
        WHERE
          id = (
            SELECT
              MIN(id)
            FROM
              analysis
          )
      ),
      tiebreaker AS (
        SELECT
          winners.hand
        FROM
          winners
        WHERE
          ranks_id = (
            SELECT
              MAX(ranks_id)
            FROM
              winners
          )
      )
    SELECT
      JSON_GROUP_ARRAY(hand)
    FROM
      (
        SELECT
          hand
        FROM
          tiebreaker
        ORDER BY
          hand
      )
  );
