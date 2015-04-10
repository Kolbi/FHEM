#!/bin/bash
# Install hmcfgusb
# https://git.zerfleddert.de/cgi-bin/gitweb.cgi/hmcfgusb
# http://www.fhemwiki.de/wiki/HM-CFG-USB_USB_Konfigurations-Adapter

# Setting up directories
PFAD=/opt

# Install needed packages
sudo apt-get install libusb-1.0-0-dev make gcc git-core build-essential -y

# Go to installation directory
cd $PFAD

# Clone hmcfgusb git
sudo git clone git://git.zerfleddert.de/hmcfgusb

# Go to hmcfgusb directory
cd hmcfgusb

# Compile hmcfgusb
sudo make

## Autostart von hexenmeister
## http://forum.fhem.de/index.php?action=post;quote=190887;topic=13071.435;last_msg=282280
cat > /etc/init.d/hmland <<"EOF"
# simple init for hmland
### BEGIN INIT INFO
# Provides:          hmland
# Required-Start:    $network $local_fs $remote_fs
# Required-Stop::    $network $local_fs $remote_fs
# Should-Start:      $all
# Should-Stop:       $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start hmland daemon at boot time
# Description:       Provide Service to use HM-USB-CFG Adapter for FHEM.
### END INIT INFO

pidfile=/var/run/hmland.pid
port=1234

case "$1" in
 start|"")
	chrt 50 /opt/hmcfgusb/hmland -r 0 -d -P -l 127.0.0.1 -p $port 2>&1 | perl -ne '$|=1; print localtime . ": [hmland] $_"' >> /var/log/hmland.log &
	;;
 restart|reload|force-reload)
	echo "Error: argument '$1' not supported" >&2
	exit 3
	;;
 stop)
	killall hmland
	;;
 status)
	if [ ! -e $pidfile ]; then
		echo "No pid"
		exit 1
	fi
	pid=`cat $pidfile`
	if kill -0 $pid &>1 > /dev/null; then
		echo "Running"
		exit 0
	else
		rm $pidfile
		echo "Not running"
		exit 1
	fi

	;;
 *)
	echo "Usage: hmland [start|stop|status]" >&2
	exit 3
	;;
esac
EOF
sudo chmod 755 /etc/init.d/hmland
sudo update-rc.d hmland defaults
sudo service hmland start
##

exit 0

fi
