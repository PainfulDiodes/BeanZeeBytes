void tft_setup(void);
void tft_cursor_x(unsigned int);
void tft_cursor_y(unsigned int);
void tft_putchar(unsigned int);
void tft_clear_screen(void);
void tft_print(char*);
void tft_clear_screen(void);
void tft_cursor_off(void);
void tft_cursor_on(void);

void clearScreen() {
    tft_clear_screen();
    for(unsigned long l=0; l<1000; l++) {
        // delay
    }

}

void setCursor(int x, int y) {
    tft_cursor_x(x*8);
    tft_cursor_y(y*16);
}

void setCursorHome() {
    tft_cursor_x(0);
    tft_cursor_y(0);
}

void hideCursor() {
    tft_cursor_off();
}

void showCursor() {
    tft_cursor_on();
}

void tft_print(char* s) {
    while(*s) {
        tft_putchar(*s++);
    }
}


