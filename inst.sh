#!/bin/bash
apt-get update && sudo apt-get upgrade -y

#Install Chromium & X
apt-get install --no-install-recommends xserver-xorg -y
apt-get install --no-install-recommends xinit -y
apt-get install --no-install-recommends x11-xserver-utils -y
apt-get install chromium-browser -y
apt-get install matchbox-window-manager xautomation unclutter -y
apt-get install xdotool -y
