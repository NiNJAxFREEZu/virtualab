#!/bin/bash
# This script completes the professor's .virtualabinfo and launches the second part of MPI configuration

echo -ne "\tFinalizing virtualab cluster configuration..."
cd /home/vagrant/data

# Gathering student's ip addresses for .virtualabinfo
/home/vagrant/data/./fill-virtualabinfo.sh /home/vagrant/.virtualabinfo

# MPI
./mpi_prof_part2.sh || exit 1

echo " DONE"