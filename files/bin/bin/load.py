#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import psutil


def get_cpu_load():
    return psutil.cpu_percent(interval=1)


def get_mem_load():
    return psutil.virtual_memory().percent


def main():
    try:
        print("﬙ %4s%%  %4s%%" % (get_cpu_load(), get_mem_load()))
    except:
        sys.exit("psutil not found, please install it (pip install psutil)")


if __name__ == "__main__":
    main()
