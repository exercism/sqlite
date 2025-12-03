-- Create database:
.read ./create_fixture.sql

-- ASK: How can we correlate user output with specific tests? One way is to add .output statements
-- in the stub file. But that introduces more noise into the stub file.

-- Run user solution and store results
.mode markdown
.output user_output.md
.read ./intro-select.sql
.shell rm -f ./results.db
.save ./results.db

.output

-- Generate report
.shell sh ./generate-report.sh results.db

-- Exit normally if all tests passed; otherwise abort with error code
CREATE TABLE result (
    status TEXT CHECK(status = "true")
);
.mode line
.import "|jq -c .status output.json" result
