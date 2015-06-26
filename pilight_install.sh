#!/bin/bash
# Install pilight & activate GPIO & FHEM-Modul
# http://manual.pilight.org/de/installation
# https://github.com/pilight/pilight

# Install needed packages
sudo apt-get update && sudo apt-get install libjson-perl -y

# Stable releases
echo "deb http://apt.pilight.org/ stable main" >> /etc/apt/sources.list
# Nightly
# echo "deb http://apt.pilight.org/ nightly main" >> /etc/apt/etc/apt/sources.list

wget -O - http://apt.pilight.org/pilight.key | sudo apt-key add -

sudo apt-get update && sudot apt-get install pilight -y

# sudo nano /etc/pilight/config.json
# Port einfügen:
# "port": 5000,

# Activating GPIO-Ports on Raspberry Pi
# http://www.fhemwiki.de/wiki/Raspberry_Pi_und_1-Wire#ab_2015_bzw._Kernelversion_3.18.3
echo "# activating 1-wire with pullup" >> /boot/config.txt
echo "dtoverlay=w1-gpio-pullup" >> /boot/config.txt

# Copying FHEM modules
sudo cp /opt/fhem/contrib/58_GPIO4.pm /opt/fhem/FHEM/58_GPIO4.pm

# Pilight Daemon starten
sudo service pilight start

wait 5

# Wirklich notwendig? Prüfen...
sudo reboot

exit 0

fi
