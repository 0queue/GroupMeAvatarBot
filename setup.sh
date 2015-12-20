#!/bin/bash
# sets GROUPID

MYDIR="$(dirname "$(which "$0")")"

if [ $# -ne 2]; then
    echo "Usage: setup.sh <group name> <template image>"
    exit 1
fi

if [ ! -e "$2" ]; then
    echo "Could not find $2"
    exit 2
fi

ID=`$MYDIR/src/find-group-id.sh "$1"`

if [ $? -eq 0 ]; then
    echo $ID > GROUPID
    echo "Wrote GROUPID"
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
echo
echo "Setup complete, please create a TOKEN file holding only your GroupMe API token (see dev.groupme.com, and create an application)"
