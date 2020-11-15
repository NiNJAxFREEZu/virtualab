#!/bin/sh

# Script installs communication module used to send text messages across VM's, 
# checking attendance and collecting information about students activities on VM's.

# removing dpkg-locks for apt-get in case Ubuntu autoupdates at the moment.
rm /var/lib/dpkg/lock*

# if by very unfortunate chance DPKG vas running while removing the lock, we have to autoconfigure it (takes several minutes)
apt update || dpkg --configure -a

# installing dependencies 
apt install python python3-pip git libnotify-bin

# cloning module's git repository
git clone https://github.com/wranidlo/broadcast_sender_receiver /etc/virt-lab/vm-comm
chmod -R 777 /etc/virt-lab/vm-comm/
cd /etc/virt-lab/vm-comm

# installing python dependencies
pip install pyqt5 -r requirements.txt

# launching text-chat receiver
nohup python3 student_main.py &