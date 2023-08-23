#!/bin/bash
Date=$(date +%F:%H:%M:%S)
script=$0
logdir=/home/centos/shellscript-logs
log=$logdir/$script-$Date.log
userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $userid -ne 0 ] 
then
  echo -e "$R Error not root user $N"
  exit 1
fi 
validate() {
    if [ $1 -ne 0 ]
    then
      echo -e " error $2 installation .. $R failure $N"
      exit 1
    else
      echo -e " $2 installation .. $G success $N"
    fi  
}  

for i in $@
do
 yum list installed $i

 if [ $? -ne 0 ]
 then
   echo "$i is not installed,let's install it"
   yum install $i -y &>>$log
   validate $? "$i"
 else
  echo  -e "$Y $i is already installed! $N" 
 fi 

done 
