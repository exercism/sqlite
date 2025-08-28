UPDATE "saddle-points"
   SET result = (
     WITH
       jtree AS (
         SELECT *,
                SUBSTR(fullkey, 1, INSTR(fullkey, ']')) rowkey,
                SUBSTR(fullkey, INSTR(fullkey, '][')) colkey
           FROM JSON_TREE(matrix) j
       ),
       max_single_in_row AS (
         SELECT MAX(value) value,
                fullkey,
                rowkey
           FROM jtree
          WHERE type = 'integer'
          GROUP BY rowkey
       ),
       max_mult_in_row AS (
         SELECT jtree.VALUE, jtree.fullkey, ms.rowkey
           FROM max_single_in_row ms, jtree
          WHERE ms.rowkey = jtree.rowkey
            AND ms.value = jtree.value
       ),
       min_single_in_col AS (
         SELECT MIN(value) value, fullkey, colkey
           FROM jtree
          WHERE type = 'integer'
          GROUP BY colkey
       ),
       min_mult_in_col AS (
         SELECT jtree.VALUE, jtree.fullkey, ms.colkey
           FROM min_single_in_col ms, jtree
          WHERE ms.colkey = jtree.colkey
            AND ms.value = jtree.VALUE
       ),
       get_coords AS (
         SELECT JSON(REPLACE(LTRIM(mc.fullkey, '$'), '][', ',')) coords
           FROM max_mult_in_row mr,
                min_mult_in_col mc
          WHERE mr.fullkey = mc.fullkey
       ),
       to_objects AS (
         SELECT JSON_OBJECT(
           'row',    JSON_EXTRACT(coords, '$[0]') + 1,
           'column', JSON_EXTRACT(coords, '$[1]') + 1
         ) AS jobj
           FROM get_coords
       )
     SELECT JSON_GROUP_ARRAY(JSON(jobj))
       FROM to_objects
     )
;
