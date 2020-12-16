#!/bin/bash
# Script installs all of VirtuaLab modules and launches them.

# Apt auto-updates have to be disabled in order to guarantee a successfull installation
# Make sure to not run any updates in the background as this script uses apt package manager

if [ $1 != 'professor' or $1 != 'student' ];
then
    echo "Missing argument #1 - [professor] or [student]."
    exit 1
fi

clear
echo -e "██╗░░░██╗██╗██████╗░████████╗██╗░░░██╗░█████╗░██╗░░░░░░█████╗░██████╗░
██║░░░██║██║██╔══██╗╚══██╔══╝██║░░░██║██╔══██╗██║░░░░░██╔══██╗██╔══██╗
╚██╗░██╔╝██║██████╔╝░░░██║░░░██║░░░██║███████║██║░░░░░███████║██████╦╝
░╚████╔╝░██║██╔══██╗░░░██║░░░██║░░░██║██╔══██║██║░░░░░██╔══██║██╔══██╗
░░╚██╔╝░░██║██║░░██║░░░██║░░░╚██████╔╝██║░░██║███████╗██║░░██║██████╦╝
░░░╚═╝░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░\n\n***Installing VirtuaLab***\n"

# Updating the apt-get repository list
echo -ne "\tUpdating apt-get repositories..."
sudo apt-get update --yes > /dev/null || exit 1
echo " DONE"

# Installing curl and git - needed to pull the rest of the dependencies and modules
echo -ne "\tInstalling curl and git..."
sudo apt-get install curl git --yes > /dev/null || exit 1
echo " DONE"

# Creating directory for storing modules data
sudo mkdir /etc/virtualab > /dev/null

# Downloading install scripts
echo -ne "\tPulling modules installation scripts..."
curl -LOs https://raw.githubusercontent.com/NiNJAxFREEZu/inz-scripts/main/virt-lab-modules/vm-communicator.sh || exit 1
curl -LOs https://raw.githubusercontent.com/NiNJAxFREEZu/inz-scripts/main/virt-lab-modules/openmpi.sh || exit 1
echo " DONE"

### Installing modules
echo -e "\n***Installing modules***\n"

# VM-communicator
echo -ne "\tInstalling VM communicator..."
chmod +x vm-communicator.sh
./vm-communicator.sh || exit 1
echo " DONE"

# OpenMPI module
echo -ne "\tInstalling OpenMPI..."
chmod +x openmpi.sh
# ./openmpi.sh || exit 1 
echo " DONE"

# Activity-monitor

### Cleaning up, removing dowloaded scripts
echo -ne "\tCleaning up..."
rm vm-communicator.sh
rm openmpi.sh
echo " DONE"

echo -e "\nVirtuaLab has been installed succesfully!"
exit 0