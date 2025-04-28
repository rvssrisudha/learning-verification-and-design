// -------------------------------
// cpu_matrix_multiplication.c
// -------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 16

int main() {
    int A[N][N], B[N][N], C[N][N];
    clock_t start, end;

    // Initialize matrices
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i][j] = rand() % 10;
            B[i][j] = rand() % 10;
            C[i][j] = 0;
        }
    }

    start = clock();

    // Matrix multiplication
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    end = clock();

    double time_taken = ((double)(end - start)) / CLOCKS_PER_SEC;
    printf("CPU Matrix Multiplication completed in %f seconds\n", time_taken);

    return 0;
}
