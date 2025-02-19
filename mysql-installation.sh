#!/bin/bash

# echo "Welcome to installation of any package."

# echo "first please check if you are in super usermode or not"

USERID = $(id -u);
echo "user id is ${USERID}"

# if [$USERID -ne 0]
# then
#     echo "you are not in super usermode. please do package installation in super usermode"
#     exit 1
# fi  

# echo "Enter name of the package you would like to install"

# read package

# dnf list installed ${package}

# if [$? -ne 0]
# then
#     echo "${package} is not installed..do you want to install it ? if yes please type 'y'";
#     read answer
#     if [${answer} -ne 'y']
#     then
#         echo "you entered ${answer}. aborting installation of the ${package}"
#         exit 1
#     else 
#         echo "Installing the ${package}...."
#     fi

#     dnf install ${package} -y
#     if [$? -eq 0]
#     then
#         echo "${package} installation is success"
#     else
#         echo "Something went wrong, ${package} installation is failed."
#         exit 1
#     fi
# else
#     echo "${package} is already installed"
# fi