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

# Declaring path variables
HOME=/home/vagrant/
DATA=/home/vagrant/data

DE=$DATA/desktop
EXECUTABLES=$DATA/executables
INFO=$DATA/virtualabinfo
ADDR=$DATA/ipaddress

echo -ne "\tPreparing to install VirtuaLab..."
cd $DATA

# Deleting autologin file
rm /etc/lightdm/lightdm.conf.d/vagrant-autologin.conf

# Logging out vagrant user
kill -9 $(ps -dN | grep Xorg | awk '{print $1}')

# Copying .virtualabinfo stem
cp $INFO/$(hostname) $HOME/.virtualabinfo

# Saving connection info
ifconfig eth1 | grep 'inet ' | awk '{print $2}' > $ADDR/$(hostname)

# Getting other user's connection info
if [ $1 = 'student' ]
then
  $EXECUTABLES/./fill-virtualabinfo.sh $HOME/.virtualabinfo
fi

# Updating the apt-get repository list
apt-get update --yes > /dev/null || exit 1

# Installing git - needed to pull the rest of the dependencies and modules
apt-get install git --yes > /dev/null || exit 1

# Creating directory for storing modules data
mkdir /etc/virtualab > /dev/null

echo " DONE"

### Installing modules
echo -e "\n***Installing modules***\n"

# RDP server
echo -ne "\tInstalling RDP server..."
$EXECUTABLES/./rdp.sh || exit 1
echo " DONE"

# VM-communicator
echo -ne "\tInstalling VM communicator..."
$EXECUTABLES/./vm-communicator.sh || exit 1

# Adding a desktop entry for XFCE autostart
mkdir $HOME/.config/autostart
cp $DE/vm-communicator.desktop  $HOME/.config/autostart/

# Activity-monitor
if [ $1 = 'student' ]
then
  cp $DE/activity-monitor.desktop $HOME/.config/autostart/
fi

# Adding shortcuts to XFCE Desktop
mkdir $HOME/.local/share/applications
cp $DE/text-chat.desktop $HOME/Desktop/

if [ $1 = 'professor' ]
then
  cp $DE/professors-panel.desktop $HOME/Desktop/
  cp $DE/mpiexec.desktop $HOME/Desktop/
fi

echo " DONE"

# OpenMPI module
echo -ne "\tInstalling MPI..."
mkdir

if [ $1 = 'student' ]
then
  $EXECUTABLES/./mpi_student.sh || exit 1
elif [ $1 = 'professor' ]
then
  $EXECUTABLES/./mpi_prof_part1.sh || exit 1
fi
echo " DONE"

echo -e "\nVirtuaLab has been installed succesfully!"
exit 0