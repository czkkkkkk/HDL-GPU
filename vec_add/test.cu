#include "vec_add.h"

#include <cuda.h>
#include <cstdio>
#include <cstdlib>

int main() {
	int n = 256;
	int *a, *b, *c, *da, *db, *dc;
	a = (int*)malloc(n * sizeof(int));
	b = (int*)malloc(n * sizeof(int));
	c = (int*)malloc(n * sizeof(int));
	for(int i = 0; i < n; ++i) a[i] = b[i] = 1;
	if(cudaSuccess != cudaMalloc((void **)&da, n * sizeof(int))) {
		puts("Error");
	}
	cudaMalloc((void **)&db, n * sizeof(int));
	cudaMalloc((void **)&dc, n * sizeof(int));
	cudaMemcpy(da, a, n * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(db, b, n * sizeof(int), cudaMemcpyHostToDevice);
	VecAdd<<<1, n>>>(da, db, dc, n);
	cudaMemcpy(c, dc, n * sizeof(int), cudaMemcpyDeviceToHost);
	for(int i = 0; i < n; ++i) {
		if(c[i] != 2) {
			printf("Error\n");
			exit(1);
		}
	}
	cudaFree(da);
	cudaFree(db);
	cudaFree(dc);

	free(a);
	free(b);
	free(c);
	return 0;
}
