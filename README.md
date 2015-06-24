# FHEM
## Anleitung zum Herunterladen und Ausführen eines Skriptes
###SSH einloggen
###Ins Temp-Verzeichnis springen
cd /tmp
###Skripte herunterladen:
wget -O https://raw.githubusercontent.com/Kolbi/FHEM/master/fhem_install.sh
###Shell-Skripte nach dem Erstellen mit 755 Rechten versehen:
chmod 755 fhem_install.sh
###Shell-Skript ausführen
sudo ./fhem_install.sh

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

### Pilight installation:
http://www.pilight.org/getting-started/installation#postinstall

sudo nano /etc/apt/sources.list

deb http://apt.pilight.org/ stable main

wget -O - http://apt.pilight.org/pilight.key | sudo apt-key add -

sudo apt-get update && sudot apt-get install pilight -y

sudo nano /etc/pilight/config.json

Port einfügen:

"port": 5000,

sudo service pilight start

## GPIO4
http://www.fhemwiki.de/wiki/Raspberry_Pi_und_1-Wire#ab_2015_bzw._Kernelversion_3.18.3

sudo nano /boot/config.txt

Einfügen ans Ende:

# activating 1-wire with pullup

dtoverlay=w1-gpio-pullup

sudo cp /opt/fhem/contrib/58_GPIO4.pm /opt/fhem/FHEM/58_GPIO4.pm

sudo reboot

##USB-Stick einhängen und für Logs verwenden
USB-Stick vfat formatieren und anschliessen

sudo mkdir /mnt/usb

sudo nano /etc/fstab/

/dev/sda1 /mnt/usb vfat defaults,umask=000 0 3

sudo service fhem stop

sudo mv /opt/fhem/log /mnt/usb/

sudo ls -s /mnt/usb/log /opt/fhem/log

sudo service fhem start
