// -------------------------------
// gpu_matrix_multiplication.cu
// -------------------------------
#include <stdio.h>
#include <cuda.h>

#define N 16

__global__ void matrixMulKernel(int *A, int *B, int *C) {
    int row = threadIdx.y;
    int col = threadIdx.x;
    int sum = 0;

    for (int k = 0; k < N; ++k) {
        sum += A[row * N + k] * B[k * N + col];
    }
    C[row * N + col] = sum;
}

int main() {
    int A[N*N], B[N*N], C[N*N];
    int *d_A, *d_B, *d_C;

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    for (int i = 0; i < N*N; i++) {
        A[i] = rand() % 10;
        B[i] = rand() % 10;
    }

    cudaMalloc(&d_A, N*N*sizeof(int));
    cudaMalloc(&d_B, N*N*sizeof(int));
    cudaMalloc(&d_C, N*N*sizeof(int));

    cudaMemcpy(d_A, A, N*N*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, N*N*sizeof(int), cudaMemcpyHostToDevice);

    dim3 threadsPerBlock(N, N);

    cudaEventRecord(start);

    matrixMulKernel<<<1, threadsPerBlock>>>(d_A, d_B, d_C);

    cudaEventRecord(stop);

    cudaMemcpy(C, d_C, N*N*sizeof(int), cudaMemcpyDeviceToHost);

    cudaEventSynchronize(stop);
    float milliseconds = 0;
    cudaEventElapsedTime(&milliseconds, start, stop);

    printf("GPU Matrix Multiplication completed in %f milliseconds\n", milliseconds);

    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);

    return 0;
}
