#!/bin/sh

# A (very) simplistic way to get the current dir
CUR_DIR=${0%/*}
ROOT_DIR=$CUR_DIR/..
TEMP_LOG=/tmp/.templog
VERSION_MD=$ROOT_DIR/VERSION.md

# Include the prerequisites script
if [ -f $CUR_DIR/prereqs.sh ]; then
	. $CUR_DIR/prereqs.sh
fi

# Check the prerequisites that we are going to use in this script
prereqs cd mkdir tar gzip

# Get the major and minor version numbers
if [ ! -f $VERSION_MD ]; then
	MAJOR_VERSION=0
	MINOR_VERSION=1
else
	MAJOR_VERSION=`grep '^Version [0-9]\+\.[0-9]\+' $VERSION_MD | \
	               head -1 | \
	               sed 's/Version \([0-9]\+\)\.\([0-9]\+\)/\1/'`
	MINOR_VERSION=`grep '^Version [0-9]\+\.[0-9]\+' $VERSION_MD | \
	               head -1 | \
	               sed 's/Version \([0-9]\+\)\.\([0-9]\+\)/\2/'`
	GIT_LOG=$MAJOR_VERSION.$MINOR_VERSION..HEAD
	MINOR_VERSION=$((MINOR_VERSION + 1))
fi
echo "Releasing Version $MAJOR_VERSION.$MINOR_VERSION"

# Build up the version history since last release
echo    "Version History"                         >  $TEMP_LOG
echo    "==============="                         >> $TEMP_LOG
echo    ""                                        >> $TEMP_LOG
echo    "Version $MAJOR_VERSION.$MINOR_VERSION"   >> $TEMP_LOG
echo -n "--------"                                >> $TEMP_LOG
i=0
while [ $i -lt $((${#MAJOR_VERSION} + 1 + ${#MINOR_VERSION})) ]; do
	echo -n "-"                               >> $TEMP_LOG
	i=$(($i + 1))
done
echo    ""                                        >> $TEMP_LOG
git log --pretty=format:"* %s" $GIT_LOG $ROOT_DIR >> $TEMP_LOG
[ -f $VERSION_MD ] && tail -n +3 $VERSION_MD      >> $TEMP_LOG

# Update the version history
cp -f $TEMP_LOG $VERSION_MD
rm -f $TEMP_LOG
git commit $VERSION_MD -m "Add version $MAJOR_VERSION.$MINOR_VERSION to the version history" 1>/dev/null

# Tag it
git tag -a $MAJOR_VERSION.$MINOR_VERSION -m "Version $MAJOR_VERSION.$MINOR_VERSION release" 1>/dev/null

# Check the arguments
if [ $# -gt 1 ]; then
	echo "Usage: ${BASE##*/} [-b]"
	echo "       -b  Bump up the major version number"
	exit $E_BADARGS
elif [ $# -eq 1 ]; then
	MAJOR_VERSION=$1
fi

# Do the actual packaging down here
mkdir $ROOT_DIR/build -p
cd $ROOT_DIR
rm -f build/burning-boots-testingide-$MAJOR_VERSION.$MINOR_VERSION.tar.gz
tar -cf build/burning-boots-testingide-$MAJOR_VERSION.$MINOR_VERSION.tar source package.js
gzip build/burning-boots-testingide-$MAJOR_VERSION.$MINOR_VERSION.tar

echo "Complete"
echo " - Released package is at build/burning-boots-testingide-$MAJOR_VERSION.$MINOR_VERSION.tar.gz"
echo " - You need to push tags and commits (git push --tags)"
