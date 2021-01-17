#!/bin/bash

# $1 - input file (in C)
# $2 - output file
# $3 - number of processors to be used

su mpiuser -c "touch $2"
su mpiuser -c "mpicc $1 -o $2"
su mpiuser -c "mpiexec -n $3 -f machinefile ./$2"
