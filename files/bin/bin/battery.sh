#!/usr/bin/env bash

FILE="/tmp/bat"

notify() {
	touch_file=$(test -f $FILE && echo "true" || echo "false")

	if [ $1 -gt 80 ] && [ $touch_file == "false" ]; then
		# notify and create file
		notify-send -i battery "Please disconnect charger"
		echo -e "\a"
		touch $FILE
	elif [ $1 -ge 40 ] && [ $1 -le 80 ] && [ $touch_file == "true" ]; then
		# remove touch file
		rm $FILE
	elif [ $1 -lt 40 ] && [ $touch_file == "false" ]; then
		# notify and create file
		notify-send -i battery "Please connect charger"
		echo -e "\a"
		touch $FILE
	fi
}

check_status() {
	if [ "$2" == "Full" ]; then
		echo ""
	elif [ "$2" == "Charging" ]; then
		echo ""
	elif [ "$2" == "Discharging" ]; then
		if [ $1 -le 20 ]; then
			echo " "
		elif [ $1 -ge 21 ] && [ $1 -le 40 ]; then
			echo " "
		elif [ $1 -ge 41 ] && [ $1 -le 60 ]; then
			echo " "
		elif [ $1 -ge 61 ] && [ $1 -le 80 ]; then
			echo " "
		elif [ $1 -ge 81 ] && [ $1 -le 100 ]; then
			echo " "
		fi
	else
		echo ""
	fi
}

main() {
	battery_path="/sys/class/power_supply/BAT0"

	# There is no battery or battery status is unknown
	if [ ! -e "$battery_path" ]; then
		echo ""
		return
	fi

	metric_status=$(cat $battery_path/status)
	metric_percentage=$(cat $battery_path/capacity)

	# Send notification when necessary
	notify $metric_percentage

	echo "$(check_status $metric_percentage $metric_status) $metric_percentage%"
}

main
