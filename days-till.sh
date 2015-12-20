#!/bin/bash
# calculates the days until a date

USAGE="Usage: days-till.sh <GNU date compatible date format>"

if [ $# -ne 1 ]; then
    echo $USAGE
    exit 1
fi

NOW=`date +%y%m%d`
NOW=`date --date="$NOW" +%s`
THEN=`date --date="$1" +%s`

echo $(( ($THEN - $NOW) / (60*60*24) ))
