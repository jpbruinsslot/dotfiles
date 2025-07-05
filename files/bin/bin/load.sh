#!/usr/bin/env bash

# Calculates the overall CPU utilization percentage from /proc/stat over a 1-second interval.
get_cpu_load() {
    local cpu_stats_before=($(grep '^cpu ' /proc/stat))
    local user_before=${cpu_stats_before[1]:-0}
    local nice_before=${cpu_stats_before[2]:-0}
    local system_before=${cpu_stats_before[3]:-0}
    local idle_before=${cpu_stats_before[4]:-0}
    local iowait_before=${cpu_stats_before[5]:-0}
    local irq_before=${cpu_stats_before[6]:-0}
    local softirq_before=${cpu_stats_before[7]:-0}
    local steal_before=${cpu_stats_before[8]:-0}
    local guest_before=${cpu_stats_before[9]:-0}

    local total_cpu_time_before=$((user_before + nice_before + system_before + idle_before + iowait_before + irq_before + softirq_before + steal_before + guest_before))
    local idle_time_before=$idle_before

    sleep 1

    local cpu_stats_after=($(grep '^cpu ' /proc/stat))
    local user_after=${cpu_stats_after[1]:-0}
    local nice_after=${cpu_stats_after[2]:-0}
    local system_after=${cpu_stats_after[3]:-0}
    local idle_after=${cpu_stats_after[4]:-0}
    local iowait_after=${cpu_stats_after[5]:-0}
    local irq_after=${cpu_stats_after[6]:-0}
    local softirq_after=${cpu_stats_after[7]:-0}
    local steal_after=${cpu_stats_after[8]:-0}
    local guest_after=${cpu_stats_after[9]:-0}

    local total_cpu_time_after=$((user_after + nice_after + system_after + idle_after + iowait_after + irq_after + softirq_after + steal_after + guest_after))
    local idle_time_after=$idle_after

    # Calculate differences
    local total_diff=$((total_cpu_time_after - total_cpu_time_before))
    local idle_diff=$((idle_time_after - idle_time_before))

    # Calculate CPU usage percentage
    if (( total_diff > 0 )); then
        echo $(( (total_diff - idle_diff) * 100 / total_diff ))
    else
        echo 0
    fi
}

# Calculates the memory usage percentage.
get_mem_load() {
    echo "$(free -m | awk 'NR==2{printf "%.0f", $3*100/$2}')"
}

# Gets the CPU temperature, prioritizing 'x86_pkg_temp' if available.
get_cpu_temp() {
    local temperature_celsius="N/A"
    local found_x86_pkg_temp="false"

    # First, try to find x86_pkg_temp specifically
    for zone_path in /sys/class/thermal/thermal_zone*/temp; do
        local zone_dir=$(dirname "$zone_path")
        local zone_type_path="$zone_dir/type"

        if [[ -f "$zone_type_path" && "$(cat "$zone_type_path")" == "x86_pkg_temp" ]]; then
            temperature=$(cat "$zone_path")
            if [[ "$temperature" =~ ^[0-9]+$ ]]; then
                temperature_celsius=$((temperature / 1000))
                found_x86_pkg_temp="true"
                break
            fi
        fi
    done

    # If x86_pkg_temp was not found or didn't provide a valid reading, fall back to the first valid temperature
    if [[ "$found_x86_pkg_temp" == "false" ]]; then
        for zone_path in /sys/class/thermal/thermal_zone*/temp; do
            if [[ -f "$zone_path" ]]; then
                temperature=$(cat "$zone_path")
                if [[ "$temperature" =~ ^[0-9]+$ ]]; then
                    temperature_celsius=$((temperature / 1000))
                    break # Found a valid temperature, exit loop
                fi
            fi
        done
    fi

    echo "$temperature_celsius"
}

# Detects the active network interface by checking the default route.
get_active_network_interface() {
    # Detect the active network interface (excluding lo)
    interface=$(ip route get 8.8.8.8 | awk '/dev/ {print $5}')
    echo "$interface"
}

# Calculates download and upload speeds in KB/s for the active network interface.
get_network_speeds() {
    local interface
    interface=$(get_active_network_interface)

    # Ensure interface is not empty
    if [[ -z "$interface" ]]; then
        echo "0/0"
        return
    fi

    local rx_before
    rx_before=$(cat /proc/net/dev | awk -v iface="$interface" '$0 ~ iface {print $2}')
    local tx_before
    tx_before=$(cat /proc/net/dev | awk -v iface="$interface" '$0 ~ iface {print $10}')

    sleep 1

    local rx_after
    rx_after=$(cat /proc/net/dev | awk -v iface="$interface" '$0 ~ iface {print $2}')
    local tx_after
    tx_after=$(cat /proc/net/dev | awk -v iface="$interface" '$0 ~ iface {print $10}')

    # Default to 0 if values are empty or non-numeric
    rx_before=${rx_before:-0}
    tx_before=${tx_before:-0}
    rx_after=${rx_after:-0}
    tx_after=${tx_after:-0}

    local download_speed=$(((rx_after - rx_before) / 1024))
    local upload_speed=$(((tx_after - tx_before) / 1024))

    echo "$download_speed/$upload_speed"
}

main() {
    cpu_load=$(get_cpu_load)
    mem_load=$(get_mem_load)
    cpu_temp=$(get_cpu_temp)
    net_speeds=$(get_network_speeds)

    printf " %d°C  %2d%%  %2d%% ⮃ %s\n" "$cpu_temp" "$cpu_load" "$mem_load" "$net_speeds"
}

main

