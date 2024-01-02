#!/usr/bin/env bash
INTERFACE="wlp*"

# IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
IP=$(curl -s ifconfig.me)
ERR="$?"
if [ -z "$IP" ] || [ "$ERR" -ne 0 ]; then
	IP="x.x.x.x"
fi

VPN=$(ip tuntap show)
ERR="$?"
if [ -z "$VPN" ] || [ "$ERR" -ne 0 ]; then
	VPN=""
else
	VPN=""
fi

if [ ! -d /sys/class/net/${INTERFACE}/wireless ] || [ "$(cat /sys/class/net/${INTERFACE}/operstate)" = 'down' ]; then
	echo "󰈀  ${VPN} ${IP}"
else
	QUALITY=$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
	echo "  ${QUALITY}% ${VPN} ${IP}"
fi
