// helloworld
// simplest example using overriden console functions 
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanzee / v1.2.1-beanboard

#include <stdio.h>
#include "../lib/marvin.h"

int main()
{
    printf("Hello, world!\n(hit any key)\n");
    char c = getchar(); // wait for a key
}
