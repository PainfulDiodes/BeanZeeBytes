// console_paint
// using ANSI escape codes to paint to the console
// https://en.wikipedia.org/wiki/ANSI_escape_code

#include <stdio.h>

// function prototypes
void clearScreen(void);
void setCursor(int,int);
void setCursorHome(void);
void cursorMove(char, int);

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