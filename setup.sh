#!/bin/bash
apt-get update && sudo apt-get upgrade -y
raspi-config nonint do_memory_256

systemctl disable bluetooth.service
systemctl disable hciuart.service
sed -i '/^# Additional overlays.*/a dtoverlay=disable-wifi\ndtoverlay=disable-bt' /boot/config.txt

#Set timezone & NTP
sudo timedatectl set-timezone Europe/Riga
chattr -i /etc/hosts
echo '10.100.20.104   laiks.egl.local' >> /etc/hosts
chattr +i /etc/hosts
sed -i '/^#NTP=.*/a FallbackNTP=laiks.egl.local' /etc/systemd/timesyncd.conf

#Wait for network - to change  use "get_boot_wait" without argument
sudo raspi-config nonint do_boot_wait 0

#Install Chromium & X
apt-get install --no-install-recommends xserver-xorg -y
apt-get install --no-install-recommends xinit -y
apt-get install --no-install-recommends x11-xserver-utils -y
apt-get install chromium-browser -y
apt-get install matchbox-window-manager xautomation unclutter -y
apt-get install xdotool -y

mkdir /opt/zabbixkio
chown pi:pi /opt/zabbixkio/

mv kiosk.sh /opt/zabbixkio/
chmod 755 /opt/zabbixkio/kiosk.sh

mv log_in.sh /opt/zabbixkio/
chmod 755 /opt/zabbixkio/log_in.sh

echo '#xinit /opt/zabbixkio/kiosk -- vt$(fgconsole)'
