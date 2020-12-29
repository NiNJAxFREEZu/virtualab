#!/bin/bash
#on client --LAN Interface --IP (new) --netmask
sudo apt install mpich --yes
sudo apt install nfs-client --yes
sudo apt install openssh-server --yes
sudo apt install ssh_askpass --yes
sudo apt install hydra --yes

#ip interfejsow i /etc/hosts do usuniecia przy przejsciu na vagranta
# ip interfejsów
sudo ifconfig $1 $2 netmask $3 up

echo "*** IP SET TO $2 AND NETMASK TO $3 ***\t"

sudo echo "192.168.1.5	master" >> /etc/hosts

#w ~home robię /mirror, folder share'owany przez nfs
cd ~
sudo mkdir /mirror

sudo mount master:/mirror /mirror

#stwarzam usera z homedir w /mirror, żeby nie musieć klucza ssh przerzucać z clientów na mastera
sudo useradd --home /mirror mpiuser
echo "mpiuser:a" | sudo chpasswd

sudo chown mpiuser /mirror
