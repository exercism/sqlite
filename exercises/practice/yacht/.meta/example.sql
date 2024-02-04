CREATE VIEW split (dice_results, category, ones, twos, threes, fours, fives, sixes, total)
AS
    SELECT 
        dice_results,
        category,
        13 - LENGTH(REPLACE(dice_results, '1', '')),
        13 - LENGTH(REPLACE(dice_results, '2', '')),
        13 - LENGTH(REPLACE(dice_results, '3', '')),
        13 - LENGTH(REPLACE(dice_results, '4', '')),
        13 - LENGTH(REPLACE(dice_results, '5', '')),
        13 - LENGTH(REPLACE(dice_results, '6', '')),
        -- total:
        1 * (13 - LENGTH(REPLACE(dice_results, '1', ''))) +
        2 * (13 - LENGTH(REPLACE(dice_results, '2', ''))) +
        3 * (13 - LENGTH(REPLACE(dice_results, '3', ''))) +
        4 * (13 - LENGTH(REPLACE(dice_results, '4', ''))) +
        5 * (13 - LENGTH(REPLACE(dice_results, '5', ''))) +
        6 * (13 - LENGTH(REPLACE(dice_results, '6', '')))
    FROM yacht;

UPDATE yacht
SET result = (
    SELECT CASE category
    WHEN 'ones' THEN ones
    WHEN 'twos' THEN twos * 2
    WHEN 'threes' THEN threes * 3
    WHEN 'fours' THEN fours * 4
    WHEN 'fives' THEN fives * 5
    WHEN 'sixes' THEN sixes * 6
    WHEN 'full house' THEN CASE WHEN MAX(ones, twos, threes, fours, fives, sixes) == 3 
                                        AND (ones == 3 
                                            OR twos == 3
                                            OR threes == 3
                                            OR fours == 3
                                            OR fives == 3
                                            OR sixes == 3)
                                THEN total ELSE 0 END
    WHEN 'four of a kind' THEN CASE
                                    WHEN ones >= 4 THEN 4
                                    WHEN twos >= 4 THEN 8
                                    WHEN threes >= 4 THEN 12
                                    WHEN fours >= 4 THEN 16
                                    WHEN fives >= 4 THEN 20
                                    WHEN sixes >= 4 THEN 24
                                    ELSE 0 
                                END
    WHEN 'little straight' THEN CASE WHEN MAX(ones, twos, threes, fours, fives, sixes) == 1 AND sixes == 0 THEN 30 ELSE 0 END
    WHEN 'big straight' THEN CASE WHEN MAX(ones, twos, threes, fours, fives, sixes) == 1 AND ones == 0 THEN 30 ELSE 0 END
    WHEN 'yacht' THEN CASE WHEN MAX(ones, twos, threes, fours, fives, sixes) == 5 THEN 50 ELSE 0 END
    ELSE total -- choice
    END
    FROM split
    WHERE (yacht.dice_results, yacht.category) == (split.dice_results, split.category)
        );
