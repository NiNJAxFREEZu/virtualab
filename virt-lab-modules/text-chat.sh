#!/bin/sh

# removing dpkg-locks for apt-get in case Ubuntu autoupdates at the moment.
rm /var/lib/dpkg/lock*

# if by very unfortunate chance DPKG vas running while removing the lock, we have to autoconfigure it (takes several minutes)
apt update || dpkg --configure -a

# installing dependencies 
# TODO - one script to install all modules dependencies
apt install python git libnotify-bin

# creating directory for storing text chat app data
# TODO - creating that directory in one script that installs all dependencies
mkdir $HOME/.virt-lab-modules
git clone https://github.com/wranidlo/broadcast_sender_receiver $HOME/.virt-lab-modules

# launching text-chat receiver
cd $HOME/.virt-lab-modules
nohup python3 student_main.py &