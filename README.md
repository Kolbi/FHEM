# FHEM

Shell-Skripte nach dem Erstellen mit 755 Rechten versehen:
chmod 755 fhem_watchdog.sh // chmod 755 hmcfgusb_update.sh

## Kommunikation Raspberry / GPIO
wiringpi: http://wiringpi.com/
wiringpi installation: http://wiringpi.com/download-and-install/
wiringpi git: https://git.drogon.net/?p=wiringPi

wiringx: https://github.com/wiringX/wiringX/commits/master
wiringx git: https://github.com/wiringX/wiringX/commits/master

## Zum Senden von 433 Mhz Befehle:

https://github.com/xkonni/raspberry-remote

## Kommunikation Raspberry / GPIO + Zum Senden von 433 Mhz Befehle:
pilight: http://www.pilight.org/
pilight installation: http://www.pilight.org/get-started/installation
pilight git: https://github.com/pilight/pilight
(nutzt seit neuestem wiringx (buildin) und benötigt nicht mehr wiringpi)

## Pilight installation:
http://www.pilight.org/getting-started/installation#postinstall

sudo nano /etc/apt/sources.list

deb http://apt.pilight.org/ stable main

wget -O - http://apt.pilight.org/pilight.key | sudo apt-key add -

sudo apt-get update && sudot apt-get install pilight -y

sudo nano /etc/pilight/config.json

Port einfügen:

"port": 5000,

sudo service pilight start

## Netatmo:
sudo apt-get install libxml-simple-perl -y

The following NEW packages will be installed:
  libxml-namespacesupport-perl libxml-parser-perl libxml-sax-base-perl
  libxml-sax-expat-perl libxml-sax-perl libxml-simple-perl

## GPIO4
http://www.fhemwiki.de/wiki/Raspberry_Pi_und_1-Wire#ab_2015_bzw._Kernelversion_3.18.3

sudo nano /boot/config.txt

Einfügen ans Ende:

# activating 1-wire with pullup

dtoverlay=w1-gpio-pullup

sudo cp /opt/fhem/contrib/58_GPIO4.pm /opt/fhem/FHEM/58_GPIO4.pm

sudo reboot
