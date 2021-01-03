#!/bin/bash
# Script installs all of VirtuaLab modules and launches them.

# Apt auto-updates have to be disabled in order to guarantee a successfull installation
# Make sure to not run any updates in the background as this script uses apt package manager

if [ $1 != 'professor' or $1 != 'student' ]
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

### Installing modules
echo -e "\n***Installing modules***\n"
cd /home/vagrant/data

# VM-communicator
echo -ne "\tInstalling VM communicator..."
chmod +x vm-communicator.sh
./vm-communicator.sh || exit 1

# Adding a desktop entry for XFCE autostart
mkdir /home/vagrant/.config/autostart
cp /home/vagrant/data/vm-communicator.desktop /home/vagrant/.config/autostart/
echo " DONE"

# Activity-monitor
if [ $1 = 'student' ]
then
  echo -ne "\tInstalling activity monitor..."
  cp /home/vagrant/data/activity-monitor.desktop /home/vagrant/.config/autostart/
  echo " DONE"
fi

# OpenMPI module
echo -ne "\tInstalling OpenMPI..."
chmod +x openmpi.sh
# ./openmpi.sh || exit 1
echo " DONE"

# Cleaning up...
sudo umount /home/vagrant/data

echo -e "\nVirtuaLab has been installed succesfully!"
exit 0