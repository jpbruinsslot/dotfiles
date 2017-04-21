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
# $ sudo ln -s $HOME/.background/background.sh /etc/cron.hourly/background
#
# This will run the script every hour and update the background.
set -e

# Get the hour in simple format, number with preceding 0 (e.g. 08), are
# interpreted as an octal number so ${HOUR#0} is necessary to make it
# decimal
HOUR=$(date +"%H")

# Location of this script
DIR="${HOME}/.background"

# The directory that has the background images
IMAGES=($DIR/images/*)

# The specific command that will set the background
COMMAND="gsettings set org.gnome.desktop.background picture-uri file://"


function set_background() {
    if ((${HOUR#0} >= 5 && ${HOUR#0} <= 7)); then
        $COMMAND${IMAGES[0]}
    elif ((${HOUR#0} >= 7 && ${HOUR#0} <= 9)); then
        $COMMAND${IMAGES[1]}
    elif ((${HOUR#0} >= 9 && ${HOUR#0} <= 11)); then
        $COMMAND${IMAGES[2]}
    elif ((${HOUR#0} >= 11 && ${HOUR#0} <= 13)); then
        $COMMAND${IMAGES[3]}
    elif ((${HOUR#0} >= 13 && ${HOUR#0} <= 15)); then
        $COMMAND${IMAGES[4]}
    elif ((${HOUR#0} >= 15 && ${HOUR#0} <= 17)); then
        $COMMAND${IMAGES[5]}
    elif ((${HOUR#0} >= 17 && ${HOUR#0} <= 19)); then
        $COMMAND${IMAGES[6]}
    elif ((${HOUR#0} >= 19 && ${HOUR#0} <= 21)); then
        $COMMAND${IMAGES[7]}
    elif ((${HOUR#0} >= 21 && ${HOUR#0} <= 23)); then
        $COMMAND${IMAGES[8]}
    elif ((${HOUR#0} >= 23 && ${HOUR#0} <= 1)); then
        $COMMAND${IMAGES[9]}
    elif ((${HOUR#0} >= 1 && ${HOUR#0} <= 3)); then
        $COMMAND${IMAGES[10]}
    elif ((${HOUR#0} >= 3 && ${HOUR#0} <= 5)); then
        $COMMAND${IMAGES[11]}
    fi
}


function cycle() {
    for i in "${IMAGES[@]}"; do
        $COMMAND$i
        sleep 2
    done

    # reset to correct background
    set_background
}


usage() {
    echo "background.sh"
    echo
    echo "This will set the background for a gnome 3 window manager"
    echo "based on a specific time of day. See the script itself on how"
    echo "to set it up."
    echo
    echo "When no argument is provided it will try and set the correct"
    echo "background."
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
