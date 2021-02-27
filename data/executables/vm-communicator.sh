#!/bin/bash
# Script installs communication module used to send text messages across VM's, 
# checking attendance and collecting information about students activities on VM's.

# installing dependencies 
# sudo apt-get install xdotool python python3-pip git libnotify-bin qt5-default --yes || exit 1

# cloning module's git repository
sudo git clone https://github.com/wranidlo/broadcast_sender_receiver /etc/virtualab/vm-communicator --quiet || exit 1
sudo chmod -R 777 /etc/virtualab/vm-communicator/

# installing python dependencies
# pip3 install --no-input -r /etc/virtualab/vm-communicator/requirements.txt --quiet  || exit 1

exit 0