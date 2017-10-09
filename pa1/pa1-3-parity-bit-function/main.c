#include <stdio.h>
#include "util.h"

#define SIZE 5

void parity_asm(long long int nums[], long long int size);

void print_array(long long int nums[], long long int len) 
{
    for (int i = 0; i < len; ++i) 
    {
        printf("%d\n", nums[i]);
    }
}


long long int list[SIZE] = {0x02, 0x01, 0x06, 0x04, 0x08};

int main() 
{

    printf("Origin number( 4-bit )\n");
    print_array(list, SIZE);

    parity_asm(list, SIZE);
    printf("Parity bit( 4+1 bits )\n");
    print_array(list, SIZE);

    return 0;
}
