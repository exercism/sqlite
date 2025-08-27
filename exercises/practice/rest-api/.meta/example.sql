UPDATE 'rest-api' AS CURRENT
SET
  result = (
    SELECT
      json_object(
        'users',
        IIF(
          json_type(DB.value) IS NULL,
          json_array(),
          json_array(DB.value)
        )
      )
    FROM
      'rest-api' AS RA
      LEFT JOIN json_each(RA.payload, '$.users') AS PL ON RA.payload = PL.json
      LEFT JOIN json_each(RA.database, '$.users') AS DB ON RA.database = DB.json
      AND json_extract(DB.value, '$.name') = PL.value
    WHERE
      (RA.database, RA.payload) = (CURRENT.database, CURRENT.payload)
  )
WHERE
  url = '/users';

UPDATE 'rest-api' AS CURRENT
SET
  result = json_object(
    'name',
    json_extract(payload, '$.user'),
    'owes',
    json_object(),
    'owed_by',
    json_object(),
    'balance',
    0
  )
WHERE
  url = '/add';

UPDATE 'rest-api' AS CURRENT
SET
  result = json_array(
    -- update the lender:
    (
      SELECT
        json_object(
          'name',
          json_extract(payload, '$.lender'),
          'owes',
          json_patch(
            json_extract(value, '$.owes'),
            json_object(
              json_extract(payload, '$.borrower'),
              IIF(relative_balance < 0, - relative_balance, NULL)
            )
          ),
          'owed_by',
          json_patch(
            json_extract(value, '$.owed_by'),
            json_object(
              json_extract(payload, '$.borrower'),
              IIF(relative_balance > 0, relative_balance, NULL)
            )
          ),
          'balance',
          json_extract(value, '$.balance') + json_extract(payload, '$.amount')
        )
      FROM
        (
          SELECT
            *,
            IFNULL(
              json_extract(
                json_extract(value, '$.owed_by'),
                '$.' || json_extract(payload, '$.borrower')
              ),
              0
            ) - IFNULL(
              json_extract(
                json_extract(value, '$.owes'),
                '$.' || json_extract(payload, '$.borrower')
              ),
              0
            ) + json_extract(payload, '$.amount') AS relative_balance
          FROM
            json_each(database, '$.users')
          WHERE
            json = database
            AND json_extract(value, '$.name') == json_extract(payload, '$.lender')
        )
    ),
    -- update the borrower:
    (
      SELECT
        json_object(
          'name',
          json_extract(payload, '$.borrower'),
          'owes',
          json_patch(
            json_extract(value, '$.owes'),
            json_object(
              json_extract(payload, '$.lender'),
              IIF(relative_balance < 0, - relative_balance, NULL)
            )
          ),
          'owed_by',
          json_patch(
            json_extract(value, '$.owed_by'),
            json_object(
              json_extract(payload, '$.lender'),
              IIF(relative_balance > 0, relative_balance, NULL)
            )
          ),
          'balance',
          json_extract(value, '$.balance') - json_extract(payload, '$.amount')
        )
      FROM
        (
          SELECT
            *,
            IFNULL(
              json_extract(
                json_extract(value, '$.owed_by'),
                '$.' || json_extract(payload, '$.lender')
              ),
              0
            ) - IFNULL(
              json_extract(
                json_extract(value, '$.owes'),
                '$.' || json_extract(payload, '$.lender')
              ),
              0
            ) - json_extract(payload, '$.amount') AS relative_balance
          FROM
            json_each(database, '$.users')
          WHERE
            json = database
            AND json_extract(value, '$.name') == json_extract(payload, '$.borrower')
        )
    )
  )
WHERE
  url = '/iou';

-- order the result
UPDATE 'rest-api' AS CURRENT
SET
  result = (
    SELECT
      json_object('users', json_group_array(json(value)))
    FROM
      (
        SELECT
          value
        FROM
          json_each(result)
        ORDER BY
          value
      )
  )
WHERE
  url = '/iou';
