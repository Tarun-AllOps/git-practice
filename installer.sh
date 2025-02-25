#!/bin/bash

UserId=$(id -u)

CHECK_USER(){
    if [ $UserId -ne 0 ];then
        echo "User id is ${UserId}"
        echo "you are not in super usermode. please do package installation in super usermode"
        exit 1
    fi
}

VALIDATE_INSTALLATER(){
    if [ $1 -ne 0 ]; then
        echo "Something went wrong...FAILED to install $2"
        exit 1
    else
        echo "Installation of $2 is success"
    fi
}

CHECK_USER

dnf list installed git

if [ $? -eq 0 ]; then
    echo "git is already installed....nothing to do"
else
    echo "git is not installed...going to install it"
    dnf install git -y
    VALIDATE_INSTALLATER $? "Git"
fi

dnf list installed mysql

if [ $? -eq 0 ]; then
    echo "mysql is already installed....nothing to do"
else
    echo "mysql is not installed...going to install it"
    dnf install mysql -y
    VALIDATE_INSTALLATER $? "Mysql"
fi
