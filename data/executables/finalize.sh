#!/bin/bash
# This script completes the professor's .virtualabinfo and launches the second part of MPI configuration

echo -ne "\tFinalizing virtualab cluster configuration...\t"
cd /home/vagrant/data/executables

# Gathering student's ip addresses for .virtualabinfo
./fill-virtualabinfo.sh /home/vagrant/.virtualabinfo

# MPI
sudo ./mpi_prof_part2.sh || exit 1

echo " DONE"
