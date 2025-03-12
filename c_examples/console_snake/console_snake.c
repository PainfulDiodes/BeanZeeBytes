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
// void delay(int);
void delay(unsigned int);
void hideCursor(void);
void showCursor(void);


const int SCREEN_WIDTH = 80;
const int SCREEN_HEIGHT = 24;

int read_char = 0;

int main()
{
    openingScreen();
}

void openingScreen() {
    clearScreen();
    hideCursor();
    setCursor(35,13);
    printf("Snake!");
    setCursorHome();
    
    for(int r=0; r<12; r++) {
        plotBox(1+r,SCREEN_WIDTH-r,1+r,SCREEN_HEIGHT-r);
        if(read_char!=0) break;
    }
    setCursor(35,13);
    printf("Snake!");

    while(read_char==0) read_char = readchar();

    clearScreen();
    showCursor();
    setCursorHome();
}

void plotBox(int x1, int x2, int y1, int y2) {
    for(int x=x1; x<=x2; x++) {
        plot(x,y1);
        if(read_char!=0) return;
    }

    for(int y=y1; y<=y2; y++) {
        plot(x2,y);
        if(read_char!=0) return;
    }

    for(int x=x2; x>=x1; x--) {
        plot(x,y2);
        if(read_char!=0) return;
    }

    for(int y=y2; y>=y1; y--) {
        plot(x1,y);
        if(read_char!=0) return;
    }
}

void plot(int x, int y) {
    setCursor(x,y);
    putchar('*');
    delay(3);
    read_char = readchar();
}

void delay(unsigned int d) {
    for(unsigned int i=0; i<d; i++) {
        //
    }
}

// void delay(int d) {
//     for(int i=0; i<d; i++) {
//         for(int j=0; j<100; j++) {
//             //
//         }
//     }
// }

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

