// beanboard echo
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanboard

#include <stdio.h>
#include "../lib/marvin.h"

int main()
{
    // the following LCD set-up can be accomplished with marvin_lcd_init()
    marvin_lcd_putcmd(LCD_FUNCTION_SET+LCD_DATA_LEN_8+LCD_DISP_LINES_2+LCD_FONT_8);
	marvin_lcd_putcmd(LCD_DISPLAY_ON_OFF_CONTROL+LCD_DISPLAY_ON+LCD_CURSOR_ON+LCD_BLINK_ON);
	marvin_lcd_putcmd(LCD_CLEAR_DISPLAY);
    marvin_lcd_putcmd(LCD_SET_DDRAM_ADDR+LCD_LINE_3_ADDR);
	
    printf("Echoing from console\nto the LCD\n'Enter' to end\n");
    
    int c;

    while(1) {
        // note that c getchar will echo to the console, so using \e to end will 
        // have undesireable side-effects, so using \n 
        c = getchar();
        if(c=='\n') break; 
        marvin_lcd_putchar(c);
    }

    marvin_lcd_init(); // reinitialise the display before returning to the monitor
}
