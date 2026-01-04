void tft_setup(void);
void tft_cursor_x(unsigned int);
void tft_cursor_y(unsigned int);
void tft_putchar(unsigned int);
void tft_clear_screen(void);

void clearScreen() {
    tft_clear_screen();
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
}

void showCursor() {
}

