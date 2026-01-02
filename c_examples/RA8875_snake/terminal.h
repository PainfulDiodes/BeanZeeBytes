void clearScreen() {
    printf("\e[2J");
}

void setCursor(int x, int y) {
    printf("\e[%d;%dH",y,x);
}

void setCursorHome() {
    printf("\e[H");
}

void cursorMove(char dir, int dist) {
    printf("\e[%d%c",dist,dir);
}

void hideCursor() {
    printf("\e[?25l");
}

void showCursor() {
    printf("\e[?25h");
}

