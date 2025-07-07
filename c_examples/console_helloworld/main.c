// helloworld
// simplest example using overriden console functions 
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2 for beanzee and for beanboard


#include <stdio.h>

int main()
{
    printf("Hello, world!\n");

    char *str1 = "Message 2\n";
    printf(str1);

    const char str2[] = "Message 3\n";
    printf(str2);

    char str3[] = "Message 4\n";
    printf(str3);

    int c = getchar(); // getchar waits for a key
}
