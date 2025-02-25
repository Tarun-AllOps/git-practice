#!/bin/bash

UserId=$(id -u)

#colors
r="\e[31m"
g="\e[32m"
y="\e[33m"
n="\e[0m"

#LOGS
logFolder="/var/log/shell-script"
fileName=$(echo $0 | cut -d "." -f1)
timeStamp=$(date +%Y-%m-%d-%H-%M-%S)
logFile="$logFolder/$fileName-$timeStamp.log"
mkdir -p $logFolder

CHECK_USER(){
    if [ $UserId -ne 0 ];then
        echo "User id is ${UserId}" | tee -a $logFile
        echo -e "$r you are not in superuser mode. please do package installation in superuser mode $n" | tee -a $logFile
        exit 1
    fi
}

VALIDATE_INSTALLATER(){
    if [ $1 -ne 0 ]; then
        echo -e "Something went wrong...$r FAILED $n to install $2" | tee -a $logFile
        exit 1
    else
        echo -e "Installation of $2 is $g success $n" | tee -a $logFile
    fi
}

USER_GUIDE(){
    echo -e "$r USAGE::$n sudo sh installer.sh package1 package2.....packageN"
    exit 1
}

CHECK_USER

if [ $# -eq 0 ];then
    USER_GUIDE
fi    

for i in $@
do 
    dnf list installed $i &>>$logFile
    if [ $? -eq 0 ]; then
        echo -e "$i is $g already installed$n....nothing to do" | tee -a $logFile
    else
        echo "$i is not installed...going to install it" | tee -a $logFile
        dnf install $i -y &>>$logFile
        VALIDATE_INSTALLATER $? "$i"
    fi
done