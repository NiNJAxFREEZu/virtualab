#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>
#include <unistd.h>
#include <limits.h>

int main(int argc, char** argv) {
    int myrank, nprocs;
    char hostname[HOST_NAME_MAX + 1];

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myrank);

    gethostname(hostname, HOST_NAME_MAX + 1);
    printf("Hello from processor %d of %d (node: %sn)\n", myrank, nprocs, hostname);

    MPI_Finalize();
    return 0;
}
