#!/bin/bash
# Install fhem

# Update
sudo apt-get update

# Dist-Upgrade vorher durchführen
sudo apt-get dist-upgrade -y

# Install needed packages
sudo apt-get install libusb-1.0-0-dev make gcc git-core build-essential perl libdevice-serialport-perl libio-socket-ssl-perl -y

# Wird für das Netatmo Modul benötigt:
# Installiert zusätzlich
# The following NEW packages will be installed: libxml-namespacesupport-perl libxml-parser-perl 
# libxml-sax-base-perl libxml-sax-expat-perl libxml-sax-perl libxml-simple-perl
sudo apt-get install libxml-simple-perl -y
# Wird für das Netatmo und Pilight Modul benötigt:
sudo apt-get install libjson-perl -y

# Fehlende Abhänigkeiten installieren
sudo apt-get install -f

# Download FHEM
# fhem-X.Y.deb bitte mit der aktuellsten, stabilen Version ersetzen
# http://fhem.de/fhem.html#Download
cd /tmp
wget http://fhem.de/fhem-5.6.deb
# Install FHEM
sudo dpkg -i fhem-5.6.deb
# Löschen des heruntergeladenen DEB-Paketes (optional)
rm fhem-5.6.deb

exit 0

fi
