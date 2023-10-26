#include <stdio.h>
#include <sys/time.h>
#include <omp.h>
#include <stdlib.h>
#include <vector>
#include <iostream>
#include <fstream> // Include the necessary header for file handling

using namespace std;

int main()
{
    // Create and open a log file
    ofstream logFile("matrix_multiplication_log.txt");

    // Variables to store time values
    struct timeval TimeValue_Start;
    struct timezone TimeZone_Start;
    struct timeval TimeValue_Final;
    struct timezone TimeZone_Final;
    long time_start, time_end;
    double serial_time_overhead, parallel_time_overhead;

    //     a) Analyze the result for increasing the size of the matrix N xN where
    // N=2,3,4,5,6,7,8,9,10…. [increase size of N until parallel execution time is
    // less than sequential execution.

    // benchmarking with varying matrix size
    int thread_count = 1;
    int max_threads = omp_get_max_threads();
    while (thread_count < max_threads)
    {
        omp_set_num_threads(thread_count);
        cout << "Thread count = " << thread_count << endl;
        int N = 2;

        while (true)
        {
            cout << "N = " << N << endl;

            vector<vector<int>> A(N, vector<int>(N));

            // Initialize matrices A with random values
            for (int i = 0; i < N; i++)
            {
                A[i][i] = rand() % 100;
            }

            // Serial execution
            gettimeofday(&TimeValue_Start, &TimeZone_Start);
            // matrix multiplication
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    int sum = 0;
                    for (int k = 0; k < N; k++)
                    {
                        sum += A[i][k] * A[k][j];
                    }
                }
            }
            gettimeofday(&TimeValue_Final, &TimeZone_Final);
            time_start = TimeValue_Start.tv_sec * 1000000 + TimeValue_Start.tv_usec;
            time_end = TimeValue_Final.tv_sec * 1000000 + TimeValue_Final.tv_usec;
            serial_time_overhead = (time_end - time_start) / 1000000.0;
            printf("-\t Serial : %lf\n", serial_time_overhead);

            // Parallel execution
            gettimeofday(&TimeValue_Start, &TimeZone_Start);
#pragma omp parallel for
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    int sum = 0;
                    for (int k = 0; k < N; k++)
                    {
                        sum += A[i][k] * A[k][j];
                    }
                }
            }
            gettimeofday(&TimeValue_Final, &TimeZone_Final);
            time_start = TimeValue_Start.tv_sec * 1000000 + TimeValue_Start.tv_usec;
            time_end = TimeValue_Final.tv_sec * 1000000 + TimeValue_Final.tv_usec;
            parallel_time_overhead = (time_end - time_start) / 1000000.0;
            printf("\t Parallel : %lf\n", parallel_time_overhead);

            // Log the results to the file
            logFile << "Thread Count: " << thread_count << ", Matrix Size N: " << N << ", Serial Time: " << serial_time_overhead << ", Parallel Time: " << parallel_time_overhead << endl;

            if (parallel_time_overhead < serial_time_overhead)
            {
                break;
            }
            N++;
        }

        thread_count++;
    }

    // Close the log file
    logFile.close();

    return 0;
}
