#!/bin/sh

# THIS SCRIPT HAS TO BE EXECUTED BY THE TARGET HOME USER.
# Script installs all of virt-lab modules

if [ $(whoami) != root ]
then
    echo "This script has to be executed by root. Use su or sudo to run that script."
    exit 1
fi

# TODO disable Ubuntu autoupdates!!!

# Installing curl
apt install curl

# Setting the enviromental variables for installing modules as root
# VIRT-LAB-HOME = 

# Downloading install scripts
curl -LO https://raw.githubusercontent.com/NiNJAxFREEZu/inz-scripts/main/virt-lab-modules/vm-communicator.sh

# Installing modules
./vm-communicator