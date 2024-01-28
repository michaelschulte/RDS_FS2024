#!/bin/bash

# Recursive removal of files with ending _solutions.html
find . -type f -name '*_solutions.html' -exec rm -f {} \;

echo "Files with _solutions.html ending removed successfully."