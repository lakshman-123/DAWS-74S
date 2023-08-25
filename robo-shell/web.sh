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

yum install nginx -y &>> $LOGFILE
validate $? "installing nginx"

systemctl enable nginx &>> $LOGFILE
validate $? "enabling nginx"

systemctl start nginx &>> $LOGFILE
validate $? "starting nginx"

curl -o /tmp/web.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

rm -rf /usr/share/nginx/html/* &>> $LOGFILE
validate $? "removing default html files"

cd /usr/share/nginx/html &>> $LOGFILE
validate $? "changing directory"

unzip /tmp/frontend.zip &>> $LOGFILE
validate $? "unziping files"

cp /home/centos/DAWS-74S/robo-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE
validate $? "updated roboshop conf file"

systemctl restart nginx &>> $LOGFILE
validate $? "restarting nginx"





