#!/bin/bash

# Functions declaration
echoerr() { echo "$@" 1>&2; }

# Script installs communication module used to send text messages across VM's, 
# checking attendance and collecting information about students activities on VM's.

# installing dependencies 
apt-get install python python3-pip git libnotify-bin --yes > /dev/null || echoerr "E: Error while trying to install a package - apt package manager is currently being used by another process."

# cloning module's git repository
git clone https://github.com/wranidlo/broadcast_sender_receiver /etc/virtualab/vm-communicator --quiet || echoerr "E: Error while trying to pull git repository for vm-communicator."
chmod -R 777 /etc/virtualab/vm-communicator/

# installing python dependencies
pip3 install --no-input -r /etc/virtualab/vm-communicator/requirements.txt --quiet 

# launching text-chat receiver
cd /etc/virtualab/vm-communicator
nohup python3 student_main.py &