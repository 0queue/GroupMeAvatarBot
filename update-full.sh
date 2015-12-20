#!/bin/bash

MYDIR="$(dirname "$(which "$0")")"
GROUPID=`cat $MYDIR/GROUPID`
TOKEN=`cat $MYDIR/TOKEN`

if [ $# -ne 1 ]; then
    echo "Usage: update-full.sh <GNU date compatible date format>"
    exit 1
fi

if [ -z "$GROUPID" ]; then 
    echo "Cannot find Group ID in GROUPID"
    exit 1
fi

if [ -z "$TOKEN" ]; then
    echo "Cannot find API token in TOKEN"
    exit 2
fi

DAYSTILL=`$MYDIR/src/days-till.sh "$1"`

#create out.png
$MYDIR/src/create-avatar.sh template.png "$DAYSTILL" out.png
echo "out.png created."

RESPONSE=`$MYDIR/src/set-avatar.sh out.png "$GROUPID" "$TOKEN"`
CODE=`echo $RESPONSE | jq -r ".meta.code"`
if [ $CODE -ne 200 ]; then
    echo "Upload error."
    echo $RESPONSE
    exit 3
else
    echo "Upload success."
fi
