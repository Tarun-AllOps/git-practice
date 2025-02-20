#!/bin/bash

echo "Welcome to installation of any package."

UserId=$(id -u);

if [ $UserId -ne 0 ]
then
    echo "User id is ${UserId}"
    echo "you are not in super usermode. please do package installation in super usermode"
    exit 1
fi  

echo "Enter name of the package you would like to install"
read package
dnf list installed $package

if [ $? -eq 0 ]; then
    echo "$package is already installed"
else
    echo "$package is not installed..do you want to install it ? if yes please type 'y'";
    read answer

    if [ $answer != "y" ]; then
        echo "you entered $answer. aborting installation of the $package"
        exit 1
    else 
        echo "Installing the $package...."
    fi

    dnf install $package -y

    if [ $? -eq 0 ]; then
        echo "$package installation is success"
    else
        echo "Something went wrong, $package installation is failed."
        exit 1
    fi    
fi