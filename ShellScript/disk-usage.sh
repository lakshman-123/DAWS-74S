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
message=""

while IFS= read line
do
  usage=$(echo $line | awk '{print $6}' | cut -d % -f1)
  partition=$(echo $line | awk '{print $1}')
  if [ $usage -gt $disk_threshold ];
  then
     message+="HIGH DISK USAGEE ON $partition:$usage \n"
  fi
done <<< $disk_usage


echo -e "message:$message"
