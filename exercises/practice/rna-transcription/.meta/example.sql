UPDATE "rna-transcription"
SET
  result = REPLACE(
    REPLACE(
      REPLACE(
        REPLACE(REPLACE(dna, 'A', 'U'), 'T', 'A'),
        'C',
        'Z'
      ),
      'G',
      'C'
    ),
    'Z',
    'G'
  );
