#include <iostream>
#include <mpi.h>

// Function for binary exponentiation
long long binaryExponentiation(long long base, long long exponent, long long mod)
{
    long long result = 1;

    while (exponent > 0)
    {
        if (exponent % 2 == 1)
            result = (result * base) % mod;

        base = (base * base) % mod;
        exponent /= 2;
    }

    return result;
}

int main(int argc, char **argv)
{
    int rank, nprocs;
    long long base = 3, exponent = 4000, mod = 1000000; // Example values
    long long result = 0, local_result = 1;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);

    // Split the exponent range among processes
    long long local_exponent = exponent / nprocs;
    long long start_exponent = rank * local_exponent;
    long long end_exponent = (rank == nprocs - 1) ? exponent : start_exponent + local_exponent - 1;

    // Perform binary exponentiation locally
    local_result = binaryExponentiation(base, local_exponent, mod);

    // Multiply local results using MPI_Allreduce
    MPI_Allreduce(&local_result, &result, 1, MPI_LONG_LONG, MPI_PROD, MPI_COMM_WORLD);

    if (rank == 0)
    {
        // Process 0 prints the final result
        std::cout << "Result: " << result << std::endl;
    }

    MPI_Finalize();

    return 0;
}
