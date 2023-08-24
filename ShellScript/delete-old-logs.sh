#!/bin/bash

Date=$(date +%F:%H:%M:%S)
script=$0
logdir=/home/centos/app-logs
logfile=$logdir/$script-$Date.log
delete=$(find $logdir -name "*.log" -type f -mtime +14)
echo "script started executing at $Date"
while read line
do
 echo "Deleting file $line" &>> $logfile
 rm -rf $line
done <<< $delete

