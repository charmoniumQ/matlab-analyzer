#!/usr/bin/env bash

dest=matlab-parser/gen
source=MATLAB.g

rm -rf "${dest}"
mkdir -p "${dest}"
antlr4 -o "${dest}" -Dlanguage=Python3 -no-listener "${source}"
rm "${dest}"/*.interp "${dest}"/*.tokens
touch "${dest}"/__init__.py
