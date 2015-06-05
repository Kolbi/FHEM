#!/bin/bash
# Watchdog for FHEM
# Crontab prüft alle 5 Minuten ob FHEM läuft
# sudo crontab -e
# */5 * * * * /opt/fhem/fhem_watchdog.sh

# Setting logfile
FHEM_LOG=/var/log/fhem_watchdog.log

# Log downtimes? (1=Yes, 0=No)
LOG_DOWNTIME=0

# Send mail? (1=Yes, 0=No)
MAIL_SEND=0

MAIL_SENDER="mail@mail.com"
MAIL_RECEIVER="receiver@mail.com"
MAIL_TITLE="Start FHEM"
MAIL_TEXT="FHEM has been started..."
MAIL_SMTP="smtp.mail.de"
MAIL_ACCOUNT="mail@mail.com"
MAIL_PASSWORD="securepassword"

# Send log with mail? LOG_DOWNTIME must be 1. (1=Yes, 0=No)
MAIL_ATTACH=0

# Beginn script
cnt=$(ps -ef | grep -v grep | grep fhem.pl | wc -l);

if test $cnt -gt 0 ;
  then
    echo "FHEM running";
    exit 0
  else
    echo  "FHEM not running. starting FHEM...";
    if [ $LOG_DOWNTIME = 1 ];
    then
      echo `date` "FHEM is not running. starting FHEM" >> $FHEM_LOG;
    else
      echo `date` "FHEM is not running. starting FHEM";
    fi
    sudo service fhem start & sleep 5;
    # Install sendEmail
    # sudo apt-get install sendEmail
    if [ $MAIL_SEND = 1 ];
    then
      if [ $MAIL_ATTACH = 1 ];
      then
        sendEmail -f "$MAIL_SENDER" -t "$MAIL_RECEIVER" -u "$MAIL_TITLE" -m "$MAIL_TEXT" -a "$FHEM_LOG" -s "$MAIL_SMTP" -xu "$MAIL_ACCOUNT" -xp "$MAIL_PASSWORD" -o tls=auto -o message-charset=utf-8;
      else
        sendEmail -f "$MAIL_SENDER" -t "$MAIL_RECEIVER" -u "$MAIL_TITLE" -m "$MAIL_TEXT" -s "$MAIL_SMTP" -xu "$MAIL_ACCOUNT" -xp "$MAIL_PASSWORD" -o tls=auto -o message-charset=utf-8;
      fi
    fi
    exit 0
fi
