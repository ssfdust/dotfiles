#!/bin/env python3
from pathlib import Path
import requests

URL = "https://wttr.in/nkg?format=%c+%f+%m+%w"


def get_weather():
    req = requests.get(URL)
    tmp = Path("/tmp")
    tmux_weather = tmp / "tmux-weather"
    if not tmux_weather.exists():
        tmux_weather.mkdir()
    weather_txt = tmux_weather / "weather.txt"
    with weather_txt.open("w") as f:
        f.write(req.text)


if __name__ == '__main__':
    get_weather()
