#!/bin/bash
# Install fhem

# Update
sudo apt-get update

# Dist-Upgrade vorher durchführen
sudo apt-get dist-upgrade -y

# Install needed packages
sudo apt-get install libusb-1.0-0-dev make gcc git-core build-essential perl libdevice-serialport-perl libio-socket-ssl-perl -y

# Download FHEM
# fhem-X.Y.deb bitte mit der aktuellsten, stabilen Version ersetzen
# http://fhem.de/fhem.html#Download
cd /tmp
wget  http://fhem.de/fhem-5.6.deb
# Install FHEM
sudo dpkg -i fhem-5.6.deb
# Löschen des heruntergeladenen DEB-Paketes (optional)
rm fhem-5.6.deb

# Fehlende Abhänigkeiten installieren
sudo apt-get install -f

exit 0

fi
