#!/bin/bash

echo "Moving scripts"
mkdir /opt/zabbixkio
chown pi:pi /opt/zabbixkio/
mv kiosk.sh /opt/zabbixkio/
chmod 755 /opt/zabbixkio/kiosk.sh
mv log_in.sh /opt/zabbixkio/
chmod 755 /opt/zabbixkio/log_in.sh
echo "OK"

echo "Disable bt&wifi"
#Disable bt&wifi
sed -i '/^# Additional overlays.*/a dtoverlay=disable-wifi\ndtoverlay=disable-bt' /boot/config.txt
echo "BT & WIFI disabled"
#Set gpu memory
sed -i '/^\[all\].*/a gpu_mem=256' /boot/config.txt
echo "GPU memory set"
echo "Set timezone & NTP"
#Set timezone & NTP
sudo timedatectl set-timezone Europe/Riga
chattr -i /etc/hosts
echo '10.100.20.104   laiks.egl.local' >> /etc/hosts
chattr +i /etc/hosts
sed -i '/^#NTP=.*/a FallbackNTP=laiks.egl.local' /etc/systemd/timesyncd.conf

echo "Setting Wait for network"
#Wait for network - to change  use "get_boot_wait" without argument
sudo raspi-config nonint do_boot_wait 0

echo "Setting x in bashrc"
echo '#xinit /opt/zabbixkio/kiosk.sh -- vt$(fgconsole)' >> ~/.bashrc

echo "Setting Autologin"
#Set Autologin to console: https://github.com/RPi-Distro/raspi-config.git
systemctl set-default multi-user.target
ln -fs /lib/systemd/system/getty@.service /etc/systemd/system/getty.target.wants/getty@tty1.service
cat > /etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "Autologin set"
