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



yum install python36 gcc python3-devel -y &>> $LOGFILE
validate $? "installing python"

useradd roboshop &>> $LOGFILE
validate $? "adding user"


mkdir /app &>> $LOGFILE
validate $? "making app directory"

curl -o curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>> LOGFILE
validate $? "downloading artifacts"

cd /app &>> $LOGFILE
validate $? "changing app directory"


unzip /tmp/payment.zip &>> $LOGFILE
validate $? "unzipping payment"

pip3.6 install -r requirements.txt &>> $LOGFILE
validate $? "installing requirements" 

cp  /home/centos/DAWS-74S/robo-shell/payment.service  /etc/systemd/system/payment.service &>> $LOGFILE
validate $? "creating payment service "

systemctl daemon-reload &>> $LOGFILE
validate $? "daemon-reload payment"

systemctl enable payment &>> $LOGFILE
validate $? "enabling payment"

systemctl start payment &>> $LOGFILE
validate $? "starting payment"

