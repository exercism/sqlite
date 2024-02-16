-- Task:  - Update the nucleotide_count table and set the result based on the input field.
--        - Update table creation with constraints.

DROP TABLE IF EXISTS nucleotide_count;
CREATE TABLE "nucleotide_count" (
    "strand" TEXT,
    "result" TEXT,
);

-- Please don't change those import lines:
.mode csv
.import ./data.csv nucleotide_count

-- Write your code below:
