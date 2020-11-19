#!/bin/bash

# Functions declaraction
echoerr() { echo "$@" 1>&2; }

# Script installs all of VirtuaLab modules and launches them.

# THIS SCRIPT HAS TO BE EXECUTED BY ROOT.
# Ubuntu auto-updates has to be disabled in order to guarantee a successfull installation
# Make sure to not run any updates in the background as this script uses apt package manager

if [ $(whoami) != root ]; then
    echoerr "This script has to be executed by root. Use su or sudo to run that script."
    exit 1
fi

clear
echo -e "██╗░░░██╗██╗██████╗░████████╗██╗░░░██╗░█████╗░██╗░░░░░░█████╗░██████╗░
██║░░░██║██║██╔══██╗╚══██╔══╝██║░░░██║██╔══██╗██║░░░░░██╔══██╗██╔══██╗
╚██╗░██╔╝██║██████╔╝░░░██║░░░██║░░░██║███████║██║░░░░░███████║██████╦╝
░╚████╔╝░██║██╔══██╗░░░██║░░░██║░░░██║██╔══██║██║░░░░░██╔══██║██╔══██╗
░░╚██╔╝░░██║██║░░██║░░░██║░░░╚██████╔╝██║░░██║███████╗██║░░██║██████╦╝
░░░╚═╝░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░\n\n***Installing VirtuaLab***\n"

# Installing curl and git - needed to pull the rest of the dependencies and modules
echo -ne "\tInstalling curl and git..."
apt-get install curl git --yes > /dev/null || echoerr "E: Error while trying to install a package - apt package manager is currently being used by another process."
echo " DONE"

# Creating directory for storing modules data
mkdir /etc/virtualab

# Downloading install scripts
echo -ne "\tPulling modules installation scripts..."
curl -LOs https://raw.githubusercontent.com/NiNJAxFREEZu/inz-scripts/main/virt-lab-modules/vm-communicator.sh || echoerr "E: Error while trying to pull vm-communicator installation script."
curl -LOs https://raw.githubusercontent.com/NiNJAxFREEZu/inz-scripts/main/virt-lab-modules/openmpi.sh || echoerr "E: Error while trying to pull OpenMPI installation script."
echo " DONE"

### Installing modules
echo -e "\n***Installing modules***\n"

# VM-communicator
echo -ne "\tInstalling VM communicator..."
chmod +x vm-communicator.sh
./vm-communicator.sh
echo " DONE"

# OpenMPI module
echo -ne "\tInstalling OpenMPI..."
chmod +x openmpi.sh
# ./openmpi.sh TODO Piter
echo " DONE"

### Cleaning up, removing dowloaded scripts
echo -ne "\tCleaning up..."
rm vm-communicator.sh
rm openmpi.sh
echo " DONE"

echo -e "\nVirtuaLab has been installed succesfully!"
exit 0