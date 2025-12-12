def columns:
    if (. | length) == 0 then []
    else .[0] | keys
    end;

def rows:
    map(to_entries | map(.value));

def failure_message(got; expected):
    (got | columns | tostring)  as $got_columns
    | (expected | columns | tostring) as $expected_columns
    | if $got_columns != $expected_columns then
        "Expected columns " + $expected_columns + "; but got " + $got_columns
      else
        (got | rows | tostring) as $got_rows
        | (expected | rows | tostring) as $expected_rows
        | "With columns " + $got_columns + ", \nbexpected " + $expected_rows + ";\nbut got " + $got_rows
      end;

$test_data[0][$slug] as $single_test_data
| $single_test_data.description as $description
| $single_test_data.expected as $expected
| $single_test_data.task_id as $task_id
| if $task_id then {$task_id} else {} end as $entry
| $entry += {$description}
| if $got != $expected then 
      $entry + {"status": "fail", "message": failure_message($got; $expected)} 
  else 
      $entry + {"status": "pass"} 
  end
