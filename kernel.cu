#include <stdio.h>

// Stencil kernel
__global__ void kernel(float *dA, float *dB, int N)
{
    size_t i = blockIdx.x * blockDim.x + threadIdx.x;
    size_t j = blockIdx.y * blockDim.y + threadIdx.y;
    size_t k = blockIdx.z * blockDim.z + threadIdx.z;

    if (i < N && j < N && k < N) {
        dA[i * N + j * N + k] = 0.8 * (dB[(i - 1) * N + j * N + k] + dB[(i + 1) * N + N * j + k] + dB[i * N + (j - 1) * N + k] + 
                                dB[i * N + (j + 1) * N + k] + dB[i * N + j * N + (k - 1)] + dB[i * N + j * N  + (k + 1)]);
    }
}

//Performing the stencil using its kernel
extern "C" void stencil(float *hA, float *hB, int N)
{
    float *dA; 
    float *dB; 

    cudaMalloc(&dA, sizeof(float) * N * N * N);
    cudaMalloc(&dB, sizeof(float) * N * N * N);

    cudaMemcpy(dA, hA, sizeof(float) * N * N * N, cudaMemcpyHostToDevice);
    cudaMemcpy(dB, hB, sizeof(float) * N * N * N, cudaMemcpyHostToDevice);

    dim3 dimBlock; 
    dimBlock.x = 32; 
    dimBlock.y = 32;
    dimBlock.z = 32; 

    dim3 dimGrid; 
    dimGrid.x = (N + dimBlock.x - 1) / dimBlock.x; 
    dimGrid.y = (N + dimBlock.y - 1) / dimBlock.y; 
    dimGrid.z = (N + dimBlock.z - 1) / dimBlock.z;

    kernel<<<dimGrid, dimBlock>>>(dA, dB, N);

    cudaMemcpy(hA, dA, sizeof(float) * N * N * N, cudaMemcpyDeviceToHost);

    cudaFree(dA);
    cudaFree(dB);

}