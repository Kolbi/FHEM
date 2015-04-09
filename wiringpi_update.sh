#!/bin/bash
# Update wiringPi
# http://wiringpi.com/download-and-install/

# Setting up directories
PFAD=/opt/wiringPi

# Go to wiringPi directory
cd $PFAD

# Clone wiringPi git
sudo git pull origin

# Compile wiringPi
sudo ./build

exit 0

fi
