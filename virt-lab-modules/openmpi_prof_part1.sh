#!/bin/bash

# on master --LAN Interface --IP (new) --netmask

sudo apt install mpich --yes
sudo apt install nfs-server --yes
sudo apt install openssh-server --yes
sudo apt install ssh_askpass --yes
sudo apt install hydra --yes

echo "*** Installing done ***\t"

# ip interfejsów
sudo ifconfig $1 $2 netmask $3 up

echo "*** IP SET TO $2 AND NETMASK TO $3 ***\t"

#tworzę /mirror w ~home, wystawiam jako mount point przez nfs dla wszystkich
cd ~
sudo mkdir /mirror
echo "mirror *(rw,sync)" | sudo tee -a /etc/exports
sudo service nfs-kernel-server restart

echo "*** NFS SERVER UP ***\t"

#stwarzam usera z homedir w /mirror, żeby nie musieć klucza ssh przerzucać z clientów na mastera
sudo useradd --home /mirror mpiuser
echo "mpiuser:a" | sudo chpasswd

sudo chown mpiuser /mirror

echo "*** MPI USER MADE ***\t"

#stwarzam klucz ssh żeby nie musieć wpisywać hasła do logowania przez ssh z mastera (KLUCZOWE dla MPI)
su mpiuser -c "ssh-keygen -f /mirror/.ssh/id_rsa -t rsa -N ''"
su -c "cat /mirror/.ssh/id_rsa.pub >> /mirror/.ssh/authorized_keys"

