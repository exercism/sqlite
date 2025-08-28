UPDATE "sum-of-multiples"
   SET result = (
     WITH sets (multiples) AS (
       SELECT (
         SELECT JSON_GROUP_ARRAY(s.value)
           FROM GENERATE_SERIES(1, "limit" - 1) s
          WHERE s.value % j.value = 0
       )
         FROM JSON_EACH(factors) j
     )
     SELECT COALESCE(SUM(DISTINCT(j.value)), 0)
       FROM sets, JSON_EACH(multiples) j
   )
;
