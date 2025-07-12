// beanboard echo
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanboard

#include <stdio.h>
#include "../lib/marvin.h"
#include "../lib/beanboard.h"

int main()
{
    unsigned char key_buffer[8];
    unsigned char c,k,rowbit;

    printf("Hit Esc to stop keyscan\n");

    // store initial keyboard state
    rowbit = 0b00000001;
    for(char row=0; row<8; row++) {
        marvin_keyscan_out(rowbit);
        k = marvin_keyscan_in();
        key_buffer[row]=k;
        rowbit = rowbit<<1;
    }

    // scan
    while(1) {
        rowbit = 0b00000001;
        for(char row=0; row<8; row++) {
            marvin_keyscan_out(rowbit);
            k = marvin_keyscan_in();
            if(k!=key_buffer[row]) {
                printf("row:%d rowbit:0x%02x old:0x%02x new:0x%02x \n",row,rowbit,key_buffer[row],k); // debug
                key_buffer[row]=k;
            }
            rowbit = rowbit<<1;
        }
        c = marvin_readchar();
        if(c=='\e') break;
    }
}
