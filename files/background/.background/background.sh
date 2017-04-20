#!/bin/bash
#
# Background changer based on the time of day for gnome 3 window manager
# on ubuntu, when using a different window manager check how to change your
# background on the commandline, `feh` is a good program.
#
# Download backgrounds from: http://www.bitday.me, place those files and
# this script in the ./background directory
#
# On ubuntu this is probably the easiest to create a cron jobs with a symlink:
#
# $ sudo ln -s $HOME/.background/background.sh /etc/cron.hourly/background.sh
#
# This will run the script every hour and update the background.
set -e

# Get the hour in simple format
HOUR=$(date +"%H")

# Location of this script
DIR="${HOME}/.background"

# The directory that has the background images
IMAGES=($DIR/images/*)

# The specific command that will set the background
COMMAND="gsettings set org.gnome.desktop.background picture-uri file://"

function set_background() {
    if ((${HOUR} >= 5 && $HOUR <= 7)); then
        $COMMAND${IMAGES[0]}
    elif ((${HOUR} >= 7 && $HOUR <= 9)); then
        $COMMAND${IMAGES[1]}
    elif ((${HOUR} >= 9 && $HOUR <= 11)); then
        $COMMAND${IMAGES[2]}
    elif ((${HOUR} >= 11 && $HOUR <= 13)); then
        $COMMAND${IMAGES[3]}
    elif ((${HOUR} >= 13 && $HOUR <= 15)); then
        $COMMAND${IMAGES[4]}
    elif ((${HOUR} >= 15 && $HOUR <= 17)); then
        $COMMAND${IMAGES[5]}
    elif ((${HOUR} >= 17 && $HOUR <= 19)); then
        $COMMAND${IMAGES[6]}
    elif ((${HOUR} >= 19 && $HOUR <= 21)); then
        $COMMAND${IMAGES[7]}
    elif ((${HOUR} >= 21 && $HOUR <= 23)); then
        $COMMAND${IMAGES[8]}
    elif ((${HOUR} >= 23 && $HOUR <= 1)); then
        $COMMAND${IMAGES[9]}
    elif ((${HOUR} >= 1 && $HOUR <= 3)); then
        $COMMAND${IMAGES[10]}
    elif ((${HOUR} >= 3 && $HOUR <= 5)); then
        $COMMAND${IMAGES[11]}
    fi
}


function cycle() {
    # cycle throught all images
    for i in "${IMAGES[@]}"; do
        $COMMAND$i
        sleep 2
    done

    # reset
    set_background
}

usage() {
    echo "background.sh"
    echo
    echo "This will set the background for a gnome 3 window manager based on"
    echo "a specific time of day. See the script itself on how to set it up."
    echo
    echo "When no argument is provided it will try and set the correct background."
    echo 
    echo "Usage:"
    echo "  cycle               - cycle through all the backgrounds"
    echo "  help                - show this page"
}

main() {
    local cmd=$1

    if [[ -z "$cmd" ]]; then
        set_background
    fi

    if [[ $cmd == "cycle" ]]; then
        cycle
    fi

    if [[ $cmd == "help" ]]; then
        usage
    fi
}

main "$@"
