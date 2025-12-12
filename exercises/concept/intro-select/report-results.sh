#!/usr/bin/env bash
DB_FILE=$1
mapfile -t SLUGS < <(jq -r 'keys[]' test_data.json)

# Generate result for each test
rm -f results.txt
for SLUG in "${SLUGS[@]}"; do
    ACTUAL=$(sqlite3 -json $DB_FILE "SELECT * FROM ${SLUG};" | tr -d '[:space:]')
    if [ -z "$ACTUAL" ]; then
        ACTUAL="[]"
    fi
    jq -n --slurpfile test_data test_data.json --argjson got "${ACTUAL}" --arg slug "${SLUG}" -f test-result.jq >> results.txt
done

# Aggregate results
jq -n --slurpfile results results.txt '$results' > output.json
