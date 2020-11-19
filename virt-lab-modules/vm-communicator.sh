#!/bin/sh

# Functions declaration
echoerr() { echo "$@" 1>&2; }

# Script installs communication module used to send text messages across VM's, 
# checking attendance and collecting information about students activities on VM's.

# installing dependencies 
apt install python python3-pip git libnotify-bin || echoerr "Error while trying to install a package - apt package manager is currently being used by another process."; exit 1

# cloning module's git repository
git clone https://github.com/wranidlo/broadcast_sender_receiver /etc/virt-lab/vm-comm
chmod -R 777 /etc/virt-lab/vm-comm/
cd /etc/virt-lab/vm-comm

# installing python dependencies
pip install pyqt5 -r requirements.txt

# launching text-chat receiver
nohup python3 student_main.py &