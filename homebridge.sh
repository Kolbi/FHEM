#!/bin/bash
## Homebridge Installation auf einem Raspberry Pi

sudo apt-get update
# Subpackage needed to compile node-gyp (See: https://github.com/KhaosT/HAP-NodeJS/issues/77)
sudo apt-get install -y libavahi-compat-libdnssd-dev

## Node installieren auf dem Rapsberry Pi
# Solange notwendig bis Homebridge mit Node 4.0 läuft
# sudo apt-get install node
# http://pimatic.org/guide/getting-started/installation/
# Node herunterladen
wget http://nodejs.org/dist/v0.10.28/node-v0.10.28-linux-arm-pi.tar.gz -P /tmp
# Ins Verzeichnis springen
cd /usr/local
# Node installieren
sudo tar xzvf /tmp/node-v0.10.28-linux-arm-pi.tar.gz --strip=1

# Prüfung welche nodejs version ist installiert
# /usr/bin/env node --version

## Homebridge installieren
# https://github.com/nfarina/homebridge
cd /home/pi
git clone https://github.com/nfarina/homebridge.git
cd homebridge
# Pakete installieren
sudo npm install

## Homebridge updaten
#cd /home/pi/homebridge
#git pull
#sudo npm update
#oder 
#sudo npm install

## Forever installieren
sudo npm install forever -g

## Log Verzeichnis für Forever erstellen
#sudo mkdir -p /var/log/forever

## Startskript funktioniert an sich, nur beim Autostart werden die PIDs nicht erkannt, folglich geht stop und status nicht
## Beim Manuellen Starten / Stoppen geht es... forever Bug?
## Autostart (Root)         => pid /root/.forever/  => sudo kann nicht zugreifen drauf
## Manueller Start mit sudo => pid /root/.forever/  => sudo Zugriff okay
## Mit -p /var/log/forever  => pid /var/log/forber  => forever list erkennt es nicht, da pidPath falsch ist

## Workaround
# sudo crontab -e
#@reboot /usr/local/bin/forever --sourceDir=/home/pi/homebridge -p /var/log/forever start app.js
#@reboot service homebridge start
#@reboot /usr/local/bin/forever start -c /usr/local/bin/node -p /var/log/forever /home/pi/homebridge/app.js

## sudo su - root
## sudo service homebridge status / stop geht

## PID Pfad setzen für normalen User
## geht nicht, setzt das File immer wieder auf default
##forever set pidPath /var/log/forever
## PID Pfad setzen für Root
##sudo forever set pidPath /var/log/forever

## Homebridge Startskript
# Autostart von hexenmeister
# muss mit sudo gestartet werden ansonsten wird /etc/init.d/hmland nicht erstellt, oder sudo vor cat?
# http://forum.fhem.de/index.php?action=post;quote=190887;topic=13071.435;last_msg=282280
# cat << "EOF" | sudo tee -a /etc/init.d/hmland ???
cat > /etc/init.d/homebridge <<"EOF"
#!/bin/sh
### BEGIN INIT INFO
# Provides: 		 homebridge
# Required-Start:    $network $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time for homebridge
# Description:       Enable service provided by daemon.
### END INIT INFO

export PATH=$PATH:/usr/local/bin
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules

case "$1" in
  start)
  exec forever --sourceDir=/home/pi/homebridge start app.js
  ;;

  stop)
  exec forever stop --sourceDir=/home/pi/homebridge app.js
  ;;
  
  status)
  exec forever list
  ;;
  
  *)
  echo "Usage: /etc/init.d/homebridge {start|stop|status}"
  exit 1
  ;;
esac

exit 0
EOF
##
sudo chmod 755 /etc/init.d/homebridge
## Autostart hinzufügen
#sudo update-rc.d hombebridge defaults
## Autostart entfernen
#sudo update-rc.d -f hombebridge remove

#Start nur manuell derzeit
#sudo service homebridge start

# Watchdog Ideen
#ps -ef | grep -v grep | grep /home/pi/homebridge/app.js | wc -l;

exit 0

fi
