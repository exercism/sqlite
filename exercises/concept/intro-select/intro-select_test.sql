-- Create database:
.read ./create_fixture.sql

-- ASK: How can we correlate user output with specific tests? One way is to add .output statements
-- in the stub file. But that introduces more noise into the stub file.

-- Run user solution and store results
.read ./intro-select.sql
.shell rm -f ./results.db
.save ./results.db

-- Generate report
-- TODO: Make sure exit code reflects test result
.shell sh ./generate-report.sh results.db
