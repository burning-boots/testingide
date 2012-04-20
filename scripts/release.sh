#!/bin/sh

# A (very) simplistic way to get the current dir
CUR_DIR=${0%/*}

# Include the prerequisites script
if [ -f $CUR_DIR/prereqs.sh ]; then
	. $CUR_DIR/prereqs.sh
fi

# Check the prerequisites that we are going to use in this script
prereqs cd mkdir tar gzip

# Check the arguments
if [ $# -gt 1 ]; then
	echo "Usage: ${BASE##*/} [major_release_number]"
	exit $E_BADARGS
elif [ $# -eq 1 ]; then
	MAJOR_VERSION=$1
else
	MAJOR_VERSION=0
fi

# Tarball this stuff up
mkdir $CUR_DIR/build -p
cd $CUR_DIR/..
tar -cf build/burning-boots-testingide-0.0.1.tar source package.js
gzip build/burning-boots-testingide-0.0.1.tar

exit $?
