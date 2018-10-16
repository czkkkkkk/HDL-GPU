#include "prefix_sum.h"

__global__ void BlockPrefix(int *a, int k, int n) {
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	for(int j = i * k + 1; j < i * k + k && j < n; ++j) {
		a[j] += a[j - 1];
	}
}

__global__ void Compute(int *a, int k, int n) {
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	int id = i / k * 2 * k + k + i % k;
	if(id < n) {
		a[id] += a[id - id % k - 1];
	}
}

void PrefixSum(int *a, int n) {
	int block_size = 256;
	int threadsPerBlock = 256;
	BlockPrefix<<<(n + threadsPerBlock * block_size - 1) / (threadsPerBlock * block_size), threadsPerBlock>>>(a, block_size, n);
	for(int i = block_size; i < n; i *= 2) {
		int t = n / 2;
		int threadsPerBlock = 256;
		int numBlocks = (t + 256 - 1) / 256;
		Compute<<<numBlocks, threadsPerBlock>>>(a, i, n);
	}
}
