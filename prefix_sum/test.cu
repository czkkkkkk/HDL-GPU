#include "prefix_sum.h"

#include <cuda.h>
#include <cstdio>
#include <cstdlib>

int main() {
	int n = 1 << 20;
	int *a, *da;
	a = (int*)malloc(n * sizeof(int));
	for(int i = 0; i < n; ++i) a[i] = 1;
	if(cudaSuccess != cudaMalloc((void **)&da, n * sizeof(int))) {
		puts("Error");
		exit(1);
	}
	cudaMemcpy(da, a, n * sizeof(int), cudaMemcpyHostToDevice);
	PrefixSum(da, n);
	cudaMemcpy(a, da, n * sizeof(int), cudaMemcpyDeviceToHost);
	for(int i = 0; i < n; ++i) {
		if(a[i] != i + 1) {
			puts("Error");
			exit(1);
		}
	}
	cudaFree(da);

	free(a);
	return 0;
}
