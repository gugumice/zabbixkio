#!/bin/bash

echo browser: $(date) > /home/pi/tst.log
sh /opt/zabbixkio/log_in.sh &
echo browser: $(date) >> /home/pi/tst.log
xset -dpms     # disable DPMS (Energy Star) features.
xset s off     # disable screen saver
xset s noblank # don't blank the video device
matchbox-window-manager -use_titlebar no &
unclutter &    # hide X mouse cursor unless mouse activated
chromium-browser --display=:0 --kiosk --incognito --window-position=0,0 http://data-proxy.egl.local/zabbix
