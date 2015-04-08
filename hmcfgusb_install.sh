#!/bin/bash
# Install hmcfgusb
# https://git.zerfleddert.de/cgi-bin/gitweb.cgi/hmcfgusb
# http://www.fhemwiki.de/wiki/HM-CFG-USB_USB_Konfigurations-Adapter

# Setting up directories
PFAD=/opt

# Install needed packages
sudo apt-get install libusb-1.0-0-dev make gcc git-core build-essential -y

# Go to installation directory
cd $PFAD

# Clone hmcfgusb git
sudo git clone git://git.zerfleddert.de/hmcfgusb

# Go to hmcfgusb directory
cd hmcfgusb

# Compile hmcfgusb
sudo make

exit 0

fi
