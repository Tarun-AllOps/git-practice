#!/bin/bash

UserId=$(id -u)

#colors
r="\e[31m"
g="\e[32m"
y="\e[33m"
n="\e[0m"

CHECK_USER(){
    if [ $UserId -ne 0 ];then
        echo "User id is ${UserId}"
        echo -e "$r you are not in superuser mode. please do package installation in superuser mode $n"
        exit 1
    fi
}

VALIDATE_INSTALLATER(){
    if [ $1 -ne 0 ]; then
        echo -e "Something went wrong...$r FAILED $n to install $2"
        exit 1
    else
        echo -e "Installation of $2 is $g success $n"
    fi
}

CHECK_USER

for i in $@
do 
    dnf list installed $i
    if [ $? -eq 0 ]; then
        echo -e "$i is $g already installed$n....nothing to do"
    else
        echo "$i is not installed...going to install it"
        dnf install $i -y
        VALIDATE_INSTALLATER $? "$i"
    fi
done

# dnf list installed git

# if [ $? -eq 0 ]; then
#     echo -e "git is $g already installed$n....nothing to do"
# else
#     echo "git is not installed...going to install it"
#     dnf install git -y
#     VALIDATE_INSTALLATER $? "Git"
# fi

# dnf list installed mysql

# if [ $? -eq 0 ]; then
#     echo -e "mysql is $g already installed$n....nothing to do"
# else
#     echo "mysql is not installed...going to install it"
#     dnf install mysql -y
#     VALIDATE_INSTALLATER $? "Mysql"
# fi
