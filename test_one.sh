#!/usr/bin/env sh

set -e -x

project_path="$(dirname ""$0"")"

if [ ! -f build/MATLABParser.py ]; then
	pipenv run python -m antlr4_grun.main compile "${project_path}/MATLAB.g" --output-dir "${project_path}/build/"
fi

pipenv run python -m antlr4_grun.main parse MATLAB source --location "${project_path}/build/" ${1}
