#!/usr/bin/env bash

# Gets the 1-minute CPU load average.
get_cpu_load() {
    awk '{printf "%.2f", $1}' /proc/loadavg
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

    printf " %d°C  %s  %2d%% ⮃ %s\n" "$cpu_temp" "$cpu_load" "$mem_load" "$net_speeds"
}

main
