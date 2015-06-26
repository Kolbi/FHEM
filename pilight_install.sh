#!/bin/bash
# Install pilight
# http://manual.pilight.org/de/installation
# https://github.com/pilight/pilight

# Install needed packages
sudo apt-get update && sudo apt-get install libjson-perl -y

# Stable releases
echo "deb http://apt.pilight.org/ stable main" >> /etc/apt/sources.list
# Nightly
# echo "deb http://apt.pilight.org/ nightly main" >> /etc/apt/etc/apt/sources.list

wget -O - http://apt.pilight.org/pilight.key | sudo apt-key add -

sudo apt-get update && sudot apt-get install pilight -y

# sudo nano /etc/pilight/config.json
# Port einfügen:
# "port": 5000,

sudo service pilight start

exit 0

fi
