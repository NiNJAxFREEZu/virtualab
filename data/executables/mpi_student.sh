#!/bin/bash
#on client --LAN Interface --IP (new) --netmask
sudo apt-get install mpich nfs-client openssh-server ssh-askpass hydra --yes

#ip interfejsow do wpisania /etc/hosts do wpisania przy przejsciu na vagranta
sudo /home/vagrant/data/executables/add_to_hosts_student.py
#w ~home robię /mirror, folder share'owany przez nfs
cd ~
sudo mkdir /mirror

sudo mount master:/mirror /mirror

#stwarzam usera z homedir w /mirror, żeby nie musieć klucza ssh przerzucać z clientów na mastera
sudo useradd --home /mirror mpiuser
echo "mpiuser:a" | sudo chpasswd
