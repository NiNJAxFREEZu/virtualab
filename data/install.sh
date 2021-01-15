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


# Deleting autologin file
echo -ne "\tDeleting autologin file..."
rm /etc/lightdm/lightdm.conf.d/vagrant-autologin.conf
echo " DONE"

# Logging out vagrant user
echo -ne "\tLogging out vagrant user..."
kill -9 $(ps -dN | grep Xorg | awk '{print $1}')
echo " DONE"

# .virtualabinfo stem
echo -ne "\tCopying .virtualabinfo..."
cp /home/vagrant/data/virtualabinfo/$(hostname) /home/vagrant/.virtualabinfo
echo " DONE"

# Saving connection info
echo -ne "\tSaving connection info..."
ifconfig eth1 | grep 'inet ' | awk '{print $2}' > /home/vagrant/data/ipaddress/$(hostname)
echo " DONE"

# Updating the apt-get repository list
echo -ne "\tUpdating apt-get repositories..."
apt-get update --yes > /dev/null || exit 1
echo " DONE"

# Installing curl and git - needed to pull the rest of the dependencies and modules
echo -ne "\tInstalling curl and git..."
apt-get install curl git --yes > /dev/null || exit 1
echo " DONE"

# Creating directory for storing modules data
mkdir /etc/virtualab > /dev/null

### Installing modules
echo -e "\n***Installing modules***\n"
cd /home/vagrant/data

# RDP server
echo -ne "\tInstalling RDP server..."
./rdp.sh || exit 1
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
  ./mpi_student.sh || exit 1
elif [ $1 = 'professor' ]
then
  ./mpi_prof_part1.sh || exit 1
fi
echo " DONE"

echo -e "\nVirtuaLab has been installed succesfully!"
exit 0