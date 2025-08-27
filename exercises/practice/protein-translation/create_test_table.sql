DROP TABLE IF EXISTS tests;
CREATE TABLE IF NOT EXISTS tests (
  -- uuid and description are taken from the test.toml file
  uuid            TEXT PRIMARY KEY    ,
  description     TEXT NOT NULL       ,
  -- The following section is needed by the online test-runner
  status          TEXT DEFAULT 'fail' ,
  message         TEXT                ,
  output          TEXT                ,
  test_code       TEXT                ,
  task_id         INTEGER DEFAULT NULL,
  -- Here are columns for the actual tests
  strand          TEXT NOT NULL       ,
  expected_result TEXT                ,
  expected_error  TEXT
);

INSERT INTO tests (uuid, description, strand, expected_result, expected_error)
VALUES
  ('2c44f7bf-ba20-43f7-a3bf-f2219c0c3f98', 'Empty RNA sequence results in no proteins', '', '', NULL),
  ('96d3d44f-34a2-4db4-84cd-fff523e069be', 'Methionine RNA sequence', 'AUG', 'Methionine', NULL),
  ('1b4c56d8-d69f-44eb-be0e-7b17546143d9', 'Phenylalanine RNA sequence 1', 'UUU', 'Phenylalanine', NULL),
  ('81b53646-bd57-4732-b2cb-6b1880e36d11', 'Phenylalanine RNA sequence 2', 'UUC', 'Phenylalanine', NULL),
  ('42f69d4f-19d2-4d2c-a8b0-f0ae9ee1b6b4', 'Leucine RNA sequence 1', 'UUA', 'Leucine', NULL),
  ('ac5edadd-08ed-40a3-b2b9-d82bb50424c4', 'Leucine RNA sequence 2', 'UUG', 'Leucine', NULL),
  ('8bc36e22-f984-44c3-9f6b-ee5d4e73f120', 'Serine RNA sequence 1', 'UCU', 'Serine', NULL),
  ('5c3fa5da-4268-44e5-9f4b-f016ccf90131', 'Serine RNA sequence 2', 'UCC', 'Serine', NULL),
  ('00579891-b594-42b4-96dc-7ff8bf519606', 'Serine RNA sequence 3', 'UCA', 'Serine', NULL),
  ('08c61c3b-fa34-4950-8c4a-133945570ef6', 'Serine RNA sequence 4', 'UCG', 'Serine', NULL),
  ('54e1e7d8-63c0-456d-91d2-062c72f8eef5', 'Tyrosine RNA sequence 1', 'UAU', 'Tyrosine', NULL),
  ('47bcfba2-9d72-46ad-bbce-22f7666b7eb1', 'Tyrosine RNA sequence 2', 'UAC', 'Tyrosine', NULL),
  ('3a691829-fe72-43a7-8c8e-1bd083163f72', 'Cysteine RNA sequence 1', 'UGU', 'Cysteine', NULL),
  ('1b6f8a26-ca2f-43b8-8262-3ee446021767', 'Cysteine RNA sequence 2', 'UGC', 'Cysteine', NULL),
  ('1e91c1eb-02c0-48a0-9e35-168ad0cb5f39', 'Tryptophan RNA sequence', 'UGG', 'Tryptophan', NULL),
  ('e547af0b-aeab-49c7-9f13-801773a73557', 'STOP codon RNA sequence 1', 'UAA', '', NULL),
  ('67640947-ff02-4f23-a2ef-816f8a2ba72e', 'STOP codon RNA sequence 2', 'UAG', '', NULL),
  ('9c2ad527-ebc9-4ace-808b-2b6447cb54cb', 'STOP codon RNA sequence 3', 'UGA', '', NULL),
  ('f4d9d8ee-00a8-47bf-a1e3-1641d4428e54', 'Sequence of two protein codons translates into proteins', 'UUUUUU', 'Phenylalanine, Phenylalanine', NULL),
  ('dd22eef3-b4f1-4ad6-bb0b-27093c090a9d', 'Sequence of two different protein codons translates into proteins', 'UUAUUG', 'Leucine, Leucine', NULL),
  ('d0f295df-fb70-425c-946c-ec2ec185388e', 'Translate RNA strand into correct protein list', 'AUGUUUUGG', 'Methionine, Phenylalanine, Tryptophan', NULL),
  ('e30e8505-97ec-4e5f-a73e-5726a1faa1f4', 'Translation stops if STOP codon at beginning of sequence', 'UAGUGG', '', NULL),
  ('5358a20b-6f4c-4893-bce4-f929001710f3', 'Translation stops if STOP codon at end of two-codon sequence', 'UGGUAG', 'Tryptophan', NULL),
  ('ba16703a-1a55-482f-bb07-b21eef5093a3', 'Translation stops if STOP codon at end of three-codon sequence', 'AUGUUUUAA', 'Methionine, Phenylalanine', NULL),
  ('4089bb5a-d5b4-4e71-b79e-b8d1f14a2911', 'Translation stops if STOP codon in middle of three-codon sequence', 'UGGUAGUGG', 'Tryptophan', NULL),
  ('2c2a2a60-401f-4a80-b977-e0715b23b93d', 'Translation stops if STOP codon in middle of six-codon sequence', 'UGGUGUUAUUAAUGGUUU', 'Tryptophan, Cysteine, Tyrosine', NULL),
  ('f6f92714-769f-4187-9524-e353e8a41a80', 'Sequence of two non-STOP codons does not translate to a STOP codon', 'AUGAUG', 'Methionine, Methionine', NULL),
  ('9eac93f3-627a-4c90-8653-6d0a0595bc6f', 'Unknown amino acids, not part of a codon, can''t translate', 'XYZ', NULL, 'Invalid codon'),
  ('9d73899f-e68e-4291-b1e2-7bf87c00f024', 'Incomplete RNA sequence can''t translate', 'AUGU', NULL, 'Invalid codon'),
  ('43945cf7-9968-402d-ab9f-b8a28750b050', 'Incomplete RNA sequence can translate if valid until a STOP codon', 'UUCUUCUAAUGGU', 'Phenylalanine, Phenylalanine', NULL);
