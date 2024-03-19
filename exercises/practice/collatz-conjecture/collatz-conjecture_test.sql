-- Setup test table and read in student solution:
.read ./test_setup.sql

-- Test cases:
-- Note: the strings below may contain literal tab, newline, carriage returns.

INSERT INTO tests (name, uuid, number, expected)
    VALUES
        ('zero steps for one', '540a3d51-e7a6-47a5-92a3-4ad1838f0bfd',
            1, 0),
        ('divide if even', '3d76a0a6-ea84-444a-821a-f7857c2c1859',
            16, 4),
        ('even and odd steps', '754dea81-123c-429e-b8bc-db20b05a87b9',
            12, 9),
        ('large number of even and odd steps', 'ecfd0210-6f85-44f6-8280-f65534892ff6',
            1000000, 152);

-- Comparison of user input and the tests updates the status for each test:
UPDATE tests
SET status = 'pass'
FROM (SELECT number, steps FROM collatz) AS actual
WHERE (actual.number, actual.steps) = (tests.number, tests.expected);

-- Write results and debug info:
.read ./test_reporter.sql
