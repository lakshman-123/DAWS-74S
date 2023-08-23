#!/bin/bash

userid=$(id -u)
if [ $userid -ne 0 ] 
then
  echo "Error not root user"
  exit 1
fi  
for i in $@
do
 yum install $i -y
done 
