// -------------------------------
// cpu_gpu_comparison.cpp
// -------------------------------
#include <iostream>
#include <chrono>
#include <vector>
#include <cstdlib>

#define N 16

using namespace std;
using namespace chrono;

void cpu_matrix_mult(vector<vector<int>>& A, vector<vector<int>>& B, vector<vector<int>>& C) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            C[i][j] = 0;
            for (int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

int main() {
    vector<vector<int>> A(N, vector<int>(N));
    vector<vector<int>> B(N, vector<int>(N));
    vector<vector<int>> C(N, vector<int>(N));

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i][j] = rand() % 10;
            B[i][j] = rand() % 10;
        }
    }

    auto start = high_resolution_clock::now();
    cpu_matrix_mult(A, B, C);
    auto stop = high_resolution_clock::now();

    auto duration = duration_cast<microseconds>(stop - start);
    cout << "CPU Matrix Multiplication Time: " << duration.count() << " microseconds" << endl;

    cout << "(GPU comparison would be run separately using CUDA)" << endl;

    return 0;
}
