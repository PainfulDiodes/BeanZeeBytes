#include <stdio.h>
#include "readchar.h"
#include "terminal.h"

// function prototypes
void splash(void);
void splashDot(int,int);
void splashBox(int,int,int,int);
void delay(unsigned long);


const int SCREEN_WIDTH = 80;
const int SCREEN_HEIGHT = 24;

int main()
{
    clearScreen();
    hideCursor();
    splash();
    while(readchar()!=0); // wait for keypress
    clearScreen();
    showCursor();
    setCursorHome();
}
void splash() {
    setCursor(35,13);
    printf("Snake!");
    setCursorHome();
    for(int r=0; r<12; r++) {
        splashBox(1+r,SCREEN_WIDTH-r,1+r,SCREEN_HEIGHT-r);
        if(readchar()!=0) break;
    }
    setCursor(35,13);
    printf("Snake!");
}

void splashBox(int x1, int x2, int y1, int y2) {
    for(int x=x1; x<=x2; x++) splashDot(x,y1);
    for(int y=y1; y<=y2; y++) splashDot(x2,y);
    for(int x=x2; x>=x1; x--) splashDot(x,y2);
    for(int y=y2; y>=y1; y--) splashDot(x1,y);
}

void splashDot(int x, int y) {
    setCursor(x,y);
    putchar('*');
    delay(3);
}

void delay(unsigned long d) {
    for(unsigned long l=0; l<d; l++) {
        //
    }
}
