#!/bin/bash

userid=$(id -u)
validate() {
    if [ $1 -ne 0 ]
then
 echo "Error mysql installation failure"
 exit 1
else
 echo "mysql installation is success"
fi 

}

if [ $userid -ne 0 ]
then
 echo "This is not root user"
 exit 1
fi

yum install -y mysql
validate $?

yum install postfix -y
validate $?