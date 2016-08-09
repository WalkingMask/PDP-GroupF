#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/time.h>
#include <math.h>

#define START   0
#define END     999999
#define K_DIGIT 6

int compare1(const void *x, const void *y);
int compare2(const void *x, const void *y);

int main()
{
    int m1, m2, mem, cnt, a[K_DIGIT];
    char buf1[K_DIGIT + 1], buf2[K_DIGIT + 1];
    int kap_mem[END - START + 1 + 1];
    
    struct timeval start_time, end_time;
    
    gettimeofday(&start_time, NULL);
    
    int digit;
    
    for (cnt = START; cnt <= END; cnt++)
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
    
    for (cnt = 0; cnt < mem; cnt++)
    {
        printf("Kaprekar_number -> %d\n", kap_mem[cnt]);
    }
    
    gettimeofday(&end_time, NULL);
    
    printf("---------------\ntotal time -> %f sec\n", (end_time.tv_sec - start_time.tv_sec) + (end_time.tv_usec - start_time.tv_usec)*1.0E-6);
    
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
