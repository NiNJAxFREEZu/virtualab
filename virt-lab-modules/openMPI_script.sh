sudo apt-get install gcc
sudo apt-get install mpich
sudo apt install make
sudo apt install lam-runtime

sudo wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.5.tar.gz
sudo gunzip -c openmpi-4.0.5.tar.gz | tar xf -
cd openmpi-4.0.5
./configure --prefix=/usr/local
sudo make all install


echo "#include <mpi.h>
#include <iostream>

int main(int argc, char* argv[])
{
  MPI_Init(&argc, &argv);

  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  if (rank == 0) {
    int value = 17;
    int result = MPI_Send(&value, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);
    if (result == MPI_SUCCESS)
      std::cout << "Rank 0 OK!" << std::endl;
  } else if (rank == 1) {
    int value;
    int result = MPI_Recv(&value, 1, MPI_INT, 0, 0, MPI_COMM_WORLD,
			  MPI_STATUS_IGNORE);
    if (result == MPI_SUCCESS && value == 17)
      std::cout << "Rank 1 OK!" << std::endl;
  }
  MPI_Finalize();
  return 0;
}" > mpi-test.cpp

mpiCC -o mpi-test mpi-test.cpp
lamboot
mpirun -np 2 ./mpi-test
lamhalt


