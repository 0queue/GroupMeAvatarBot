#!/bin/bash

# set the avatar of a group id with a given file

USAGE="Usage: set-avatar.sh <file> <group id> <token>"

if [ $# -ne 3 ]; then
    echo $USAGE
    exit 1
fi

if [ ! -e "$1" ]; then
    echo $USAGE
    exit 2
fi

MYDIR="$(dirname "$(which "$0")")"
URL=`$MYDIR/upload-picture.sh "$1" $3`
RESPONSE=`curl -s "https://api.groupme.com/v3/groups/$2/update?access_token=$3" -H "Content-Type: application/json" -X POST -d "{\"image_url\": \"$URL\"}"`
echo $RESPONSE
