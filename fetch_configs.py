import json
import os
import pathlib

config_locations = "config_locations.json"


with open(config_locations, mode="r") as f:
    locations = json.load(f)

    for location in locations:

        file = pathlib.Path(location["from"])
        if file.exists():
            print("file does exist at the moment!!")
        else:
            print("no such file exists at the moment!!")
