#!/bin/bash
# uploads a picture to GroupMe, and returns the URL

USAGE="Usage: upload-picture.sh <file> <token>"

if [ $# -ne 2 ]; then
    echo $USAGE
    exit 1
fi

if [ ! -e "$1" ]; then
    echo $USAGE
    exit 1
fi

RESPONSE=`curl -s -F "file=@$1" https://image.groupme.com/pictures?access_token=$2`
URL=`echo $RESPONSE | jq -r ".payload.url"`

if [ $? -ne 0 ]; then
    echo "ERROR"
    exit 2
fi

if [ "$URL" = "null" ]; then
    echo "Bad response"
    exit 3
fi

echo $URL
