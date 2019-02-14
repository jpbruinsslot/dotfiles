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
# Dependencies: dig, nerd-fonts
#
# Credits:
# - https://github.com/vivien/i3blocks/blob/master/scripts/wifi
#
# :authors: J.P.H. Bruins Slot
# :date:    14-02-2019
# :version: 0.1.2
#
##############################################################################

INTERFACE="wl*"
IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

if [ -z "$IP" ] || [ "$?" -ne "0" ]; then
    IP="x.x.x.x"
fi

if [ ! -d /sys/class/net/${INTERFACE}/wireless ] || [ "$(cat /sys/class/net/${INTERFACE}/operstate)" = 'down' ]; then
    echo " ${IP}"
else
    QUALITY=$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

    echo "  ${IP}"
fi
