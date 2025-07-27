#!/usr/bin/env bash
#
# netinfo.sh
#
# This script provides network information including VPN status, wireless signal quality (if applicable),
# and optionally, the public IP address. It's designed to be used in a CLI or status bar.
#
# Usage:
#   netinfo.sh             - Displays VPN status, wireless info, and public IP.
#   netinfo.sh --no-ip     - Displays VPN status and wireless info, but hides the public IP.
#
# Dependencies:
# - Nerd Fonts for the icons.

get_public_ip() {
    local IP=$(curl -s ifconfig.me)
    local ERR="$?"
    if [ -z "$IP" ] || [ "$ERR" -ne 0 ]; then
        echo "x.x.x.x"
    else
        echo "$IP"
    fi
}

get_vpn_status() {
    local VPN=$(ip tuntap show)
    local ERR="$?"
    if [ -z "$VPN" ] || [ "$ERR" -ne 0 ]; then
        echo ""
    else
        echo ""
    fi
}

get_wireless_info() {
    local INTERFACE="wlp*"
    if [ ! -d "/sys/class/net/${INTERFACE}/wireless" ] || [ "$(cat /sys/class/net/${INTERFACE}/operstate)" = 'down' ]; then
        echo ""
    else
        local QUALITY=$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
        echo "  ${QUALITY}%"
    fi
}

main() {
    local show_ip=true
    for arg in "$@"; do
        if [ "$arg" == "--no-ip" ]; then
            show_ip=false
            break
        fi
    done

    local IP=""
    if $show_ip; then
        IP=$(get_public_ip)
    fi

    local VPN=$(get_vpn_status)
    local WIRELESS_INFO=$(get_wireless_info)

    local output_ip=""
    if $show_ip; then
        output_ip=" ${IP}"
    fi

    if [ -z "$WIRELESS_INFO" ]; then
        echo "󰈀  ${VPN}${output_ip}"
    else
        echo "${WIRELESS_INFO} ${VPN}${output_ip}"
    fi
}

main "$@"

