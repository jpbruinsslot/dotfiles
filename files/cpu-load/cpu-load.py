#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import psutil


def get_cpu_load():
    load = psutil.cpu_percent(interval=1)
    return "%s%%" % load


def main():
    try:
        print get_cpu_load()
    except:
        sys.exit(
            "psutil not found please install with pip install psutil")

if __name__ == '__main__':
    main()
