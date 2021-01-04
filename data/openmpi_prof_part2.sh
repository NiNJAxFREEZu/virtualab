#!/bin/bash

touch /home/vagrant/data/machinefile
sudo /home/vagrant/data/openmpi_prof_part2.py
number_of_procs=$?
#programik
sudo cp /home/vagrant/data/mpi_hello.c /mirror/mpi_hello.c || exit 1
sudo cp /home/vagrant/data/machinefile /mirror/machinefile || exit 1
sudo cp /home/vagrant/data/executempi.sh /mirror/executempi.sh || exit 1

cd /mirror || exit 1
#lecimy z koksem
sudo chmod +x executempi.sh
echo "**** MPI CAN NOW BE USED ****"
echo "**** USE executempi.sh to run mpi programms ****"
echo "**** RUNNING EXAMPLE PROGRAM ****"
echo "**** AT LEAST $number_of_procs PROCESSORS ARE AVAILABLE ****"
sudo ./executempi.sh mpi_hello.c mpi_hello $number_of_procs
