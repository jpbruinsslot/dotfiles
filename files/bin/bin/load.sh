#!/usr/bin/env bash

get_cpu_load() {
	echo "$(ps -eo pcpu | awk 'NR>1' | awk '{sum+=$1} END{print sum}')"
}

get_mem_load() {
	echo "$(free -m | awk 'NR==2{printf "%.0f", $3*100/$2}')"
}

get_average_cpu_load() {
	num_cores=$(nproc)
	total_cpu_load=$(get_cpu_load)
	average_cpu_load=$(echo "scale=0; $total_cpu_load / $num_cores" | bc)
	echo "$average_cpu_load"
}

get_cpu_temp() {
	temperature=$(cat /sys/class/thermal/thermal_zone0/temp)
	temperature_celsius=$((temperature / 1000))
	echo "$temperature_celsius"
}

get_active_network_interface() {
	# Detect the active network interface (excluding lo)
	interface=$(ip route get 8.8.8.8 | awk '/dev/ {print $5}')
	echo "$interface"
}

get_network_speeds() {
	interface=$(get_active_network_interface)
	network_stats=$(cat /proc/net/dev | awk '/'"$interface"'/ {print $2,$10}')
	download_speed=$(printf "%.0f" "$(echo "$network_stats" | awk '{print $1/1024}')")
	upload_speed=$(printf "%.0f" "$(echo "$network_stats" | awk '{print $2/1024}')")

	echo "$download_speed/$upload_speed"
}

get_network_speeds() {
	interface=$(get_active_network_interface)
	rx_before=$(cat /proc/net/dev | awk '/'"$interface"'/ {print $2}')
	tx_before=$(cat /proc/net/dev | awk '/'"$interface"'/ {print $10}')

	sleep 1

	rx_after=$(cat /proc/net/dev | awk '/'"$interface"'/ {print $2}')
	tx_after=$(cat /proc/net/dev | awk '/'"$interface"'/ {print $10}')

	download_speed=$((rx_after - rx_before))
	upload_speed=$((tx_after - tx_before))

	echo "$download_speed/$upload_speed"
}

main() {
	cpu_load=$(get_average_cpu_load)
	mem_load=$(get_mem_load)
	cpu_temp=$(get_cpu_temp)
	net_speeds=$(get_network_speeds)

	printf " %d°C  %2d%%  %2d%% ⮃ %s\n" "$cpu_temp" "$cpu_load" "$mem_load" "$net_speeds"
}

main
