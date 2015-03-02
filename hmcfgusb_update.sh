#!/bin/bash
# Update hmcfgusb

# Setting up directories
PFAD=/opt/hmcfgusb

cd $PFAD

sudo git pull git://git.zerfleddert.de/hmcfgusb

sudo make

sudo service hmland stop

wait 5

sudo service hmland start

exit 0

fi
