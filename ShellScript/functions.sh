#!/bin/bash

userid=$(id -u)
validate() {
    if [ $1 -ne 0 ];
then
 echo "$2 is failure"
 exit 1
else
 echo "$2 is success"
fi 
}

if [ $userid -ne 0 ];
then
 echo "This is not root user"
 exit 1
fi

yum install -y mysql
validate $? "mysql installing"

yum install postfix -y
validate $? "postfix installing"