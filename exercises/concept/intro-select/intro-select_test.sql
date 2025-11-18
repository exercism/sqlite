-- Create database:
.read ./create_fixture.sql

-- ASK: How can we correlate user output with specific tests?

-- Store test data
.read ./store_test_data.sql

-- Run user solution
.read ./intro-select.sql

-- TODO: Compare expected vs actual among each of the slug values in test_data
--       Compare columns first; if columns are equal, then compare rows
