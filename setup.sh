#!/bin/bash
# sets GROUPID

MYDIR="$(dirname "$(which "$0")")"

if [ $# -ne 2 ]; then
    echo "Usage: setup.sh <group name> <template image>"
    exit 1
fi

if [ ! -e "$2" ]; then
    echo "Could not find $2"
    exit 2
fi

TOKEN=`cat TOKEN`
if [ -z "$TOKEN" ]; then
    echo "Please set up a Group Me API access token.  Go to dev.groupme.com and create an application, then copy the key to the TOKEN file."
    exit 3
fi

ID=`$MYDIR/src/find-group-id.sh "$1" $TOKEN`
if [ $? -eq 0 ]; then
    echo $ID > GROUPID
    echo "Wrote GROUPID"
else
    echo "Error when finding Group ID"
fi

cp "$2" $MYDIR/template.png
echo "$2 copied to template.png"

# test deps?
which convert > /dev/null
if [ $? -eq 0 ]; then
    echo "Found convert"
else
    echo "Did NOT find convert, please install ImageMagick"
fi

which jq > /dev/null
if [ $? -eq 0 ]; then
    echo "Found jq"
else
    echo "Did NOT find jq, please install"
fi

echo
echo "Setup complete"
