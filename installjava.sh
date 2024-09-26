#!/bin/bash
sudo dnf update
sudo dnf install -y default-jre

java_version=$(java -version 2>&1 > /dev/null  | grep "openjdk version" | awk '{print substr($3,2,2)}')

if [ "$java_version" == "" ]
then
    echo Java installation failed.
elif [ "$java_version" == "1." ]
then
    echo An older version of Java is installed
elif [ "$java_version" -ge 11 ]
then
    echo Java version 11 or higher has been installed successfully
fi
