import argparse
import difflib
import os
import re
import shutil
import sqlparse


def print_without_common_lines(original, parsed):
    d = difflib.Differ()
    diff = d.compare(
        original.splitlines(keepends=True), parsed.splitlines(keepends=True)
    )
    buffer = []
    counter = 1
    for line in diff:
        if line.startswith(" "):
            counter += 1
        if line.startswith("-"):
            buffer.append(f"Line {counter}:")
            counter += 1
        if line.startswith("-") or line.startswith("+") or line.startswith("?"):
            buffer.append(repr(line))
    print("\n".join(buffer))


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("--path", "-p", type=dir_path, required=True, help="Parsing for sql files in this directory and its subdirectories.")
    parser.add_argument("--backup", "-b", action="store_true", help="Backup files before processing.")
    parser.add_argument("--restore-backup", "-r", action="store_true", help="Restore files from backup, no other actions are run")
    parser.add_argument("--update", "-u", action="store_true", help="Overwrite sql files with new formatting")
    parser.add_argument("--dry-run", "-d", action="store_true", help="Only show changes, but do not write to files")

    return parser.parse_args()


def dir_path(path):
    if os.path.isdir(path):
        return path
    else:
        raise argparse.ArgumentTypeError(f"readable_dir:{path} is not a valid path")


def parse_sqlite_file(original):
    #sqlparse cannot parse sqlite files, and might mangle comments
    safeguard_sqlite_info = []
    for line in original.splitlines():
        if re.match(r'^[ ]*.|(--)', line):
            safeguard_sqlite_info.append("/*TEMP" + line + "TEMP*/")
        else:
            safeguard_sqlite_info.append(line)

    parsed = sqlparse.format(
        "\n".join(safeguard_sqlite_info),
        keyword_case="upper",
        identifier_case="lower",
        use_space_around_operators=True,
        reindent=True,
        wrap_after=120,
    )
    # keep comments in their own line
    parsed = re.sub(r"TEMP\*/[ ]*", "\n", parsed.replace("/*TEMP", "\n/*TEMP"))
    return re.sub(r"[\n]+/\*TEMP", '\n', parsed)


def parse_dir(args):
    for subdir, dirs, files in os.walk(args.path):
        for file in files:
            filepath = os.path.join(subdir, file)
            if args.restore_backup and filepath.casefold().endswith(".sql.backup"):
                shutil.move(filepath, filepath[: -len(".backup")])
                print(f"{filepath[:-len('.backup')]} has been restored")
                continue
            if not args.restore_backup and filepath.casefold().endswith(".sql"):
                original = ""
                with open(filepath) as sqlfile:
                    original = sqlfile.read()

                parsed = parse_sqlite_file(original)
                if parsed is original:
                    print(f"{filepath} is already formatted")
                else:
                    print(f"{filepath} is not formatted")
                    if args.dry_run:
                        print(f"The file should be reformatted like this:")
                        print_without_common_lines(original, parsed)
                    if args.backup:
                        shutil.copyfile(filepath, filepath + ".backup")
                        print(
                            f"The file has been backed up with file extension *.backup:"
                        )
                    if args.update:
                        with open(filepath, mode="w") as f:
                            f.write(parsed)
                        print(f"The file has been updated.")


def main():
    parse_dir(parse_arguments())


if __name__ == "__main__":
    main()
