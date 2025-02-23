#!/bin/bash

echo "Welcome to installation of any package."

UserId=$(id -u);
CHECK_USER(){
    if [ $UserId -ne 0 ]
    then
        echo "User id is ${UserId}"
        echo "you are not in super usermode. please do package installation in super usermode"
        exit 1
    fi 
} 
CHECK_USER

PACKAGE_INSTALL(){
    dnf list installed $1

    if [ $? -eq 0 ]; then
        echo "$1 is already installed"
    else
        echo "$1 is not installed..do you want to install it ? if yes please type 'y'";

        if [ $2 != "y" ]; then
            echo "you entered $2. aborting installation of the $1"
            exit 1
        else 
            echo "Installing the $1...."
        fi

        dnf install $1 -y

        if [ $? -eq 0 ]; then
            echo "$1 installation is success"
        else
            echo "Something went wrong, $1 installation is failed."
            exit 1
        fi    
    fi
}

echo "Enter name of the package you would like to install"
read package

PACKAGE_INSTALL $package "y"