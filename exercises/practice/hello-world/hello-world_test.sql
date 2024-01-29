-- Create database:
.read ./create_fixture.sql

-- Read user student solution and save any output as markdown in user_output.md:
.mode markdown
.output user_output.md
.read ./hello-world.sql
.output

-- Create a clean testing environment:
DROP TABLE IF EXISTS main.tests;
CREATE TABLE IF NOT EXISTS main.tests (
    -- uuid and name are taken from the test.toml file
    uuid TEXT PRIMARY KEY,
	name TEXT NOT NULL,
    -- The following section is needed by the online test-runner
    status TEXT DEFAULT 'fail',
    message TEXT,
    output TEXT,
    test_code TEXT,
    task_id INTEGER DEFAULT NULL,
    -- Here are columns for the actual tests
    result TEXT NOT NULL
);
INSERT INTO tests (name, uuid, result)
    VALUES
        -- Every test case from the .meta/tests.toml file gets its own row:
        ('Say Hi!', 'af9ffe10-dc13-42d8-a742-e7bdafac449d', 'Hello, World!');

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT greeting FROM hello_world) AS h
WHERE h.greeting = tests.result;
-- Upadte message for failed tests to give helpful information:
UPDATE tests
SET message = 'Greeting is: ''' || h.greeting || ''', but should be: ''' || tests.result ||''''
FROM (SELECT greeting FROM hello_world) AS h
WHERE  tests.status = 'fail';
-- Save results to ./output.json (needed by the online test-runner)
.mode json
.once './output.json'
SELECT name, status, message, output, test_code, task_id
FROM tests;

-- Display test results in readable form for the student:
.mode table
SELECT name, status, message
FROM tests;