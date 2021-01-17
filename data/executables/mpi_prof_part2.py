#!/usr/bin/env python3
import sys
import pwd
import json
import os

if __name__ == "__main__":
    json_info = {}
    machinefile = "master:1 \n"
    machine_counter = 1
    echo_command = 'sudo echo "{}    {}" >> /etc/hosts'
    known_hosts_command = 'sudo -H -u mpiuser bash -c "ssh-keyscan s{} >> /mirror/.ssh/known_hosts"'
    
    os.system('cd ~')
    with open('/home/vagrant/.virtualabinfo', 'r') as file:
        json_info_raw = file.read()

    try:
        json_info = json.loads(json_info_raw)
    except ValueError as e:
        sys.stderr.write("NO DATA in ~./virtualabinfo, contact with support")
        exit(1)
    try:
        for student in json_info["professor"]["students"]:
            try:
                os.system(echo_command.format(student["ip"], "s" + student["albumnr"]))
            except Exception as e1:
                sys.stderr.write("Failed to write student IP to /etc/hosts")
                exit(1)
            try:
                os.system(known_hosts_command.format(student["albumnr"]))
                sys.stdout.write("executed command: " + known_hosts_command.format(student["albumnr"]) + "\n")
            except Exception as e2:
                sys.stderr.write("Failed to write student SSH key to /mirror/.ssh/known_hosts")
                exit(1)
            machinefile = machinefile + "s" + student["albumnr"] + ":1\n"
            machine_counter = machine_counter + 1
        
        try:
            os.system(echo_command.format(json_info["professor"]["students"][0]["professorip"], "master"))
        except Exception as e3:
            sys.stderr.write("Failed to write profesor IP to /etc/hosts")
            exit(1)
        try:
            machinefile_file = open("/home/vagrant/data/machinefile", "w")
            machinefile_file.write(machinefile)
            machinefile_file.close()
        except Exception as e4:
            sys.stderr.write("Failed to create and/or write to machinefile")
            exit(1)
        sys.exit(machine_counter)
    except Exception as e22:
        sys.stderr.write("Error setting up MPI - either ssh command failed or failed to create machinefile")
        sys.stderr.write(e22)
        exit(1)
