#!/bin/sh

# Functions declaraction
echoerr() { echo "$@" 1>&2; }

# THIS SCRIPT HAS TO BE EXECUTED BY ROOT.
# Script installs all of virt-lab modules

if [ $(whoami) != root ]; then
    echoerr "This script has to be executed by root. Use su or sudo to run that script."
    exit 1
fi

# Ubuntu auto-updates has to be disabled in order to guarantee a successfull installation
# Make sure to not run any updates in the background as this script uses apt package manager

# Installing curl
apt install curl || echoerr "Error while trying to install a package - apt package manager is currently being used by another process."

# Creating directory for storing modules data
mkdir /etc/virt-lab

# Downloading install scripts
curl -LO https://raw.githubusercontent.com/NiNJAxFREEZu/inz-scripts/main/virt-lab-modules/vm-communicator.sh

# Installing modules
./vm-communicator

# Cleaning up, removing dowloaded scripts
rm vm-communicator