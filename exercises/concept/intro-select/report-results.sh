#!/usr/bin/env bash
db_file=$1
mapfile -t slugs < <(jq -r 'keys[]' test_data.json)

# Generate result for each test
for slug in "${slugs[@]}"; do
    actual=$(sqlite3 -json $db_file "SELECT * FROM ${slug};")
    if [[ -z "$actual" ]]; then
        actual="[]"
    fi
    jq -n --slurpfile test_data test_data.json --argjson got "${actual}" --arg slug "${slug}" -f test-result.jq
done > results.txt

# Aggregate results
jq -n --slurpfile results results.txt '$results' > output.json
