#!/bin/bash
# Update hmcfgusb

# Setting up directories
PFAD=/opt/hmcfgusb

# Go to hmcfgusb directory
cd $PFAD

# Download latest commits
sudo git pull git://git.zerfleddert.de/hmcfgusb

# Compile hmcfgusb
sudo make

# Stop hmland
sudo service hmland stop

wait 5

#Start hmland
sudo service hmland start

exit 0

fi
