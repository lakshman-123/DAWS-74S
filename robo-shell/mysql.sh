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

yum module disable mysql -y &>> $LOGFILE
validate $? "disable default mysql"

cp mysql.repo /etc/yum.repos.d/mysql.repo &>> $LOGFILE
validate $? "adding mysql.repo"

yum install mysql-community-server -y &>> $LOGFILE
validate $? "installing mysql server"

systemctl enable mysqld &>> $LOGFILE
validate $? "enabling mysql"

systemctl start mysqld &>> $LOGFILE
validate $? "starting mysql"

mysql_secure_installation --set-root-pass RoboShop@1 &>> $LOGFILE
validate $? "setting mysql password"

mysql -uroot -pRoboShop@1 &>> $LOGFILE
validate $? "checking mysql connection"

