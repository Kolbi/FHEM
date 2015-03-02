#!/bin/bash
# Watchdog for FHEM
# Crontab prüft alle 5 Minuten ob FHEM läuft
# sudo crontab -e
# */5 * * * * /opt/fhem/fhem_watchdog.sh

cnt=$(ps -ef | grep -v grep | grep fhem.pl | wc -l);

if test $cnt -gt 0 ; 
  then
    echo "FHEM running";
    exit 0
  else
    echo  "FHEM not running. starting FHEM...";
    sudo service fhem start & sleep 5;
    exit 0
fi
