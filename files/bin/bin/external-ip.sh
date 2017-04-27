#/bin/bash
# https://github.com/vivien/i3blocks/blob/master/scripts/wifi

IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

if [ -z "$IP" ]; then
    IP=""
fi

if [ ! -d /sys/class/net/wlan0/wireless ] || [ "$(cat /sys/class/net/wlan0/operstate)" = 'down' ]; then
    echo " ${IP}"
else
    QUALITY=$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

    echo " ${IP}"
fi
