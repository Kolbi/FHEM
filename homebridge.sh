#!/bin/bash
## Homebridge Installation auf einem Raspberry Pi

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
npm install

## Homebridge updaten
#cd /home/pi/homebridge
#git pull
#npm update
#oder 
#npm install

## Prüfen ob forever installiert ist
npm install forever -g

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
  exec forever --sourceDir=/home/pi/homebridge -p /var/log/forever start app.js
  ;;

  stop)
  exec forever stop --sourceDir=/home/pi/homebridge app.js
  ;;
  
  *)
  echo "Usage: /etc/init.d/homebridge {start|stop}"
  exit 1
  ;;
esac

exit 0
EOF
##
sudo chmod 755 /etc/init.d/hombebridge
sudo update-rc.d hombebridge defaults
