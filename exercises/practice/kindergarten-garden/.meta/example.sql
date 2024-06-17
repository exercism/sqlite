UPDATE "kindergarten-garden"
SET result = (
    WITH plants(p) AS (
        VALUES (1), (2), (1 + instr(diagram, char(10))), (2 + instr(diagram, char(10)))
    )
    SELECT group_concat(
        CASE SUBSTR(diagram, (unicode(student) - 65) * 2 + p, 1)
        WHEN 'G' THEN 'grass'
        WHEN 'V' THEN 'violets'
        WHEN 'C' THEN 'clover'
        WHEN 'R' THEN 'radishes'
        END
    ) FROM plants
);
