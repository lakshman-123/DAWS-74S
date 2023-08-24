#!/bin/bash

TO_ADDRESS=$1
SUBJECT=$2
BODY=$(sed -e 's/[]\/$*.^[]/\\&/g' <<< $3)
TEAM_NAME=$4
ALERT_TYPE=$5

#echo "all args: $@"
FINAL_BODY=$(sed -e "s/TEAM_NAME/$TEAM_NAME/g" -e "s/ALERT_TYPE/$ALERT_TYPE/g" -e "s/MESSAGE/$BODY/" template.html)

echo "$FINAL_BODY" | mail -s "$(echo -e "$SUBJECT\nContent-Type: text/html")" $TO_ADDRESS