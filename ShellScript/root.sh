#!/bin/bash

userid=$(id -u)

if [ $userid -ne 0 ]
then
 echo "This is not root user"
fi

yum install -y mysql