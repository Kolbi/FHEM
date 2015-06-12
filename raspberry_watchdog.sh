#!/bin/bash
# Activate Raspberry Pi Watchdog
# http://forum.fhem.de/index.php/topic,20553.0.html

#Activate
sudo modprobe bcm2708_wdog
echo "bcm2708_wdog" | sudo tee -a /etc/modules

#Is watchdog working?
ls -al /dev/watchdog

#Install watchdog daemon
sudo apt-get install watchdog -y

# Edit watchdog settings
#sudo nano /etc/watchdog.conf
#Remove comment from lines
#watchdog-device        = /dev/watchdog
#max-load-1             = 24

#Start daemon
#/etc/init.d/watchdog start

exit 0

fi
