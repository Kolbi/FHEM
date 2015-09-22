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
