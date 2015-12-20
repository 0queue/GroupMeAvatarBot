#!/bin/bash

# A utility to find a group id based on name, to be run once for setup

if [ $# -ne 2 ]; then
    echo "Usage: find-group-id.sh <name> <token>"
    exit 1
fi

RESPONSE=`curl -s https://api.groupme.com/v3/groups?access_token=$2`
ID=`echo $RESPONSE | jq -r ".response[] | select(.name | contains(\"$1\")) | .id"`

if [ $? -ne 0 ]; then
    echo "ERROR"
    exit 2
fi

if [ "$ID" = "null" ]; then
    echo "Bad response"
    exit 3
fi

echo $ID
