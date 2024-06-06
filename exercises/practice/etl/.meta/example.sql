UPDATE etl
SET result = (
    SELECT json_group_object(LOWER(value), TRIM(path, '$."') ->> '$')
    FROM (
        SELECT value, path
        FROM json_tree(input)
        WHERE type = 'text'
        ORDER BY value
    )
);
