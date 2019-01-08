#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
weather
-------

This script prints an icon representation of the time of day.

Powered by: https://darksky.net/poweredby/

Dependencies: python3, requests, nerd-fonts

:authors: J.P.H. Bruins Slot
:date:    07-01-2019
:version: 0.1.0

"""
import argparse
import datetime
import json
import sys

import requests

API = "https://api.darksky.net/forecast/{key}/{geocode}?units=auto"


def weather(path):

    weather = "{rain}{pad}{icon}  {temp}°C"

    try:
        with open(path) as f:
            config = json.load(f)
    except FileNotFoundError:
        config = create_config(path)

    key = config.get("key")
    if key is "" or key is None:
        sys.exit("api key is not defined")

    geocode = config.get("geocode")
    if geocode is "" or geocode is None:
        sys.exit("geocode is not defined")

    if call_allowed(config) is False:
        return weather.format(
            rain=config.get("rain", ""),
            pad=config.get("rain", "") and " ",
            temp=config.get("temp", "0"),
            icon=config.get("icon", ""),
        )

    resp = requests.get(
        url=API.format(
            key=config.get("key"),
            geocode=config.get("geocode"),
        ),
        timeout=10,
    )
    if resp.status_code != 200:
        sys.exit("not able to reach api endpoint")

    # Get info from response
    resp_json = resp.json()
    if resp_json is None:
        sys.exit("api response is empty")

    icon = get_icon(resp_json)
    if icon is None:
        sys.exit("icon not found in response")

    rain = get_rain(resp_json)

    temp = int(resp_json.get("currently").get("temperature"))
    if temp is None:
        sys.exit("temp not found in response")

    # Update config
    config["icon"] = icon
    config["temp"] = temp
    config["rain"] = rain
    config["last_check"] = datetime.datetime.now().timestamp()

    with open(path, "w") as f:
        json.dump(config, f)

    return weather.format(
        rain=rain,
        pad=rain and " ",
        temp=temp,
        icon=icon,
    )


def get_rain(resp_json):
    if resp_json.get("hourly").get("icon") is "rain":
        return ""

    return ""


def get_icon(resp_json):
    night = True if (datetime.datetime.now().hour / 18) >= 1.0 else False
    cloudy = True if resp_json.get("currently").get(
        "cloudCover") >= 0.5 else False

    icon = resp_json.get("currently").get("icon")
    if icon == "clear-day":
        return ""
    elif icon == "clear-night":
        return ""
    elif icon == "rain":
        if night:
            return ""
        else:
            return ""
    elif icon == "snow":
        if night:
            return ""
        else:
            return ""
    elif icon == "sleet":
        if night:
            return ""
        else:
            return ""
    elif icon == "wind":
        if night and cloudy:
            return ""
        elif night and not cloudy:
            return ""
        elif not night and cloudy:
            return ""
        elif not night and not cloudy:
            return ""
    elif icon == "fog":
        if night:
            return ""
        else:
            return ""
    elif icon == "cloudy":
        if night:
            return ""
        else:
            return ""
    elif icon == "partly-cloudy-day":
        return ""
    elif icon == "partly-cloudy-night":
        return ""
    else:
        return ""


def call_allowed(config):
    last_check = datetime.datetime.fromtimestamp(config.get("last_check"))
    now = datetime.datetime.now()

    # We're to use the api 1000 times a day, this means
    # ((24*60)*60)/100 = 86.4 seconds between calls.
    delta = now - last_check
    if delta.seconds > 300:
        return True

    return False


def create_config(path):
    config = {
        "geocode": "",
        "key": "",
        "icon": "",
        "rain": "",
        "last_check": datetime.datetime.now().timestamp(),
    }

    with open(path, "w") as f:
        json.dump(config, f)

    return config


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="weather")

    parser.add_argument(
        "--config",
        '-c',
        dest='configuration',
        metavar="FILE",
        help="Configuration file to use",
    )

    args = parser.parse_args()

    if args.configuration is None:
        sys.exit("path to configuration file not specified")

    print(weather(args.configuration))
