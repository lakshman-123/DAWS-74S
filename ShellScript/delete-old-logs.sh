#!/bin/bash

Date=$(date +%F)
script=$0
logdir=/home/centos/app-logs
logfile=$logdir/$script-$Date.log
delete=$(find $logdir -name "*.log" -type f -mtime +14)
while read line
do
 echo "Deleting file $line" &>> $logfile
 rm -rf $line
done <<< $delete