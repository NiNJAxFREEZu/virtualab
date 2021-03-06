#!/bin/bash

touch /home/vagrant/data/machinefile
sudo /home/vagrant/data/executables/mpi_prof_part2.py
number_of_procs=$?
#programik
sudo cp /home/vagrant/data/executables/mpi_hello.c /mirror/mpi_hello.c || exit 1
sudo cp /home/vagrant/data/machinefile /mirror/machinefile || exit 1
sudo cp /home/vagrant/data/executables/executempi.sh /mirror/executempi.sh || exit 1
sudo cp /home/vagrant/data/executables/executempiwrapper.sh /mirror/executempiwrapper.sh || exit 1

cd /mirror || exit 1
sudo chmod +x *.sh
echo "**** MPI CAN NOW BE USED ****"
echo "**** USE executempi.sh or shortcut on desktop to run mpi programms ****"
echo "**** AT LEAST $number_of_procs PROCESSORS ARE AVAILABLE ****"

echo "**** RUNNING EXAMPLE PROGRAM ****"
sudo ./executempi.sh mpi_hello.c mpi_hello $number_of_procs
