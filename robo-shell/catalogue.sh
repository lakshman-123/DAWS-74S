#!/bin/bash

DATE=$(date +%F)
LOGSDIR=/tmp
# /home/centos/shellscript-logs/script-name-date.log
SCRIPT_NAME=$0
LOGFILE=$LOGSDIR/$0-$DATE.log
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

if [ $USERID -ne 0 ];
then
    echo -e "$R ERROR:: Please run this script with root access $N"
    exit 1
fi

validate(){
    if [ $1 -ne 0 ];
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> LOGFILE
validate $? "setting up repos"

yum install nodejs -y &>> LOGFILE
validate $? "installing nodejs"

useradd roboshop &>> LOGFILE
validate $? "adding user"

mkdir /app &>> LOGFILE
validate $? "making app directory"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> LOGFILE
validate $? "downloading artifacts"

cd /app &>> $LOGFILE
validate $? "changing app directory"

unzip /tmp/catalogue.zip &>> LOGFILE
validate $? "unzipping catalogue"

npm install &>> LOGFILE
validate $? "installing npm" 

cp /home/centos/roboshop-shell/catalogue.service  /etc/systemd/system/catalogue.service
validate $? "creating catalogue service "

systemctl daemon-reload
validate $? "daemon-reload catalogue"

systemctl enable catalogue
validate $? "enabling catalogue"

systemctl start catalogue
validate $? "starting catalogue"

cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
validate $? "copying to yum.repos.d"

yum install mongodb-org-shell -y
validate $? "installing mongodb-client"

mongo --host catalogue.lakshman.tech </app/schema/catalogue.js
validate $? "loading catalogue data into mongodb"



