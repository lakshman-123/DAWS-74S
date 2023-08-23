#!/bin/bash
Date=$(date +%F:%H:%M:%S)
logfile=/tmp/$script-$Date.log
script=$0
validate() {
    if [ $1 -ne 0 ]
then
 echo "$2 is failure"
 exit 1
else
 echo "$2 is success"
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