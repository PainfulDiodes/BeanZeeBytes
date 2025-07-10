// beanboard gpio
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanboard

#include <stdio.h>
#include "../lib/marvin.h"

int main()
{
    printf("Console to GPO\nGPI to console\n'Esc' to quit\n");
    
    unsigned char c;

    while(1) {
        // note that getchar also echoes to the console
        // using \e to end, when echoed to the console has undesirable effects 
        // so using fgetc_cons in place of getchar - which simply calls marvin getchar
        c = fgetc_cons();
        if(c=='\e') break;
        putchar(c);
        marvin_gpio_out(c);
        c = marvin_gpio_in();
        putchar(c);
    }
}
