// beanboard helloworld
// example using overriden console functions and Marvin LCD functions 
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanboard

#include <stdio.h>
#include "../lib/marvin.h"
#include "../lib/beanboard.h"

int main()
{
	marvin_lcd_init();
    
    // this works
    char *str1 = "message 1\n";
    for(char i = 0; str1[i]!=0; i++) {
        marvin_lcd_putchar(str1[i]);
    }

    // this doesn't work
    char str2[] = "message 2\n";
    for(char i = 0; str2[i]!=0; i++) {
        marvin_lcd_putchar(str2[i]);
    }

    char c = getchar(); // wait for a key

    marvin_lcd_init(); // reinitialise the display before returning to the monitor
}
