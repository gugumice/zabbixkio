#!/bin/bash
apt-get update && sudo apt-get upgrade -y


#Install Chromium & X
apt-get install --no-install-recommends xserver-xorg -y
apt-get install --no-install-recommends xinit -y
apt-get install --no-install-recommends x11-xserver-utils -y
apt-get install chromium-browser -y
apt-get install matchbox-window-manager xautomation unclutter -y
apt-get install xdotool -y

raspi-config nonint do_memory_256

#systemctl disable bluetooth.service
#systemctl disable hciuart.service
sed -i '/^# Additional overlays.*/a dtoverlay=disable-wifi\ndtoverlay=disable-bt' /boot/config.txt

#Set Autologin to console: https://github.com/RPi-Distro/raspi-config.git
systemctl set-default multi-user.target
ln -fs /lib/systemd/system/getty@.service /etc/systemd/system/getty.target.wants/getty@tty1.service
cat > /etc/systemd/system/getty@tty1.service.d/autologin.conf


#Set timezone & NTP
sudo timedatectl set-timezone Europe/Riga
chattr -i /etc/hosts
echo '10.100.20.104   laiks.egl.local' >> /etc/hosts
chattr +i /etc/hosts
sed -i '/^#NTP=.*/a FallbackNTP=laiks.egl.local' /etc/systemd/timesyncd.conf

#Wait for network - to change  use "get_boot_wait" without argument
sudo raspi-config nonint do_boot_wait 0

mkdir /opt/zabbixkio
chown pi:pi /opt/zabbixkio/

mv kiosk.sh /opt/zabbixkio/
chmod 755 /opt/zabbixkio/kiosk.sh

mv log_in.sh /opt/zabbixkio/
chmod 755 /opt/zabbixkio/log_in.sh

echo '#xinit /opt/zabbixkio/kiosk -- vt$(fgconsole)' >> ~/.bashrc
