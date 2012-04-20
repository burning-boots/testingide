#!/bin/sh

BASE=$0

prereqs () {
	local E_BADARGS=65
	if [ $# -eq 0 ]; then
		echo "Usage: ${BASE##*/} [prerequisite_program] [another_program...]"
		exit $E_BADARGS
	fi
	for ARG in $*; do
		hash $ARG 2>&-
		if [ $? -ne 0 ]; then
			echo "Failed to find prerequisite: $ARG"
			echo "Please install it with you package manager"
			echo "Exiting"
			exit 1
		fi
	done
}

# If the script was not sourced we need to run the function
[ "${BASE##*/}" == "prereqs.sh" ] && prereqs $*
