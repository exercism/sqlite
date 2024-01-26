
.read ./create_fixture.sql

.mode markdown
.read ./hello-world.sql
.output user_output.md
.output

DROP TABLE IF EXISTS main.tests;

CREATE TABLE IF NOT EXISTS main.tests (
    uuid TEXT PRIMARY KEY,
	name TEXT NOT NULL,
    status TEXT DEFAULT "fail",
    message TEXT,
    output TEXT,
    test_code TEXT,
    task_id INTEGER DEFAULT NULL,
    result TEXT NOT NULL
);

INSERT INTO tests (name, uuid, result)
    VALUES
        ("Say Hi!", "af9ffe10-dc13-42d8-a742-e7bdafac449d", "Hello, World!");

UPDATE tests
SET status = "pass"
FROM (SELECT greeting FROM hello_world) AS h
WHERE h.greeting = tests.result;

UPDATE tests
SET message = "Greeting is: '" || h.greeting || "', but should be: '" || tests.result ||"'"
FROM (SELECT greeting FROM hello_world) AS h
WHERE  tests.status = "fail";

.mode json
.once './output.json'

SELECT name, status, message, output, test_code, task_id
FROM tests;

.mode table
SELECT name, status, message
FROM tests;