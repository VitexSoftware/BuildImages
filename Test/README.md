ldd2debs
========

Find packaging dependencies for binaries

This script provides information about package dependencies for a given binary.

Usage:
  ./ldd2debs [OPTION] BINARY

Options:
  --help, -h       Display help information and usage examples.
  --version, -v    Display the version of the script.

Example:
  ./ldd2debs /bin/bash

The script uses `ldd` to list the shared library dependencies of the given binary,
then uses `apt-file search` to find the packages that provide those libraries,
and finally outputs a sorted list of unique package names.


(also Test/Example for https://github.com/VitexSoftware/BuildImages/)
