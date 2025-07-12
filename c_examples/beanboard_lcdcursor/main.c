// beanboard lcdcursor
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanboard

#include <stdio.h>
#include "../lib/marvin.h"
#include "../lib/beanboard.h"

int main()
{
    printf("Press any key to exit");

	// the following LCD set-up can be accomplished with marvin_lcd_init()
    marvin_lcd_putcmd(LCD_FUNCTION_SET+LCD_DATA_LEN_8+LCD_DISP_LINES_2+LCD_FONT_8);
	marvin_lcd_putcmd(LCD_DISPLAY_ON_OFF_CONTROL+LCD_DISPLAY_ON+LCD_CURSOR_ON+LCD_BLINK_ON);
	marvin_lcd_putcmd(LCD_CLEAR_DISPLAY);

    marvin_lcd_putcmd(LCD_SET_DDRAM_ADDR+LCD_LINE_0_ADDR+0);
    marvin_lcd_puts("Hello, world!");
    
    marvin_lcd_putcmd(LCD_SET_DDRAM_ADDR+LCD_LINE_1_ADDR+2);
    marvin_lcd_puts("Hello, world!");
    
    marvin_lcd_putcmd(LCD_SET_DDRAM_ADDR+LCD_LINE_2_ADDR+4);
    marvin_lcd_puts("Hello, world!");
    
    marvin_lcd_putcmd(LCD_SET_DDRAM_ADDR+LCD_LINE_3_ADDR+6);
    marvin_lcd_puts("Hello, world!");
    
    char c = getchar(); // wait for a key

    marvin_lcd_init(); // reinitialise the display before returning to the monitor
}
