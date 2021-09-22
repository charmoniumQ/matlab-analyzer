#!/usr/bin/env bash

set -e -x

project_path="$(dirname ""$0"")"

if [ ! -f build/MATLABParser.java ]; then
	antlr4 "${project_path}/MATLAB.g" -o "${project_path}/build/"
fi
if [ ! -f build/MATLABParser.class ]; then
	javac $(find "${project_path}/build/" -name '*.java')
fi

if [ "${1}" = "--rule" ]; then
	shift
	rule="${1}"
	shift
else
	rule="source"
fi

if [ "${1}" = "--input" ]; then
	shift
	input="../${1}"
	shift
fi

cd "${project_path}/build"
grun MATLAB "${rule}" ${input} ${@}
