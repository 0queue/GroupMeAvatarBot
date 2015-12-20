#!/bin/bash
# takes a number to overlay on a given picture

USAGE="Usage: create-avatar.sh <source file> <Num> <destination file>"

if [ $# -ne 3 ]; then
    echo $USAGE
    exit 1
fi

if [ ! -e "$1" ]; then
    echo $USAGE
    exit 2
fi

convert $1 -gravity center -pointsize 100 -draw "text 0,-25 '$2'" $3
