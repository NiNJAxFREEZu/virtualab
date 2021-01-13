#!/bin/bash

# on master --LAN Interface --IP (new) --netmask

sudo apt-get install mpich nfs-server openssh-server ssh-askpass hydra --yes
echo "*** Installing done ***\t"

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

