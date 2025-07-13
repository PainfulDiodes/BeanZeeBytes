// beanboard helloworld
// example using overriden console functions and Marvin LCD functions 
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanboard

#include <stdio.h>
#include "../lib/marvin.h"
#include "../lib/beanboard.h"

int main()
{
	// the following LCD set-up can be accomplished with marvin_lcd_init()
    marvin_lcd_putcmd(LCD_FUNCTION_SET+LCD_DATA_LEN_8+LCD_DISP_LINES_2+LCD_FONT_8);
	marvin_lcd_putcmd(LCD_DISPLAY_ON_OFF_CONTROL+LCD_DISPLAY_ON+LCD_CURSOR_ON+LCD_BLINK_ON);
	marvin_lcd_putcmd(LCD_CLEAR_DISPLAY);
    marvin_lcd_putcmd(LCD_SET_DDRAM_ADDR+LCD_LINE_3_ADDR);
    
    // sending a message 1 character at a time using marvin_lcd_putchar
    char str[] = "Hello, world!\nHit any key...\n";
    for(char i = 0; str[i]!=0; i++) {
        marvin_lcd_putchar((char)str[i]);
    }
    char c = getchar(); // wait for a key

    // sending an inline string using marvin_lcd_puts
    marvin_lcd_puts("Hello again!\nHit any key...\n");
    c = getchar(); // wait for a key

    // using a pointer with marvin_lcd_puts 
    char *str2 = "Finally!\nHit any key...\n";
    marvin_lcd_puts(str2);
    c = getchar(); // wait for a key

    marvin_lcd_init(); // reinitialise the display before returning to the monitor
}
