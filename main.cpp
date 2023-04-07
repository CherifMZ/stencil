#include <stdio.h>
#include <stdlib.h>

#include "include/stencil_kernel.cuh"

#define MIN 0 
#define MAX 1000

void initialize_matrices(float * a, float * b, int N);

int main(int argc, char **argv) {
    int N  = 256;
    float * hA = (float *)malloc(N * N * N * sizeof(float));
    float * hB = (float *)malloc(N * N * N * sizeof(float));

    initialize_matrices(hA, hB, N);
    stencil(hA, hB, N);

    for (int i = 0; i < N * N * N; i++)
    {
        printf("%f ", hB[i]);
    }
    
    return 0;
}

void initialize_matrices(float * hA, float * hB, int N) {
    for (int i = 0; i < N * N * N; i ++) {
        hA[i] = 0.0;
        hB[i] = MIN + (MAX - MIN) * (rand() / (float)RAND_MAX);
    }
}