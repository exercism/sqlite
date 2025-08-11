UPDATE pangram
   SET result = (
         INSTR(LOWER(sentence), 'a') > 0
     AND INSTR(LOWER(sentence), 'b') > 0
     AND INSTR(LOWER(sentence), 'c') > 0
     AND INSTR(LOWER(sentence), 'd') > 0
     AND INSTR(LOWER(sentence), 'e') > 0
     AND INSTR(LOWER(sentence), 'f') > 0
     AND INSTR(LOWER(sentence), 'g') > 0
     AND INSTR(LOWER(sentence), 'h') > 0
     AND INSTR(LOWER(sentence), 'i') > 0
     AND INSTR(LOWER(sentence), 'j') > 0
     AND INSTR(LOWER(sentence), 'k') > 0
     AND INSTR(LOWER(sentence), 'l') > 0
     AND INSTR(LOWER(sentence), 'm') > 0
     AND INSTR(LOWER(sentence), 'n') > 0
     AND INSTR(LOWER(sentence), 'o') > 0
     AND INSTR(LOWER(sentence), 'p') > 0
     AND INSTR(LOWER(sentence), 'q') > 0
     AND INSTR(LOWER(sentence), 'r') > 0
     AND INSTR(LOWER(sentence), 's') > 0
     AND INSTR(LOWER(sentence), 't') > 0
     AND INSTR(LOWER(sentence), 'u') > 0
     AND INSTR(LOWER(sentence), 'v') > 0
     AND INSTR(LOWER(sentence), 'w') > 0
     AND INSTR(LOWER(sentence), 'x') > 0
     AND INSTR(LOWER(sentence), 'y') > 0
     AND INSTR(LOWER(sentence), 'z') > 0
   );
