#include "mpi.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define START 1000
#define END   9999

int compare1(const void *x, const void *y);
int compare2(const void *x, const void *y);

int main()
{
    int m1, m2, mem, cnt, a[4];
    char buf1[5], buf2[5];
    
    int x, low, high;
    int ntasks, procid;
    
    double start_time, end_time;
    
    MPI_Init(&argc, &argv);
    
    MPI_Comm_size(MPI_COMM_WORLD, &ntasks);
    MPI_Comm_rank(MPI_COMM_WORLD, &procid);
    
    start_time = MPI_Wtime();
    
    x    = (END - START + 1) / ntasks;
    low  = procid * x;
    high = low + x;
    
    int kap_mem[x];
    
    for (cnt = low; cnt < high; cnt++)
    {
        a[0] = cnt / 1 % 10;
        a[1] = cnt / 10 % 10;
        a[2] = cnt / 100 % 10;
        a[3] = cnt / 1000 % 10;
        
		sprintf(buf1, "%d%d%d%d", a[0], a[1], a[2], a[3]);
		strcpy(buf2, buf1);

		qsort(buf1, 4, sizeof(char), compare1);   // char
		qsort(buf2, 4, sizeof(char), compare2);

		m1 = atoi(buf1);   // number
		m2 = atoi(buf2);
        
		if (m1 - m2 == cnt)
        {
            kap_mem[mem] = cnt;
            mem++;
        }
	}
    
    for (cnt = 0; cnt < mem; cnt++)
    {
        printf("ID_%d : Kaprekar_number -> %d\n", procid, kap_mem[cnt]);
    }
    
    MPI_Barrier(MPI_COMM_WORLD);
    
    end_time = MPI_Wtime();
    
    printf("---------------\ntotal time -> %f", end_time - start_time);
    
    return 0;
}

int compare1(const void *x, const void *y)  // descending order
{
    const char *a = (const char *)x;
    const char *b = (const char *)y;
    return *b - *a;
}

int compare2(const void *x, const void *y)  // ascending order
{
    const char *a = (const char *)x;
    const char *b = (const char *)y;
    return *a - *b;
}
