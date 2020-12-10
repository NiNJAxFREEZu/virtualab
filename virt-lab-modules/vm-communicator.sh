#!/bin/bash

# Functions declaration
echoerr() { echo "$@" 1>&2; }

# Script installs communication module used to send text messages across VM's, 
# checking attendance and collecting information about students activities on VM's.

# installing dependencies 
apt-get install python python3-pip git libnotify-bin qt5-default --yes || exit 1

# cloning module's git repository
git clone https://github.com/wranidlo/broadcast_sender_receiver /etc/virtualab/vm-communicator --quiet || exit 1
chmod -R 777 /etc/virtualab/vm-communicator/

# installing python dependencies
pip3 install --no-input -r /etc/virtualab/vm-communicator/requirements.txt --quiet  || exit 1

cd /etc/virtualab/vm-communicator
cp vm-communicator.service /etc/systemd/system/

# creating .env file for systemd service
sudo touch /etc/systemd/system/vm-communicator.env

# launching text-chat receiver service
# systemctl enable vm-communicator.service || exit 1
# systemctl start vm-communicator.service || exit 1