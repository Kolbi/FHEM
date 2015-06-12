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

#Prüfen ob FHEM noch läuft
#FHEM.save - Statefile alle 30 Minuten schreiben lassen
#http://forum.fhem.de/index.php/topic,20553.msg165509.html#msg165509
#define at_FHEM.save at +*00:30:00 {WriteStatefile}
#sudo nano /etc/watchdog.conf
#Add lines
#file = /opt/fhem/log/fhem.save
#change = 2000 

#Start daemon
#/etc/init.d/watchdog start

exit 0

fi
