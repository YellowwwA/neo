#include<stdio.h>
#include "libcheckeod.h"

void main()
{
    int n;
    while(1)
    {
        printf("Input Number (0:Exit) : ");
        scanf("%d", &n);
        if(n == 0)
        {
            printf("Program Exit~!!\n\n");
            break;
        }
        if(checkeod(n))
            printf("%d is odd number~!!\n\n", n);
        else
            printf("%d is even number~!!\n\n", n);
    }

}