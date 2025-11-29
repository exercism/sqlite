$test_data[0][$slug] as $single_test_data
| $single_test_data.description as $description
| $single_test_data.expected as $expected
| $single_test_data.task_id as $task_id
| if $task_id then {$task_id} else {} end as $entry
| $entry + {$description} as $entry
| if $got != $expected then 
      # TODO: Make the message more human-readable
      "Expected " + ($expected | tostring) + ", but got " + ($got | tostring) as $message
      | $entry + {"status": "fail", $message} 
  else 
      $entry + {"status": "pass"} 
  end
