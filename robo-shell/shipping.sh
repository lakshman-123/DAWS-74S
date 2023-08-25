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

yum install maven -y &>> $LOGFILE
validate $? "installing maven"

useradd roboshop &>> $LOGFILE
validate $? "adding user"

mkdir /app &>> $LOGFILE
validate $? "making directory"

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>> $LOGFILE
validate $? "download shiiping.zip"

cd /app &>> $LOGFILE
validate $? "changing directory"

unzip /tmp/shipping.zip &>> $LOGFILE
validate $? "unzipping shipping.zip"

mvn clean package &>> $LOGFILE
validate $? "building package"

mv target/shipping-1.0.jar shipping.jar &>> $LOGFILE
validate $? "shipping shipping.jar"

cp  /home/centos/DAWS-74S/robo-shell/shipping.service /etc/systemd/system/shipping.service  &>> $LOGFILE
validate $? "copying shipping service"

systemctl daemon-reload &>> $LOGFILE
validate $? "daemon reload shipping"

systemctl enable shipping  &>> $LOGFILE
validate $? "enabling shipping"

systemctl start shipping &>> $LOGFILE
validate $? "starting shipping"

sudo yum install mysql &>> $LOGFILE
validate $? "installing client mysql"

mysql -h mysql.lakshman.tech -uroot -pRoboShop@1 < /app/schema/shipping.sql &>> $LOGFILE
validate $? "loading schema shipping"

systemctl restart shipping &>> $LOGFILE
validate $? "restart shipping"
