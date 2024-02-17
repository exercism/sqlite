# Installation

## Target Version

Testing for this track is based on version __3.37__.
While users may have newer versions installed, they should be aware that some features may not work with our test runner.
Features can be compared on [SQLite version history][version-history].
The version was chosen to maintain maintain compatibility with users on Ubuntu 22.04, the current LTS version.
When the next LTS comes into rotation, we will also update our track.

## Windows

To install SQLite on Windows, follow these steps:

1. Download the precompiled windows binaries from the [official download page][sqlite-download].
2. Extract the downloaded ZIP file to a directory of your choice.
   For example, `C:\Program Files\sqlite3`.
3. Add the directory containing `sqlite3.exe` to the system's PATH environment variable.
   The process is a little different for each Windows version, but the information should be easy to search.
   For example [instructions for Windows 11][windows-11-install] and [Windows 10][windows-10-install].

## macOS

On macOS, SQLite is pre-installed.
However, if you need a newer version, you can use Homebrew:

```bash
brew install sqlite
```

## Ubuntu / Debian

For Ubuntu and Debian-based systems, you can install SQLite using apt:

```bash
sudo apt install sqlite3
```

## CentOS / Fedora / RHEL

On CentOS, Fedora, and Red Hat-based systems, you can install SQLite using yum or dnf:

```bash
sudo yum install sqlite3
# OR
sudo dnf install sqlite3
```

## Arch Linux

On Arch Linux, you can install SQLite using pacman:

```bash
sudo pacman -S sqlite
```

## Other installation routes and older versions

Refer to the [SQLite download page][sqlite-download] for more information and alternative installation methods.
The `Build Product Names and Info` section has the naming template for different SQLite versions, so you should be able to search for your desired version with your favorite search engine.

[version-history]: https://www.sqlite.org/changes.html
[windows-11-install]: https://windowsloop.com/how-to-add-to-windows-path/
[windows-10-install]: https://helpdeskgeek.com/windows-10/add-windows-path-environment-variable/
[sqlite-download]: https://www.sqlite.org/download.html
