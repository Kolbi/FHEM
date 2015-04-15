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

## Raspberry Hardware Watchdog# 
http://forum.fhem.de/index.php/topic,20553.0.html // http://www.bayerschmidt.com/raspberry-pi/89-auto-reboot-a-hung-raspberry-pi-using-the-on-board-watchdog-timer.html

Pilight installation:
http://www.pilight.org/getting-started/installation#postinstall
apt-get install pilight
The following extra packages will be installed:
  libpcap0.8 libunwind8 pilight-webgui
Suggested packages:
  php5-cgi pilight-firmware
The following NEW packages will be installed:
  libpcap0.8 libunwind8 pilight pilight-webgui
