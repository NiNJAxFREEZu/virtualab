#!/usr/bin/env python3
import sys
import pwd
import json
import os

if __name__ == "__main__":
    json_info = {}
    machinefile = "master:2 \n"
    machine_counter = 1
    os.system('cd ~')
    with open('/home/vagrant/.virtualabinfo', 'r') as file:
        json_info_raw = file.read()

    try:
        json_info = json.loads(json_info_raw)
    except ValueError as e:
        sys.stderr.write("NO DATA in ~./virtualabinfo, contact with support")
        exit(1)
    try:
        echo_command = 'sudo echo "{}    {}" >> /etc/hosts'
        for student in json_info["students"]:
            os.system(echo_command.format(student["ip"], "s" + student["albumnr"]))
            os.system('sudo -H -u mpiuser bash -c "ssh-keyscan ' + student["ip"] + ' >> /mirror/.ssh/known_hosts"')
            machinefile = machinefile + "s" + student["albumnr"] + ":1\n"
            machine_counter = machine_counter + 1

        machinefile_file = open("/home/vagrant/data/machinefile", "w")
        machinefile_file.write(machinefile)
        machinefile_file.close()
        sys.exit(machine_counter)
    except Exception as e2:
        sys.stderr.write("Error setting up MPI - either ssh command failed or failed to create machinefile")
        exit(1)
