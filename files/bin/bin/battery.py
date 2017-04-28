#!/usr/bin/env python3
# -*- coding: utf-8 -*-

##############################################################################
#
# battery
# -------
#
# This script will output a specific icon based on the charge of a laptop
# battery. When the script is run on a system without a battery it will
# output an icon accordingly.
#
# Additionally the script will send a notification to disconnect or connect
# the charger when it's above 80% or below 40%.
# (https://superuser.com/a/427108)
#
# Dependencies: python3, acpi, notify-send, font-awesome
#
# :authors: J.P.H. Bruins Slot
# :date:    24-04-2017
# :version: 0.1.0
#
##############################################################################

import os
import re
import sys
import subprocess
from pathlib import Path

FILE = "/tmp/bat"


def notify(percentage):
    touch_file = os.path.isfile(FILE)

    if percentage > 80 and not touch_file:
        # notify and create file
        subprocess.run(
            [
                "notify-send",
                "-i",
                "battery",
                "Please disconnect charger"
            ]
        )
        Path(FILE).touch()
    elif 40 <= percentage <= 80 and touch_file:
        # remove touch file
        os.remove(FILE)
    elif percentage < 40 and not touch_file:
        # notify and create file
        subprocess.run(
            [
                "notify-send",
                "-i",
                "battery",
                "Please connect charger"
            ]
        )
        Path(FILE).touch()
    else:
        pass


def check_status(metric_percentage, metric_status):

    if metric_status == b"Full":
        return ""
    elif metric_status == b"Charging":
        return ""
    elif metric_status == b"Discharging":
        if metric_percentage <= 20:
            return " "
        elif 21 <= metric_percentage <= 40:
            return " "
        elif 41 <= metric_percentage <= 60:
            return " "
        elif 61 <= metric_percentage <= 80:
            return " "
        elif 81 <= metric_percentage <= 100:
            return " "
    else:
        return ""


def main():
    try:
        console_output = subprocess.check_output(
            "acpi",
            stderr=subprocess.STDOUT,
            shell=True)
    except:
        sys.exit(
            "acpi not found please install with sudo apt-get install acpi")

    # There is no battery and probably on a power supply
    if b"No support" in console_output or console_output == b"":
        print("")
        return

    # Format will be:
    # Battery 1: discharging, 44%, 00:18:48 remaining
    list_metrics = console_output.split(b", ")

    metric_status = list_metrics[0].split(b":")[-1].strip()
    metric_percentage = int(re.match(b'\d+', list_metrics[1]).group())

    # Send notification when necessary
    notify(metric_percentage)

    print(
        "{icon} {percentage}%".format(
            icon=check_status(metric_percentage, metric_status),
            percentage=metric_percentage
        )
    )


if __name__ == '__main__':
    main()
