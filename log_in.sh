#!/bin/bash
sleep 40
export DISPLAY=:0.0
export XAUTHORITY=/opt/zabbixkio/.Xauthority
xdotool type --delay 50 "guest_user"
xdotool key --delay 50 Tab
xdotool type --delay 59 "zabbix_guest"
xdotool key --delay 50 Tab
xdotool key --delay 50 space
xdotool key --delay 50 Return
echo xdottool: $(date) >> /home/pi/tst.log
