#!/usr/bin/env python3
import sys
import pwd
import json
import os

if __name__ == "__main__":
    json_info = {}
    echo_command = 'sudo echo "{}    {}" >> /etc/hosts'

    os.system('cd ~')
    with open('/home/vagrant/.virtualabinfo', 'r') as file:
        json_info_raw = file.read()

    try:
        json_info = json.loads(json_info_raw)
    except ValueError as e:
        sys.stderr.write("NO DATA in ~./virtualabinfo, contact with support")
        exit(1)

    try:
        os.system(echo_command.format(json_info["student"]["professorip"], "master"))
    except Exception as e2:
        sys.stderr.write("Error writing to /etc/hosts")
        exit(1)
