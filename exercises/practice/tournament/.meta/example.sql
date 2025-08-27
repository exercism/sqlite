UPDATE tournament
SET
  result = (
    WITH
      to_columns (team_1, team_2, point_1, point_2) AS (
        WITH RECURSIVE
          to_lines (string, line) AS (
            VALUES
              (input || CHAR(10), NULL)
            UNION ALL
            SELECT
              SUBSTR(string, INSTR(string, CHAR(10)) + 1),
              SUBSTR(string, 1, INSTR(string, CHAR(10)) - 1)
            FROM
              to_lines
            WHERE
              INSTR(string, CHAR(10))
          )
        SELECT
          team_1,
          team_2,
          CASE outcome
            WHEN 'win' THEN 3
            WHEN 'draw' THEN 1
            WHEN 'loss' THEN 0
          END AS points_1,
          CASE outcome
            WHEN 'win' THEN 0
            WHEN 'draw' THEN 1
            WHEN 'loss' THEN 3
          END AS points_2
        FROM
          (
            SELECT
              SUBSTR(line, 1, INSTR(line, ';') - 1) AS team_1,
              SUBSTR(
                line,
                INSTR(line, ';') + 1,
                INSTR(SUBSTR(line, INSTR(line, ';') + 1), ';') - 1
              ) AS team_2,
              REPLACE(line, RTRIM(line, REPLACE(line, ';', '')), '') AS outcome
            FROM
              to_lines
            WHERE
              line NOTNULL
          )
      ),
      to_table AS (
        SELECT
          team,
          point,
          IIF(point = 3, 1, 0) AS win,
          IIF(point = 1, 1, 0) AS drawn,
          IIF(point = 0, 1, 0) AS lost
        FROM
          (
            SELECT
              team_1 team,
              point_1 point
            FROM
              to_columns
            WHERE
              team_1 <> ''
            UNION ALL
            SELECT
              team_2 team,
              point_2 point
            FROM
              to_columns
            WHERE
              team_2 <> ''
          )
      ),
      to_aggregate AS (
        SELECT
          team,
          COUNT(*) played,
          SUM(win) win,
          SUM(drawn) drawn,
          SUM(lost) lost,
          SUM(point) point
        FROM
          to_table
        GROUP BY
          team
      ),
      to_format AS (
        SELECT
          PRINTF(
            '%-31s| %2d | %2d | %2d | %2d | %2d',
            team,
            played,
            win,
            drawn,
            lost,
            point
          )
        FROM
          to_aggregate
        ORDER BY
          point DESC,
          team ASC
      )
    SELECT
      group_concat(line, CHAR(10))
    FROM
      (
        SELECT
          'Team                           | MP |  W |  D |  L |  P' line
        UNION ALL
        SELECT
          *
        FROM
          to_format
      )
  );
