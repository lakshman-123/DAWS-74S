#!/bin/bash

userid=$(id -u)
R="\e[31m"
N="\e[0m"

if [ $userid -ne 0 ] 
then
  echo -e "$R Error not root user $N"
  exit 1
fi 

for i in $@
do
 yum install $i -y
done 
