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

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> $LOGFILE
validate $? "rabbitmq package"

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> $LOGFILE
validate $? "rabbitmq package1"

yum install rabbitmq-server -y &>> $LOGFILE
validate $? "installing rabbitmq server"


systemctl enable rabbitmq-server &>> $LOGFILE
validate $? "enabling rabbitmq server"

systemctl start rabbitmq-server &>> $LOGFILE
validate $? "starting rabbitmq server"

rabbitmqctl add_user roboshop roboshop123 &>> $LOGFILE
validate $? "adding user and password rabbitmq"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
validate $? "setting permissions"