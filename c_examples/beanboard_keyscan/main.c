// beanboard echo
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanboard

#include <stdio.h>
#include "../lib/marvin.h"

int main()
{
    unsigned char key_buffer[] = {0,0,0,0,0,0,0,0};

    printf("Hit Esc to stop keyscan\n");
    
    unsigned char c,k,rowbit;

    while(1) {
        rowbit = 0b00000001;
        for(unsigned char row=0; row<8; row++) {
            // KEYSCAN_OUTP(rowbit); // doesn't work!
            
            printf("%d 0x%02x ",row,rowbit);

            // k = KEYSCAN_INP();
            // if(k==key_buffer)

            rowbit = rowbit<<1;
        }
        // c = marvin_readchar();
        // if(c=='\e') break;
        putchar('\n');
        break;
    }
}
