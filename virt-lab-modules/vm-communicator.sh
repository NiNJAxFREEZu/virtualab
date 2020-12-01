#!/bin/bash

# Functions declaration
echoerr() { echo "$@" 1>&2; }

# Script installs communication module used to send text messages across VM's, 
# checking attendance and collecting information about students activities on VM's.

# installing dependencies 
apt-get install python python3-pip git libnotify-bin --yes > || echoerr "E: apt cannot install a packages right now - apt package manager is currently being used by another process."

# cloning module's git repository
git clone https://github.com/wranidlo/broadcast_sender_receiver /etc/virtualab/vm-communicator --quiet || echoerr "E: git was unable to pull the repository for vm-communicator."
chmod -R 777 /etc/virtualab/vm-communicator/

# installing python dependencies
pip3 install --no-input -r /etc/virtualab/vm-communicator/requirements.txt --quiet 

# launching text-chat receiver service
cd /etc/virtualab/vm-communicator
cp vm-communicator.service /etc/systemd/system/

systemctl enable vm-communicator.service || echoerr "E: systemd was unable to enable vm-communicator service."
systemctl start vm-communicator.service || echoerr "E: systemd was unable to start vm-communicator service."