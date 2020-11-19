#!/bin/sh

# Functions declaraction
echoerr() { echo "$@" 1>&2; }

# THIS SCRIPT HAS TO BE EXECUTED BY ROOT.
# Script installs all of virt-lab modules

echo "Installing vmlab"
echo "----------------"

if [ $(whoami) != root ]; then
    echoerr "This script has to be executed by root. Use su or sudo to run that script."
    exit 1
fi

# Ubuntu auto-updates has to be disabled in order to guarantee a successfull installation
# Make sure to not run any updates in the background as this script uses apt package manager

# Installing curl and git
apt-get install curl git --yes > /dev/null || echoerr "Error while trying to install a package - apt package manager is currently being used by another process."

# Creating directory for storing modules data
mkdir /etc/virt-lab

# Downloading install scripts
echo -n "Pulling modules installation scripts..."
curl -LO https://raw.githubusercontent.com/NiNJAxFREEZu/inz-scripts/main/virt-lab-modules/vm-communicator.sh
echo " DONE"

# Installing modules
echo "Installing modules"
echo "------------------"

echo -n "Installing vm-communicator..."
chmod +x vm-communicator.sh
./vm-communicator.sh
echo " DONE"

# Cleaning up, removing dowloaded scripts
echo -n "Cleaning up..."
rm vm-communicator.sh
echo " DONE"

echo "vmlab has been installed succesfully!"
exit 0