#!/bin/bash

# Path to the video file
video_path="/home/jp/Videos/pixel.mp4"

# Get the names of connected monitors using xrandr
connected_monitors=$(xrandr --listmonitors | grep -oP '\s+\K\S+$')

# Loop through each connected monitor
for monitor in $connected_monitors; do
    # Run mpv on the monitor and get its process ID
    mpv --input-ipc-server="/tmp/mpvsocket_$monitor" --no-osc --no-osd-bar --quiet --no-audio --loop "$video_path" &
    mpv_pid=$!

    # Sleep for a short duration to allow mpv to start
    sleep 1

    # Use xdotool to simulate key presses that hide the window decorations
    xdotool search --sync --onlyvisible --pid "$mpv_pid" key --clearmodifiers F11
done
