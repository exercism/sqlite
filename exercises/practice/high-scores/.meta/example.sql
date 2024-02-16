-- store comma-separated list of scores of a game
UPDATE results
SET result = score_groups.scores
FROM (
    SELECT game_id, GROUP_CONCAT(score) "scores"
    FROM (
        SELECT scores.game_id, score
        FROM scores
        INNER JOIN results USING (game_id)
        WHERE results.property = 'scores'
        ORDER BY scores.rowid
    ) scores_by_game_id
    GROUP BY game_id
) score_groups
WHERE results.game_id = score_groups.game_id;

-- store the latest score by game
UPDATE results
SET result = latest_score.score
FROM (
    SELECT scores.game_id, score
    FROM scores
    INNER JOIN (
        SELECT scores.game_id, MAX(scores.rowid) "last_row"
        FROM scores
        INNER JOIN results USING (game_id)
        WHERE results.property = 'latest'
        GROUP BY scores.game_id
    ) latest USING (game_id)
    WHERE scores.rowid = latest.last_row
) latest_score
WHERE results.game_id = latest_score.game_id;

-- the largest score by game
UPDATE results
SET result = best_score.best
FROM (
    SELECT scores.game_id, max(score) "best"
    FROM scores
    INNER JOIN results USING (game_id)
    WHERE results.property = 'personalBest'
    GROUP BY scores.game_id
) best_score
WHERE results.game_id = best_score.game_id;

-- for personalTopThree, sort scores descending by game
DROP TABLE IF EXISTS reversed;
CREATE TEMP TABLE reversed AS 
    SELECT scores.game_id, score
    FROM scores
    INNER JOIN results USING (game_id)
    WHERE results.property = 'personalTopThree'
    ORDER BY scores.game_id ASC, score DESC
;

UPDATE results
SET result = top_three_scores.top_three
FROM (
    SELECT reversed.game_id, GROUP_CONCAT(reversed.score) "top_three"
    FROM reversed
    INNER JOIN (
        SELECT game_id, MIN(rowid) "first_row"
        FROM reversed
        GROUP BY game_id
    ) min_row USING (game_id)
    WHERE reversed.rowid < min_row.first_row + 3
    GROUP BY reversed.game_id
) top_three_scores
WHERE results.game_id = top_three_scores.game_id;
