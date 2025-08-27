DROP TABLE IF EXISTS dict;
CREATE TEMPORARY TABLE dict (
  codon      TEXT PRIMARY KEY,
  amino_acid TEXT NOT NULL
);
INSERT INTO dict(codon, amino_acid)
VALUES ('AUG', 'Methionine'   ),
       ('UUU', 'Phenylalanine'),
       ('UUC', 'Phenylalanine'),
       ('UUA', 'Leucine'      ),
       ('UUG', 'Leucine'      ),
       ('UCU', 'Serine'       ),
       ('UCC', 'Serine'       ),
       ('UCA', 'Serine'       ),
       ('UCG', 'Serine'       ),
       ('UAU', 'Tyrosine'     ),
       ('UAC', 'Tyrosine'     ),
       ('UGU', 'Cysteine'     ),
       ('UGC', 'Cysteine'     ),
       ('UGG', 'Tryptophan'   ),
       ('UAA', 'STOP'         ),
       ('UAG', 'STOP'         ),
       ('UGA', 'STOP'         );

DROP TABLE IF EXISTS results;
CREATE TEMPORARY TABLE results AS
SELECT strand,
       (WITH RECURSIVE translator (string, codon, amino_acid) AS (
         VALUES (strand, '', '')
         UNION ALL
         SELECT SUBSTR(string, 4),
                SUBSTR(string, 1, 3),
                (SELECT amino_acid
                   FROM dict
                  WHERE dict.codon = SUBSTR(string, 1, 3))
           FROM translator
          WHERE string <> ''
            AND amino_acid <> 'STOP'
       )
       SELECT
         CASE
         WHEN (SELECT 1
                 FROM translator
                WHERE amino_acid ISNULL)
           THEN 'Invalid codon'
         WHEN (SELECT COUNT(*) FILTER(WHERE amino_acid <> '') =
                      COUNT(*) FILTER(WHERE amino_acid = 'STOP')
                 FROM translator)
           THEN ''
         ELSE (SELECT GROUP_CONCAT(amino_acid, ', ')
                 FROM translator
                WHERE amino_acid NOT IN ('', 'STOP'))
         END
       ) result_or_error
  FROM "protein-translation"
;

UPDATE "protein-translation" AS pt
   SET error = result_or_error
  FROM results re
 WHERE pt.strand = re.strand
   AND result_or_error = 'Invalid codon'
;

UPDATE "protein-translation" AS pt
   SET result = result_or_error
  FROM results re
 WHERE pt.strand = re.strand
   AND result_or_error <> 'Invalid codon'
;
