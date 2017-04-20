#!/bin/bash
# Download backgrounds from: http://www.bitday.me
#
# On ubuntu this is probably the easiest to create a cron jobs with a symlink:
# $ sudo ln -s $HOME/.background/background.sh /etc/cron.hourly/background.sh

HOUR=$(date +"%H")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if ((${HOUR} >= 5 && $HOUR <= 7)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/01-Early-Morning.png
elif ((${HOUR} >= 7 && $HOUR <= 9)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/02-Mid-Morning.png
elif ((${HOUR} >= 9 && $HOUR <= 11)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/03-Late-Morning.png
elif ((${HOUR} >= 11 && $HOUR <= 13)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/04-Early-Afternoon.png
elif ((${HOUR} >= 13 && $HOUR <= 15)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/05-Mid-Afternoon.png
elif ((${HOUR} >= 15 && $HOUR <= 17)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/06-Late-Afternoon.png
elif ((${HOUR} >= 17 && $HOUR <= 19)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/07-Early-Evening.png
elif ((${HOUR} >= 19 && $HOUR <= 21)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/08-Mid-Evening.png
elif ((${HOUR} >= 21 && $HOUR <= 23)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/09-Late-Evening.png
elif ((${HOUR} >= 23 && $HOUR <= 1)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/10-Early-Night.png
elif ((${HOUR} >= 1 && $HOUR <= 3)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/11-Mid-Night.png
elif ((${HOUR} >= 3 && $HOUR <= 5)); then
    gsettings set org.gnome.desktop.background picture-uri file://${DIR}/12-Late-Night.png
fi
