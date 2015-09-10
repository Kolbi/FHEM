# FHEM
## Anleitung zum Herunterladen und Ausführen eines Skriptes
###SSH einloggen
###Ins Temp-Verzeichnis springen
cd /tmp
###Skripte herunterladen:
wget https://raw.githubusercontent.com/Kolbi/FHEM/master/fhem_install.sh
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

##USB-Stick einhängen und für Logs verwenden
USB-Stick vfat formatieren und anschliessen

sudo mkdir /mnt/usb

sudo nano /etc/fstab/

/dev/sda1 /mnt/usb vfat defaults,umask=000 0 3

sudo service fhem stop

sudo mv /opt/fhem/log /mnt/usb/

sudo ls -s /mnt/usb/log /opt/fhem/log

sudo service fhem start
