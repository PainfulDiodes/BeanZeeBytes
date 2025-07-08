// paint
// using ANSI escape codes to paint to the console
// https://en.wikipedia.org/wiki/ANSI_escape_code
// built with z88dk
// tested on BeanBoard v1, BeanZee v1 and Marvin v1.2.1-beanzee and v1.2.1-beanboard

#include <stdio.h>

// function prototypes
void clearScreen(void);
void setCursor(int,int);
void setCursorHome(void);
void cursorMove(char, int);
void hideCursor(void);
void showCursor(void);

int main()
{
    clearScreen();
    setCursor(30,10);
    printf("*************");
    setCursor(30,11);
    printf("*           *");
    setCursor(30,12);
    printf("*  Hello!!  *");
    setCursor(30,13);
    printf("*           *");
    setCursor(30,14);
    printf("*************");
    setCursorHome();
    
    int c = getchar(); // wait for a key

    clearScreen();
    setCursorHome();
}

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
