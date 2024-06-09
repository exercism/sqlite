UPDATE 'rest-api' AS CURRENT
SET result = (
  SELECT json_object('users', IIF(json_type(DB.value) IS NULL, json_array(), json_array(DB.value)))
  FROM 'rest-api' AS RA
    LEFT JOIN json_each(RA.payload, '$.users') AS PL ON RA.payload = PL.json
    LEFT JOIN json_each(RA.database, '$.users') AS DB ON RA.database = DB.json AND DB.value ->> 'name' = PL.value
  WHERE (RA.database, RA.payload) = (CURRENT.database, CURRENT.payload)
)
WHERE url = '/users';


UPDATE 'rest-api' AS CURRENT
SET result = json_object('name', payload ->> 'user', 'owes', json_object(), 'owed_by', json_object(), 'balance', 0)
WHERE url = '/add';


UPDATE 'rest-api' AS CURRENT
SET result = json_array(
  -- update the lender:
  (
    SELECT json_object(
      'name', payload ->> 'lender',
      'owes', json_patch(
        value -> 'owes',
        json_object(
          payload ->> 'borrower',
          IIF(relative_balance < 0, -relative_balance, NULL)
        )
      ),
      'owed_by', json_patch(
        value -> 'owed_by',
        json_object(
          payload ->> 'borrower',
          IIF(relative_balance > 0, relative_balance, NULL)
        )
      ),
      'balance', (value ->> 'balance') + (payload ->> 'amount')
    )
    FROM (
      SELECT
        *,
        IFNULL(value -> 'owed_by' ->> (payload ->> 'borrower'), 0) -
        IFNULL(value -> 'owes' ->> (payload ->> 'borrower'), 0) + (payload ->> 'amount') AS relative_balance
      FROM json_each(database, '$.users')
      WHERE json = database AND value ->> 'name' == payload ->> 'lender'
    )
  ),
  -- update the borrower:
  (
    SELECT json_object(
      'name', payload ->> 'borrower',
      'owes', json_patch(
        value -> 'owes',
        json_object(
          payload ->> 'lender',
          IIF(relative_balance < 0, -relative_balance, NULL)
        )
      ),
      'owed_by', json_patch(
        value -> 'owed_by',
        json_object(
          payload ->> 'lender',
          IIF(relative_balance > 0, relative_balance, NULL)
        )
      ),
      'balance', (value ->> 'balance') - (payload ->> 'amount')
    )
    FROM (
      SELECT
        *,
        IFNULL(value -> 'owed_by' ->> (payload ->> 'lender'), 0) -
        IFNULL(value -> 'owes' ->> (payload ->> 'lender'), 0) - (payload ->> 'amount') AS relative_balance
      FROM json_each(database, '$.users')
      WHERE json = database AND value ->> 'name' == payload ->> 'borrower'
    )
  )
)
WHERE url = '/iou';

-- order the result
UPDATE 'rest-api' AS CURRENT
SET result = (
  SELECT json_object('users', json_group_array(json(value)))
  FROM (
    SELECT value
    FROM json_each(result)
    ORDER BY value
  )
)
WHERE url = '/iou';