#!/bin/bash

userid=$(id -u)

if [ $userid -ne 0 ];
then
 echo "This is not root user"
 exit 1
fi

yum install -y mysql

if [ $? -ne 0 ];
then
 echo "Error mysql installation failure"
 exit 1
else
 echo "mysql installation is success"
fi 

yum install postfix -y
if [ $? -ne 0 ];
then
 echo "Error postfix installation failure"
 exit 1
else
 echo "postfix installation is success"
fi 