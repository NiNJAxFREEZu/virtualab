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
su mpiuser -c "ssh-keygen -f /mirror/.ssh/id_rsa -t rsa rsa -N ''"
su -c "cat /mirror/.ssh/id_rsa.pub >> /mirror/.ssh/authorized_keys"

echo "*** KEY COPIED TO SHARED DIR ***\t"

%$$%$%$%------------------------- TUTAJ MUSZĄ SIĘ PODŁĄCZYĆ WSZYSCY KLIENCI
te kurwa bo mogę tutaj wrzucić plik z klażdego klioenta z nazwą kompa XDDDDDDD
###TU MUSZĘ SIĘ ZALOGOWAĆ NA KAŻDEGO KLIENTA PRZEZ SSH ŻEBY OMINĄĆ PROMPTY PRZY MPI
#w pliku machinefile wpisuję klientów i ich capacity, to można teoretycznie ominąć, jeśli mają być zmienne, ale dla stabilności lepiej nie
cd ~
touch machinefile
cat "master:2 \n client:2" >> machinefile

#programik
cd mirror
cat "#include <stdio.h>
#include <mpi.h>

int main(int argc, char** argv) {
    int myrank, nprocs;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myrank);

    printf("Hello from processor %d of %d\n", myrank, nprocs);

    MPI_Finalize();
    return 0;
}" >> mpi_hello.c

#lecimy z koksem
mpicc mpi_hello.c -o mpi_hello
mpiexec -n 4 -f machinefile ./mpi_hello

####### on each client #######
sudo apt install mpich
sudo apt install nfs-client
sudo apt install openssh-server
sudo apt install ssh_askpass
sudo apt install hydra

## ip interfejsów
sudo ifconfig enp0s8 192.168.1.6 netmask 255.255.255.0 up

#w ~home robię /mirror, folder share'owany przez nfs
cd ~
sudo mkdir /mirror

#montuję na mastera -> tu musi być już serwer nfs postawiony przez mastera
## to
echo "master:/mirror /mirror nfs" | sudo tee -a /etc/fstab
sudo mount -a
## albo to, ale za każdym razem przy starcie:
sudo mount master:/mirror /mirror
##

#stwarzam usera z homedir w /mirror, żeby nie musieć klucza ssh przerzucać z clientów na mastera
sudo useradd --home /mirror mpiuser
sudo passwd mpiuser -a

sudo chown mpiuser /mirror

++++ hostname clientów na masterze w /etc/hosts
++++ hostname mastera na clientach w /etc/hosts
++++ ssh każdy do każdego (żeby prompta nie było przy mpi)
