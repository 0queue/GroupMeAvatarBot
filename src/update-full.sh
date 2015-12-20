#!/bin/bash

MYDIR="$(dirname "$(which "$0")")"
GROUPID=`cat $MYDIR/GROUPID`
TOKEN=`cat $MYDIR/TOKEN`

if [ -z "$GROUPID" ]; then 
    echo "Cannot find Group ID in GROUPID"
    exit 1
fi

if [ -z "$TOKEN" ]; then
    echo "Cannot find API token in TOKEN"
    exit 2
fi

DAYSTILL=`$MYDIR/days-till.sh 160201`

#create out.png
$MYDIR/create-avatar.sh template.png "$DAYSTILL" out.png

$MYDIR/set-avatar.sh out.png "$GROUPID" "$TOKEN"
