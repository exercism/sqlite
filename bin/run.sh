#!/usr/bin/env sh

# Synopsis:
# Run the test runner on a solution.

# Arguments:
# $1: exercise slug
# $2: path to solution folder
# $3: path to output directory

# Output:
# Writes the test results to a results.json file in the passed-in output directory.
# The test results are formatted according to the specifications at https://github.com/exercism/docs/blob/main/building/tooling/test-runners/interface.md

# Example:
# ./bin/run.sh two-fer path/to/solution/folder/ path/to/output/directory/

# If any required arguments is missing, print the usage and exit
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "usage: ./bin/run.sh exercise-slug path/to/solution/folder/ path/to/output/directory/"
    exit 1
fi

slug="$1"
solution_dir=$(realpath "${2%/}")
output_dir=$(realpath "${3%/}")
results_file="${output_dir}/results.json"

# Create the output directory if it doesn't exist
mkdir -p "${output_dir}"

echo "${slug}: testing..."

# Run the tests for the provided implementation file and redirect stdout and
# stderr to capture it
cd "${solution_dir}"
echo "${solution_dir}"
test_output=$(sqlite3 '' --init "./${slug}_test.sql" -bail  '.exit' 2>&1)

# Write the results.json file based on the exit code of the command that was 
# just executed that tested the implementation file
if [ $? -ne 0 ]; then
    jq -n --arg output "${test_output}" '{version: 3, status: "error", message: $output}' > ${results_file}
else
    cat ./output.json | jq '{ "version": 3, "status": "fail", "message": null, "tests": . } | .status = if  any(.tests[]; .status == "fail") then "fail" else "pass" end' > results.json
    rm ./output.json
    cat ./results.json | jq '.tests[] | select(.status == "fail").output = "yahoo" | del(..|nulls)' > results.json
    rm ./user_output.md || true
fi

echo "${slug}: done"
