#!/bin/bash
# Script installs all of VirtuaLab modules and launches them.
# Apt auto-updates have to be disabled in order to guarantee a successfull installation
# Make sure to not run any updates in the background as this script uses apt package manager

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

# .virtualabinfo
echo -ne "\tCopying .virtualabinfo..."
cp /home/vagrant/data/$(hostname) /home/vagrant/.virtualabinfo
echo " DONE"

# VM-communicator
echo -ne "\tInstalling VM communicator..."
./vm-communicator.sh || exit 1

# Adding a desktop entry for XFCE autostart
mkdir /home/vagrant/.config/autostart
cp /home/vagrant/data/vm-communicator.desktop /home/vagrant/.config/autostart/
echo " DONE"

# Activity-monitor
if [ $1 = 'student' ]
then
  cp /home/vagrant/data/activity-monitor.desktop /home/vagrant/.config/autostart/
fi

# Adding shortcuts to XFCE Desktop
mkdir /home/vagrant/.local/share/applications
cp /home/vagrant/data/mpiexec.desktop /home/vagrant/Desktop/
cp /home/vagrant/data/text-chat.desktop /home/vagrant/Desktop/

if [ $1 = 'professor' ]
then
  cp /home/vagrant/data/professors-panel.desktop /home/vagrant/Desktop/
fi

# OpenMPI module
echo -ne "\tInstalling OpenMPI..."
if [ $1 = 'student' ]
then
  ./openmpi_student.sh || exit 1
elif [ $1 = 'professor' ]
then
  ./openmpi_prof_part1.sh || exit 1
fi
echo " DONE"

# Cleaning up...
rm /home/vagrant/data/$(hostname)

echo -e "\nVirtuaLab has been installed succesfully!"
exit 0