#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/time.h>
#include <math.h>

#define START   0
#define END     999999
#define K_DIGIT 6
#define PROCESS 4

int compare1(const void *x, const void *y);
int compare2(const void *x, const void *y);

int main(int argc, char *argv[])
{
    int m1, m2, mem, cnt, a[K_DIGIT];
    char buf1[K_DIGIT + 1], buf2[K_DIGIT + 1];
    int kap_mem[END - START + 1 + 1];
    
    int i, j, cnt_mem;
    int ntasks, procid;
    
    struct timeval start_time, end_time;
    
    MPI_Status status;
    
    MPI_Init(&argc, &argv);
    
    MPI_Comm_size(MPI_COMM_WORLD, &ntasks);
    MPI_Comm_rank(MPI_COMM_WORLD, &procid);
    
    gettimeofday(&start_time, NULL);
    
    int digit;
    
    for (cnt = procid; cnt <= END; cnt = cnt + PROCESS)
    {
        int i = cnt;
        
        for (digit = 0; i != 0 ; digit++)
        {
            i = i / 10;
        }
        
        for (i = 0; i < digit; i++)
        {
            int j;
            int powpow = 1;
            
            for (j = 0; j < i; j++)
                powpow = powpow * 10;
            
            a[i] = cnt / powpow % 10;
        }
        
        for (i = 0; i < digit; i++)
        {
            sprintf(&buf1[i], "%d", a[i]);
        }
        
        strcpy(buf2, buf1);
        
        qsort(buf1, digit, sizeof(char), compare1);
        qsort(buf2, digit, sizeof(char), compare2);
        
        m1 = atoi(buf1);
        m2 = atoi(buf2);
        
        if (m1 - m2 == cnt)
        {
            kap_mem[mem] = cnt;
            mem++;
        }
    }
    
    if (procid != 0)
    {
        cnt_mem = mem;
        
        MPI_Send(&cnt_mem, 1, MPI_INT, 0, procid, MPI_COMM_WORLD);
        MPI_Send(kap_mem, cnt_mem, MPI_INT, 0, procid+5, MPI_COMM_WORLD);
    }
    
    if (procid == 0)
    {
        {   for (i = 0; i < mem; i++)
        {
            printf("Kaprekar_number -> %d\n", kap_mem[i]);
        }
            
            for (i = 1; i < ntasks; i++)
            {
                MPI_Recv(&cnt_mem, 1, MPI_INT, i, i, MPI_COMM_WORLD, &status);
                MPI_Recv(kap_mem, cnt_mem, MPI_INT, i, i+5, MPI_COMM_WORLD, &status);
                
                for (j = 0; j < cnt_mem; j++)
                {
                    printf("Kaprekar_number -> %d\n", kap_mem[j]);
                }
                
                cnt_mem = 0;
            }
            
            gettimeofday(&end_time, NULL);
            
            printf("---------------\ntotal time -> %f sec\n", (end_time.tv_sec - start_time.tv_sec) + (end_time.tv_usec - start_time.tv_usec)*1.0E-6);
        }
    }
    
    MPI_Finalize();
    
    return 0;
}

int compare1(const void *x, const void *y)
{
    const char *a = (const char *)x;
    const char *b = (const char *)y;
    return *b - *a;
}

int compare2(const void *x, const void *y)
{
    const char *a = (const char *)x;
    const char *b = (const char *)y;
    return *a - *b;
}
