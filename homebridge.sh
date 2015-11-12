#!/bin/bash
## Homebridge Installation auf einem Raspberry Pi

sudo apt-get update
# Subpackage needed to compile node-gyp (See: https://github.com/KhaosT/HAP-NodeJS/issues/77)
sudo apt-get install -y libavahi-compat-libdnssd-dev

## GCC installieren
# https://github.com/cflurin/homebridge-shims/wiki/Minimalist-Homebridge-on-a-Raspberry-Pi
sudo apt-get install gcc-4.8 g++-4.8

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 20
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 20
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50

# GCC Version prüfen
# gcc --version

## Node installieren auf dem Rapsberry Pi
sudo apt-get install node

# Prüfung welche nodejs version ist installiert
# /usr/bin/env node --version

## Homebridge installieren
# https://github.com/nfarina/homebridge
sudo npm install -g homebridge
# FHEM Plugin installieren
sudo npm install -g git+https://github.com/justme-1968/homebridge-fhem.git

#Gegebenfalls unnötige Pakete entfernen
#https://github.com/cflurin/homebridge-shims/wiki/Minimalist-Homebridge-on-a-Raspberry-Pi
#sudo nano package.json

## Homebridge updaten
#sudo npm update
#oder 
#sudo npm install

## Homebridge Startskript
# http://www.fhemwiki.de/wiki/Homebridge_einrichten#Homebridge_automatisch_starten
# Autostart von hexenmeister
# muss mit sudo gestartet werden ansonsten wird /etc/init.d/hmland nicht erstellt, oder sudo vor cat?
# http://forum.fhem.de/index.php?action=post;quote=190887;topic=13071.435;last_msg=282280
# cat << "EOF" | sudo tee -a /etc/init.d/hmland ???
cat > /etc/init.d/homebridge <<"EOF"
#!/bin/sh
### BEGIN INIT INFO
# Provides: homebridge
# Required-Start: $network $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start daemon at boot time for homebridge
# Description: Enable service provided by daemon.
### END INIT INFO
export PATH=$PATH:/usr/local/bin
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules
PID=`pidof homebridge`
case "$1" in
start)
if ps -p $PID > /dev/null 2>&1; then
        echo "Homebridge is already running"
else
        homebridge -U /home/pi/.homebridge/ > /dev/null 2>&1 &
        echo "Homebridge starting"
fi
;;
stop)
if ! ps -p $PID > /dev/null 2>&1; then
        echo "Homebridge is not running"
else
        kill $PID
        echo "Homebridge closed"
fi
;;
restart)
if ! ps -p $PID > /dev/null 2>&1; then
        homebridge -U /home/pi/.homebridge/ > /dev/null 2>&1 &
        echo "Homebridge starting"
else
        kill $PID
        echo "Homebridge closed"
        homebridge -U /home/pi/.homebridge/ > /dev/null 2>&1 &
        echo "Homebridge starting"
fi
;;
status)
if ps -p $PID > /dev/null 2>&1; then
        echo "Homebridge is running PID $PID"
else
        echo "Homebridge is not running"
fi
;;
*)
echo "Usage: /etc/init.d/homebridge {start|stop|status|restart}"
exit 1
;;
esac
exit 0
EOF
##
sudo chmod 755 /etc/init.d/homebridge
## Autostart hinzufügen
sudo update-rc.d hobebridge defaults
## Autostart entfernen
#sudo update-rc.d -f homebridge remove

# Watchdog Ideen
#ps -ef | grep -v grep | grep /home/pi/homebridge/app.js | wc -l;

exit 0

fi
