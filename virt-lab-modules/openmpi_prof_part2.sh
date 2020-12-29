#!/bin/bash

#parametry do ogarniecia

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
