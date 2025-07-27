#!/usr/bin/env bash
#
# battery.sh
#
# This script monitors the laptop battery status and provides visual feedback
# (icons and percentage) and sends desktop notifications for charging/discharging
# reminders. It uses /sys/class/power_supply/BAT0 for battery information.
#
# Features:
# - Displays battery status with appropriate icons (full, charging, discharging levels, unknown).
# - Sends notifications when battery charge is above 80% (disconnect charger) or below 40% (connect charger).
# - Uses a temporary file (/tmp/bat) to prevent repeated notifications for the same event.
#
# Usage:
#   battery.sh             - Displays the current battery status and percentage.
#
# Dependencies:
# - `notify-send` for desktop notifications.
# - Nerd Fonts for the icons.

FILE="/tmp/bat"

notify() {
    local percentage=$1
    local touch_file_exists=false
    if [ -f "$FILE" ]; then
        touch_file_exists=true
    fi

    if [ "$percentage" -gt 80 ] && [ "$touch_file_exists" == "false" ]; then
        # notify and create file
        notify-send -i battery "Please disconnect charger"
        echo -e "\a"
        touch "$FILE"
    elif [ "$percentage" -ge 40 ] && [ "$percentage" -le 80 ] && [ "$touch_file_exists" == "true" ]; then
        # remove touch file
        rm "$FILE"
    elif [ "$percentage" -lt 40 ] && [ "$touch_file_exists" == "false" ]; then
        # notify and create file
        notify-send -i battery "Please connect charger"
        echo -e "\a"
        touch "$FILE"
    fi
}

check_status() {
    local percentage=$1
    local status=$2

    case "$status" in
    "Full")
        echo ""
        ;;
    "Charging")
        echo ""
        ;;
    "Discharging")
        if [ "$percentage" -le 20 ]; then
            echo " "
        elif [ "$percentage" -le 40 ]; then
            echo " "
        elif [ "$percentage" -le 60 ]; then
            echo " "
        elif [ "$percentage" -le 80 ]; then
            echo " "
        else
            echo " "
        fi
        ;;
    *)
        echo ""
        ;;
    esac
}

main() {
    local battery_path="/sys/class/power_supply/BAT0"

    # There is no battery or battery status is unknown
    if [ ! -e "$battery_path" ]; then
        echo ""
        return
    fi

    local metric_status=$(cat "$battery_path/status")
    local metric_percentage=$(cat "$battery_path/capacity")

    # Send notification when necessary
    notify "$metric_percentage"

    echo "$(check_status "$metric_percentage" "$metric_status") ${metric_percentage}%"
}

main

