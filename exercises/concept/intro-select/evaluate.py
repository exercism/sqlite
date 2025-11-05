from pathlib import Path
import json
import sys


def gather_results(filename):
    text = Path(filename).read_text()
    list_start_indices = find_all_occurrences('[', text)
    list_end_indices = find_all_occurrences(']', text)
    return [
        json.loads(text[begin:end+1])
        for begin, end in zip(list_start_indices, list_end_indices)
    ]


def find_all_occurrences(char, string):
    return [i for i, c, in enumerate(string) if c == char]


def format_diff(expected, actual):
    return ( 
        f"\tExpected:\n"
        f"\t\t{expected}\n"
        f"\tActual:\n"
        f"\t\t{actual}"
    )

def report_results(all_test_data, actual_results):
    results = []
    for test_data, actual in zip(all_test_data, actual_results):
        result = {'description': test_data['description']}
        if test_data['expected'] == actual:
            result['status'] = 'pass'
        else:
            result['status'] = 'fail'
            result['message'] = "Expected: " + json.dumps(test_data['expected'])
            result['output'] = "Actual: " + json.dumps(actual)
        results.append(result)
    return make_result_report(results)


def make_result_report(results):
    status = 'pass' if all(r['status'] == 'pass' for r in results) else 'fail'
    return {
        "version": 3,
        "status": status,
        "tests": results
    }


def main():
    test_data_filename, user_output_filename = sys.argv[1:3]
    test_data = json.loads(Path(test_data_filename).read_text())
    actual_results = gather_results(user_output_filename)
    results = report_results(test_data, actual_results)
    Path('results.json').write_text(json.dumps(results, indent=2))


if __name__ == '__main__':
    main()
