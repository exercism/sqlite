-- Task:  - Update the nucleotide_count table and set the result based on the input field.
--        - Update table creation with constraints.

DROP TABLE IF EXISTS nucleotide_count;
CREATE TABLE "nucleotide_count" (
    "strand" TEXT,
    "result" TEXT,
    CHECK  (1 >  LENGTH(REPLACE(REPLACE(REPLACE(REPLACE(strand, 'A', ''), 'C', ''), 'G', ''), 'T', '')))
);

-- Please don't change the following two import lines:
.mode csv
.import ./data.csv nucleotide_count

-- Write your code below:
CREATE VIEW counts (strand, a, c, g, t)
AS
    SELECT 
        strand,
        LENGTH(strand) - LENGTH(REPLACE(strand, 'A', '')),
        LENGTH(strand) - LENGTH(REPLACE(strand, 'C', '')),
        LENGTH(strand) - LENGTH(REPLACE(strand, 'G', '')),
        LENGTH(strand) - LENGTH(REPLACE(strand, 'T', ''))
    FROM nucleotide_count;

UPDATE nucleotide_count
SET result = (
    SELECT json(' { "A": ' || a || ', "C": ' || c || ', "G": ' || g || ', "T": ' || t || ' } ')
    FROM counts
    WHERE nucleotide_count.strand == counts.strand
);
