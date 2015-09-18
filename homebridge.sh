#!/bin/bash

#http://pimatic.org/guide/getting-started/installation/
wget http://nodejs.org/dist/v0.10.28/node-v0.10.28-linux-arm-pi.tar.gz -P /tmp
cd /usr/local
sudo tar xzvf /tmp/node-v0.10.28-linux-arm-pi.tar.gz --strip=1
cd /home/pi

#https://github.com/nfarina/homebridge
git clone https://github.com/nfarina/homebridge.git
cd homebridge
npm install
