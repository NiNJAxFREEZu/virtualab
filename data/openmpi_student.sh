#!/bin/bash
#on client --LAN Interface --IP (new) --netmask
sudo apt install mpich --yes
sudo apt install nfs-client --yes
sudo apt install openssh-server --yes
sudo apt install ssh_askpass --yes
sudo apt install hydra --yes

#ip interfejsow do wpisania /etc/hosts do wpisania przy przejsciu na vagranta

sudo echo "192.168.101.2	master" >> /etc/hosts

#w ~home robię /mirror, folder share'owany przez nfs
cd ~
sudo mkdir /mirror

sudo mount master:/mirror /mirror

#stwarzam usera z homedir w /mirror, żeby nie musieć klucza ssh przerzucać z clientów na mastera
sudo useradd --home /mirror mpiuser
echo "mpiuser:a" | sudo chpasswd
