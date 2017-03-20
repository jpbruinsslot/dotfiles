#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import psutil


def get_cpu_load():
    load = psutil.cpu_percent(interval=1)
    return "%s%%" % load


def get_memory_percent():
    mem = psutil.virtual_memory()
    return "%s%%" % mem.percent


def main():
    try:
        print("%s %s" % (get_cpu_load(), get_memory_percent()))
    except:
        sys.exit(
            "psutil not found please install with pip install psutil")

if __name__ == '__main__':
    main()
