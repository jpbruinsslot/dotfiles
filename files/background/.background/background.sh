#!/bin/bash
set -e

# Location of this script
DIR="${HOME}/.background"

# The directory that has the background images
IMAGES=($DIR/images/*)

# The specific command that will set the background
COMMAND="gsettings set org.gnome.desktop.background picture-uri file://"
# COMMAND="feh --bg-fill "

function 8bit() {
    # Get the hour in simple format, number with preceding 0 (e.g. 08), are
    # interpreted as an octal number so ${hour#0} is necessary to make it
    # decimal
    local hour=$(date +"%H")

    # The directory that has the background images
    local images=($DIR/8bit/*)

    # Cycle through all images to showcase it
    if [[ "$1" == "cycle" ]]; then
        for i in "${images[@]}"; do
            $COMMAND$i
            sleep 2
        done
    fi

    if ((${hour#0} >= 5 && ${hour#0} <= 7)); then
        $COMMAND${images[0]}
    elif ((${hour#0} >= 7 && ${hour#0} <= 9)); then
        $COMMAND${images[1]}
    elif ((${hour#0} >= 9 && ${hour#0} <= 11)); then
        $COMMAND${images[2]}
    elif ((${hour#0} >= 11 && ${hour#0} <= 13)); then
        $COMMAND${images[3]}
    elif ((${hour#0} >= 13 && ${hour#0} <= 15)); then
        $COMMAND${images[4]}
    elif ((${hour#0} >= 15 && ${hour#0} <= 17)); then
        $COMMAND${images[5]}
    elif ((${hour#0} >= 17 && ${hour#0} <= 19)); then
        $COMMAND${images[6]}
    elif ((${hour#0} >= 19 && ${hour#0} <= 21)); then
        $COMMAND${images[7]}
    elif ((${hour#0} >= 21 && ${hour#0} <= 23)); then
        $COMMAND${images[8]}
    elif ((${hour#0} >= 23 && ${hour#0} <= 1)); then
        $COMMAND${images[9]}
    elif ((${hour#0} >= 1 && ${hour#0} <= 3)); then
        $COMMAND${images[10]}
    elif ((${hour#0} >= 3 && ${hour#0} <= 5)); then
        $COMMAND${images[11]}
    fi
}

function soho() {
    local num=$1
    local nums=( 171 195 284 304 )

    if [[ -z "$num" ]]; then
        num=304
    elif [[ "$num" == "cycle" ]]; then
        for i in "${nums[@]}"; do
            soho $i
            sleep 3
        done

        soho
        exit 0
    fi

    if [[ ! "${nums[@]}" =~ "$num" ]]; then
        echo "Incorrect number, please select the following: 171, 195, 284, 304."
        exit 1
    fi

    curl -sSL https://sohowww.nascom.nasa.gov/data/realtime/eit_$num/1024/latest.jpg > /tmp/soho-$num.jpg
    $COMMAND/tmp/soho-$num.jpg
}

usage() {
    echo "background.sh"
    echo
    echo "This script will set a background based on the time of day."
    echo 
    echo "Usage:"
    echo "  8bit {cycle}                   - set 8bit-day background"
    echo "  soho {171,195,284,304,cycle}   - get image from solar and heliospheric observatory"
    echo "  help                           - show this page"
}


main() {
    local cmd=$1

    if [[ -z "$cmd" ]]; then
        usage
        exit 1
    fi

    if [[ $cmd == "8bit" ]]; then
        8bit "$2"
    fi

    if [[ $cmd == "soho" ]]; then
        soho "$2"
    fi

    if [[ $cmd == "help" ]]; then
        usage
    fi
}

main "$@"
