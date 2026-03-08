-- Create database:
.read ./create_fixture.sql

-- Run user solution and store results
.mode markdown
.output user_output.md
.read ./weather-report.sql
.save ./results.db

.output

-- Report results
.shell bash ./report-results results.db
.shell rm -f ./results.db
