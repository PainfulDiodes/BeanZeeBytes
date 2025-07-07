// helloworld
// simplest example using overriden console functions 
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2 for beanzee and for beanboard


#include <stdio.h>
#include "../lib/marvin.h"

static char str4[] = "Message 4\n";

int main()
{
    printf("Hello, world!\n");

    char *str1 = "Message 1\n";
    printf(str1);

    const char str2[] = "Message 2\n";
    printf(str2);

    char str3[] = "Message 3\n";
    printf(str3);

    printf(str4);

    puts("puts ");
    puts(str4);

    marvin_lcd_putchar(str3[0]);
    putchar(str3[0]);

    int c = getchar(); // getchar waits for a key
}
