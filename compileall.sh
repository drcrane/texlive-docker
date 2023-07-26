#!/bin/sh
set -e
COMPILE_COMMAND="xelatex -interaction=nonstopmode -halt-on-error"
for entry in *.tex
do
	if [ "${entry}" == "*.tex" ]; then
		echo "Error, could not find any .tex files" 1>&2
		exit 1
	fi
	destination="$(basename -s .tex "${entry}").pdf"
	[ ! -f "${destination}" ] || [ "$entry" -nt "$destination" ] && ${COMPILE_COMMAND} "$entry"
done
