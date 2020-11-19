#!/bin/sh

# Functions declaraction
echoerr() { echo "$@" 1>&2; }

# Script installs all of virt-lab modules and launches them.

# THIS SCRIPT HAS TO BE EXECUTED BY ROOT.
# Ubuntu auto-updates has to be disabled in order to guarantee a successfull installation
# Make sure to not run any updates in the background as this script uses apt package manager

if [ $(whoami) != root ]; then
    echoerr "This script has to be executed by root. Use su or sudo to run that script."
    exit 1
fi

echo -e "\n***Installing vmlab***\n"

# Installing curl and git - needed to pull the rest of the dependencies and modules
echo -n "Installing curl and git..."
apt-get install curl git --yes > /dev/null || echoerr "Error while trying to install a package - apt package manager is currently being used by another process."
echo " DONE"

# Creating directory for storing modules data
mkdir /etc/virt-lab

# Downloading install scripts
echo -ne "\tPulling modules installation scripts..."
curl -LOs https://raw.githubusercontent.com/NiNJAxFREEZu/inz-scripts/main/virt-lab-modules/vm-communicator.sh || echoerr "Error while trying to pull vm-communicator installation script."
echo " DONE"

### Installing modules
echo -e "\n***Installing modules***\n"

# VM-communicator
echo -ne "\tInstalling vm-communicator..."
chmod +x vm-communicator.sh
./vm-communicator.sh
echo " DONE"

### Cleaning up, removing dowloaded scripts
echo -ne "\tCleaning up..."
rm vm-communicator.sh
echo " DONE"

echo -e "\nvmlab has been installed succesfully!"
exit 0