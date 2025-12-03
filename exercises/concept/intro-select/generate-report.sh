DB_FILE=$1
SLUGS=$(jq -n --slurpfile test_data test_data.json '$test_data[0] | keys' | sed 's/[][",]//g')

# Generate result for each test
rm -f results.txt
for SLUG in $SLUGS; do
    ACTUAL=$(sqlite3 -json $DB_FILE "SELECT * FROM ${SLUG};" | tr -d '[:space:]')
    if [ -z "$ACTUAL" ]; then
        ACTUAL="[]"
    fi
    jq -n --slurpfile test_data test_data.json --argjson got ''${ACTUAL}'' --arg slug ${SLUG} -f test-result.jq >> results.txt
done

# Generate top-level report
jq -n --slurpfile results results.txt -f test-report.jq > output.json
