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
  usage=$($line|awk '{print $6}'| cut -d % -f1)


done <<< $disk_usage