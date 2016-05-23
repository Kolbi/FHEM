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

# Autostart
sudo cp /opt/hmcfgusb/debian/hmland.init /etc/init.d/hmland
sudo cp /opt/hmcfgusb/debian/hmland.default /etc/default/hmland

sudo chmod 755 /etc/init.d/hmland
sudo update-rc.d hmland defaults
sudo service hmland start
## FHEM anlegen
# define hmusb HMLAN 127.0.0.1:1234 
# attr hmusb hmId <hmId>

exit 0

fi
