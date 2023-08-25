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

yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> $LOGFILE
validate $? "installing redis rpm"

yum module enable redis:remi-6.2 -y &>> $LOGFILE
validate $? "enabling redis package rpm"

yum install redis -y &>> $LOGFILE
validate $? "installing redis"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>> $LOGFILE
validate $? "updating default listener"

systemctl enable redis &>> $LOGFILE
validate $? "enabling redis"

systemctl start redis &>> $LOGFILE
validate $? "starting redis"



