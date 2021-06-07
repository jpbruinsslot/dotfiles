#/bin/bash

##############################################################################
#
# external-ip
# -----------
#
# This script will output the external IP address of the host machine by using
# the dig command. It will accompany the IP address with an icon indicating
# whether the host machine is connected by wifi or wire.
#
#
# Dependencies: dig, nerd-fonts, ip
#
# Credits:
# - https://github.com/vivien/i3blocks/blob/master/scripts/wifi
#
# :authors: J.P.H. Bruins Slot
# :date:    16-02-2019
# :version: 0.1.2
#
##############################################################################

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
    echo "  ${VPN} ${IP}"
else
    QUALITY=$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
    echo "  ${QUALITY}%  ${VPN} ${IP}"
fi
