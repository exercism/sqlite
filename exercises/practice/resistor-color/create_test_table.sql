-- test_color_code tests the color_code values.
-- test_colors tests the colors values.
-- test_results combined the results for final output.

DROP TABLE IF EXISTS "test_color_code";
CREATE TABLE IF NOT EXISTS "test_color_code" (
    -- uuid and description are taken from the test.toml file
    uuid TEXT PRIMARY KEY,
    description TEXT NOT NULL,
    -- Here are columns for the actual tests
    color TEXT NOT NULL,
    result INT NOT NULL,
    -- The following section is needed by the online test-runner
    status TEXT DEFAULT 'fail',
    message TEXT,
    output TEXT,
    test_code TEXT,
    task_id INTEGER DEFAULT NULL
);

INSERT INTO "test_color_code" (uuid, description, color, result)
    VALUES
        -- Every test case from the .meta/tests.toml file gets its own row:
        ('49eb31c5-10a8-4180-9f7f-fea632ab87ef', 'Color codes -> Black', 'black', 0),
        ('0a4df94b-92da-4579-a907-65040ce0b3fc', 'Color codes -> White', 'white', 9),
        ('5f81608d-f36f-4190-8084-f45116b6f380', 'Color codes -> Orange', 'orange', 3);
