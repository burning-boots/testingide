#!/bin/sh

BASE=$0
E_BADARGS=65

# Check the arguments
if [ $# -gt 1 ]; then
	echo "Usage: ${BASE##*/} path/to/enyo/dir"
	exit $E_BADARGS
elif [ $# -eq 1 ]; then
	ENYO_DIR=$1
else
	ENYO_DIR=../../enyo
fi

# Find the enyo script
if ! [ -f $ENYO_DIR/tools/minify.sh ]; then
	echo "Couldn't find 'tools/minify.sh' at enyo directory location '$ENYO_DIR'."
	if [ -d $ENYO_DIR ]; then
		echo "This is what is there:"
		ls $ENYO_DIR
	fi
	echo "Exiting"
	exit
fi

# Hardcore minifiying magic!
$ENYO_DIR/tools/minify.sh -no-alias -output ../build/testingide package.js

