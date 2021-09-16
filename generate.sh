#!/usr/bin/env bash

dest=matlab-parser/gen
source=MATLAB.g

rm -rf "${dest}"
mkdir -p "${dest}"
antlr4 -o "${dest}" -Dlanguage=Python3 -listener "${source}"
touch "${dest}"/__init__.py
