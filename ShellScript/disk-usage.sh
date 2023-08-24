#!/bin/bash
Date=$(date +%F:%H:%M:%S)
script=$0
logfile=$logdir/$script-$Date.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

disk_usage=$( df -hT | grep -vE  'tmpfs|Filesystem')
disk_threshold=1

while IFS= read line
do
  echo "disk_usage:$line"

done <<< $disk_usage