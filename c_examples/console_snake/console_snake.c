#include <stdio.h>
#include "readchar.h"

// function prototypes
void clearScreen(void);
void setCursor(int,int);
void setCursorHome(void);
void cursorMove(char, int);
void openingScreen(void);
void plot(int,int);
void plotBox(int,int,int,int);

const int SCREEN_WIDTH = 80;
const int SCREEN_HEIGHT = 24;

int main()
{
    openingScreen();
}

void openingScreen() {
    clearScreen();
    setCursor(35,12);
    printf("Snake!!");
    setCursorHome();
    
    for(int r=0; r<12; r++) {
        plotBox(1+r,SCREEN_WIDTH-r,1+r,SCREEN_HEIGHT-r);
    }
        
    int i = getchar();
    
    clearScreen();
    setCursorHome();
}

void plotBox(int x1, int x2, int y1, int y2) {
    for(int x=x1; x<=x2; x++) plot(x,y1);
    for(int y=y1; y<=y2; y++) plot(x2,y);
    for(int x=x2; x>=x1; x--) plot(x,y2);
    for(int y=y2; y>=y1; y--) plot(x1,y);
}

void plot(int x, int y) {
    setCursor(x,y);
    putchar('*');
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