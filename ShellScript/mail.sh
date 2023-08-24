#!/bin/bash

TO_ADDRESS=$1
SUBJECT=$2
BODY=$3
TEAM_NAME=$4
ALERT_TYPE=$5

#echo "all args: $@"
FINAL_BODY=$(sed -e 's/TEAM_NAME/DEVOPS_TEAM/g' -e 's/ALERT_TYPE/High Disk Usage/g' -e "s/ALERT_TYPE/$BODY" template.html)

echo "$FINAL_BODY" | mail -s "$SUBJECT" $TO_ADDRESS