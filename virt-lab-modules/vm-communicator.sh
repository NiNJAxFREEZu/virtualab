#!/bin/sh

# Script installs communication module used to send text messages across VM's, 
# checking attendance and collecting information about students activities on VM's.

# removing dpkg-locks for apt-get in case Ubuntu autoupdates at the moment.
rm /var/lib/dpkg/lock*

# if by very unfortunate chance DPKG vas running while removing the lock, we have to autoconfigure it (takes several minutes)
apt update || dpkg --configure -a

# installing dependencies 
# TODO - one script to install all modules dependencies
apt install python python3-pip git libnotify-bin

# installing python dependencies

# creating directory for storing text chat app data
# TODO - creating that directory in one script that installs all dependencies
mkdir $HOME/.virt-lab-modules
git clone https://github.com/wranidlo/broadcast_sender_receiver $HOME/.virt-lab-modules

# launching text-chat receiver
nohup python $HOME/.virt-lab-modules/student_main.py &