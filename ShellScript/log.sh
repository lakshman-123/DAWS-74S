#!/bin/bash
Date=$(date +%F:%H:%M:%S)
logfile=/tmp/$script-$Date.log
script=$0
red="\e[31m"
green="\e[32m"
normal="\e[0m"
validate() {
    if [ $1 -ne 0 ]
then
 echo -e " $2  is $red failure"
 exit 1
else
 echo -e " $2 is $green success"
fi 

}
userid=$(id -u)
if [ $userid -ne 0 ]
then
 echo "This is not root user"
 exit 1
fi

yum install -y  mysql &>>$logfile
validate $? "mysql installing"

yum install postfix -y &>>$logfile
validate $? "postfix installing"