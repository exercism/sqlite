($results | map(.status) | if all(. == "pass") then "pass" else "fail" end) as $status

| {
  "version": 3,
  "status": $status,
  "tests": $results
}
