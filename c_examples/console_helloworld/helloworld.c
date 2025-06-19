// helloworld
// simplest example using overriden console functions 
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.1.0 (beanboard target)


#include <stdio.h>

int main()
{
    printf("\nHello world!\n(hit any key)\n\n");
    int c = getchar(); // getchar waits for a key
}
