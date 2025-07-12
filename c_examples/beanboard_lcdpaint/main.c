// lcdpaint
// using LCD command codes to paint to the console
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanboard

#include <stdio.h>
#include "../lib/marvin.h"
#include "../lib/beanboard.h"

void lcdSetCursor(unsigned char, unsigned char);

const unsigned char lineaddr[] = {LCD_LINE_0_ADDR,LCD_LINE_1_ADDR,LCD_LINE_2_ADDR,LCD_LINE_3_ADDR};

int main()
{
    marvin_lcd_init();

    lcdSetCursor(4,0);
    marvin_lcd_puts("***********");
    lcdSetCursor(4,1);
    marvin_lcd_puts("* Hello!! *");
    lcdSetCursor(4,2);
    marvin_lcd_puts("***********");
    lcdSetCursor(0,3);
    
    int c = getchar(); // wait for a key

    marvin_lcd_init();
}

// zero-based position - x: 0-20, y: 0-3
void lcdSetCursor(unsigned char x, unsigned char y) {
    marvin_lcd_putcmd(LCD_SET_DDRAM_ADDR+lineaddr[y]+x);
}
