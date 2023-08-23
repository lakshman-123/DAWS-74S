#!/bin/bash

userid=$(id -u)

if [ $userid -ne 0 ]
then
 echo "This is not root user"
 exit 1
fi

yum install -y mysql