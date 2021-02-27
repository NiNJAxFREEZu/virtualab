#!/bin/bash
# Script configures all of VirtuaLab modules and launches them.
# Apt auto-updates have to be disabled in order to guarantee a successfull installation
# Make sure to not run any updates in the background as this script uses apt package manager

clear
echo -e "██╗░░░██╗██╗██████╗░████████╗██╗░░░██╗░█████╗░██╗░░░░░░█████╗░██████╗░
██║░░░██║██║██╔══██╗╚══██╔══╝██║░░░██║██╔══██╗██║░░░░░██╔══██╗██╔══██╗
╚██╗░██╔╝██║██████╔╝░░░██║░░░██║░░░██║███████║██║░░░░░███████║██████╦╝
░╚████╔╝░██║██╔══██╗░░░██║░░░██║░░░██║██╔══██║██║░░░░░██╔══██║██╔══██╗
░░╚██╔╝░░██║██║░░██║░░░██║░░░╚██████╔╝██║░░██║███████╗██║░░██║██████╦╝
░░░╚═╝░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░\n\n***Installing VirtuaLab***\n"

# Declaring variables
HOME=/home/vagrant/
DATA=/home/vagrant/data

DE=$DATA/desktop
EXECUTABLES=$DATA/executables
INFO=$DATA/virtualabinfo
ADDR=$DATA/ipaddress

NETINTERFACE=enp0s3


### Strarting configuration------------
echo -ne "\tPreparing to install VirtuaLab..."
cd $DATA

rm /etc/lightdm/lightdm.conf.d/vagrant-autologin.conf                         # Deleting autologin file
kill -9 $(ps -dN | grep Xorg | awk '{print $1}')                              # Logging out vagrant user
cp $INFO/$(hostname) $HOME/.virtualabinfo                                     # Copying .virtualabinfo stem
ifconfig $NETINTERFACE | grep 'inet ' | awk '{print $2}' > $ADDR/$(hostname)  # Saving connection info

# Getting other user's connection info
if [ $1 = 'student' ]
then
  $EXECUTABLES/./fill-virtualabinfo.sh $HOME/.virtualabinfo
fi

# Creating directory for storing modules data
mkdir /etc/virtualab > /dev/null 
echo " DONE"
###------------------------------------


### Installing modules-----------------
echo -e "\n***Configuring modules***\n"

# RDP server
echo -ne "\tConfiguring RDP server..."
$EXECUTABLES/./rdp.sh || exit 1
echo " DONE"

# VM-communicator
echo -ne "\tConfiguring VM communicator..."
$EXECUTABLES/./vm-communicator.sh || exit 1

# Adding a desktop entry for XFCE autostart
mkdir $HOME/.config/autostart
cp $DE/vm-communicator.desktop  $HOME/.config/autostart/

# Activity-monitor
if [ $1 = 'student' ]
then
  cp $DE/activity-monitor.desktop $HOME/.config/autostart/
fi

echo " DONE"
###------------------------------------


### OpenMPI module---------------------
echo -ne "\tConfiguring MPICH environment..."
mkdir

if [ $1 = 'student' ]
then
  $EXECUTABLES/./mpi_student.sh || exit 1
elif [ $1 = 'professor' ]
then
  $EXECUTABLES/./mpi_prof_part1.sh || exit 1
fi

echo " DONE"
###------------------------------------


### Adding shortcuts to XFCE Desktop---
echo -ne "\tCreating desktop shortcuts..."
cp $DE/text-chat.desktop $HOME/Desktop/

if [ $1 = 'professor' ]
then
  cp $DE/professors-panel.desktop $HOME/Desktop/
  cp $DE/mpiexec.desktop $HOME/Desktop/
fi
echo " DONE"
###------------------------------------


echo -e "\nVirtuaLab has been configured succesfully for $1 $hostname!"
exit 0