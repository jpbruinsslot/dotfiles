#!/usr/bin/env python
# -*- coding: utf-8 -*-

##############################################################################
#
# clock
# -----
#
# This script prints an icon representation of the time of day.
#
# Dependencies: python3, nerd-fonts
#
# :authors: J.P.H. Bruins Slot
# :date:    07-01-2019
# :version: 0.1.0
#
##############################################################################

import datetime


def clock():
    now = datetime.datetime.now().hour % 12

    if now == 0:
        return ""
    elif now == 1:
        return ""
    elif now == 2:
        return ""
    elif now == 3:
        return ""
    elif now == 4:
        return ""
    elif now == 5:
        return ""
    elif now == 6:
        return ""
    elif now == 7:
        return ""
    elif now == 8:
        return ""
    elif now == 9:
        return ""
    elif now == 10:
        return ""
    elif now == 11:
        return ""
    else:
        return ""


if __name__ == "__main__":
    print(clock())
