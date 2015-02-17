#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import sys
import subprocess


def check_status(metric_status):
    if metric_status == "charging":
        return '⚡'
    if metric_status == "discharging":
        return "⇣"


def main():
    # Check battery status using acpi
    try:
        console_output = subprocess.check_output(
            "acpi",
            stderr=subprocess.STDOUT,
            shell=True)
    except:
        sys.exit(
            "acpi not found please install with sudo apt-get install acpi")

    if "No support" in console_output:
        # There is no battery and probably on a power supply
        print '⚡'
        return

    # Format will be:
    # Battery 1: discharging, 44%, 00:18:48 remaining
    list_metrics = console_output.split(", ")

    metric_status = list_metrics[0].split(":")[-1].strip()
    metric_percentage = int(re.match(r'\d+', list_metrics[1]).group())
    metric_remaining = re.match(r'[\d\:]+', list_metrics[2]).group

    print "%s %s%%" % (check_status(metric_status), metric_percentage)

if __name__ == '__main__':
    main()
