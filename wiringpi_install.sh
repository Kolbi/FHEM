#!/bin/bash
# Install wiringPi
# http://wiringpi.com/download-and-install/

# Setting up directories
PFAD=/opt

# Install needed packages
sudo apt-get install git-core -y

# Go to installation directory
cd $PFAD

# Clone wiringPi git
sudo git clone git://git.drogon.net/wiringPi

# Go to wiringPi directory
cd wiringPi

# Compile wiringPi
./build

exit 0

fi
