-- store comma-separated list of scores of a UUID
UPDATE results
SET result = score_groups.scores
FROM (
    SELECT uuid, GROUP_CONCAT(score) "scores"
    FROM (
        SELECT scores.uuid, score
        FROM scores
        INNER JOIN results USING (uuid)
        WHERE results.property = 'scores'
        ORDER BY scores.rowid
    ) scores_by_uuid
    GROUP BY uuid
) score_groups
WHERE results.uuid = score_groups.uuid;

-- store the latest score by UUID
UPDATE results
SET result = latest_score.score
FROM (
    SELECT scores.uuid, score
    FROM scores
    INNER JOIN (
        SELECT scores.uuid, MAX(scores.rowid) "last_row"
        FROM scores
        INNER JOIN results USING (uuid)
        WHERE results.property = 'latest'
        GROUP BY scores.uuid
    ) latest USING (uuid)
    WHERE scores.rowid = latest.last_row
) latest_score
WHERE results.uuid = latest_score.uuid;

-- the largest score by UUID
UPDATE results
SET result = best_score.best
FROM (
    SELECT scores.uuid, max(score) "best"
    FROM scores
    INNER JOIN results USING (uuid)
    WHERE results.property = 'personalBest'
    GROUP BY scores.uuid
) best_score
WHERE results.uuid = best_score.uuid;

-- for personalTopThree, sort scores descending by UUID
DROP TABLE IF EXISTS reversed;
CREATE TEMP TABLE reversed AS 
    SELECT scores.uuid, score
    FROM scores
    INNER JOIN results USING (uuid)
    WHERE results.property = 'personalTopThree'
    ORDER BY scores.uuid ASC, score DESC
;

UPDATE results
SET result = top_three_scores.top_three
FROM (
    SELECT reversed.uuid, GROUP_CONCAT(reversed.score) "top_three"
    FROM reversed
    INNER JOIN (
        SELECT uuid, MIN(rowid) "first_row"
        FROM reversed
        GROUP BY uuid
    ) min_row USING (uuid)
    WHERE reversed.rowid < min_row.first_row + 3
    GROUP BY reversed.uuid
) top_three_scores
WHERE results.uuid = top_three_scores.uuid;
