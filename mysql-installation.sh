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

Red="\e[31m"
Green="\e[32m"
NoColor="\e[0m"

echo "Enter name of the package you would like to install"
read package
dnf list installed $package

if [ $? -eq 0 ]; then
    echo -e "$package is already $Green installed $NoColor"
else
    echo "$package is not $Red installed $NoColor..do you want to install it ? if yes please type $Green 'y' $NoColor";
    read answer

    if [ $answer != "y" ]; then
        echo "you entered $Red $answer $NoColor. $Red aborting installation of the $package $NoColor"
        exit 1
    else 
        echo "Installing the $package...."
    fi

    dnf install $package -y

    if [ $? -eq 0 ]; then
        echo "$package installation is $Green success $NoColor"
    else
        echo "Something went wrong, $package installation is $Red failed $NoColor."
        exit 1
    fi    
fi