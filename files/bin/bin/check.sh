#!/usr/bin/env bash

MAC="3c:01:ef:a7:ce:da"
LOGFILE="/var/log/mac_detect.log"
INTERVAL=30 # Time in seconds between scans

echo "Starting MAC address monitor..."
echo "Logs will be saved to $LOGFILE"

while true; do
    if sudo nmap -sn 192.168.1.0/24 | grep -B 2 "$MAC"; then
        echo "$(date) - Mac detected on the network!" | tee -a "$LOGFILE"
        notify-send "Mac Connected!" "MAC address $MAC detected on the network." # Desktop notification
    else
        echo "$(date) - Mac not detected." >>"$LOGFILE"
    fi
    sleep $INTERVAL
done
