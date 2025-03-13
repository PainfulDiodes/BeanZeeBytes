#include <stdio.h>
#include <stdbool.h>
#include "readchar.h"
#include "terminal.h"

// function prototypes
void splash(void);
void splashDot(int,int);
void splashBox(int,int,int,int);
void delay(unsigned long);
void setCell(int,int,char);
void drawSnake(void);
void setupGame(void);
    
#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 24
#define X_MAX_CELL 80
#define Y_MAX_CELL 24
#define X_START_CELL 40
#define Y_START_CELL 12

// snake is held in 2 arrays for coordinates. First element is the head of the snake. 
#define MAX_LENGTH 100
int x_cell_pos[MAX_LENGTH+1];
int y_cell_pos[MAX_LENGTH+1];

int length = 5;
bool alive;
int score,motion; //fruit_x, fruit_y, 

#define MOTION_NONE  0
#define MOTION_UP    1
#define MOTION_DOWN  2
#define MOTION_LEFT  3
#define MOTION_RIGHT 4

int main()
{
    clearScreen();
    hideCursor();
    splash();
    while(readchar()==0); // wait for keypress

    setupGame();

    while(readchar()==0); // wait for keypress

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
    setCell(x,y,'*');
    delay(3);
}

void setupGame() {
    // lastMoveMillis = millis();
    score = 0;
    motion = MOTION_NONE;
    alive = true;
  
    for(int i=0; i<=length; i++) // use <= as the position after the length is used to clean up the prior position of the snake
    {
      x_cell_pos[i] = X_START_CELL-i;
      y_cell_pos[i] = Y_START_CELL;
    }
  
    clearScreen();
    drawSnake();
    // dropFruit();
    // printScore(ILI9341_WHITE);
  }
  
void setCell(int x, int y, char c) {
    setCursor(x,y);
    putchar(c);
}

void drawSnake() {
    int c = 1;
    for(int i=0; i<length; i++) {
      if(i==0) setCell(x_cell_pos[i],y_cell_pos[i], alive ? '#' : '.');
      else if(c==1) setCell(x_cell_pos[i],y_cell_pos[i], alive ? '*' : '.');
      else setCell(x_cell_pos[i],y_cell_pos[i],alive ? 'o' : '.');
      c=-c;
    }
    setCell(x_cell_pos[length],y_cell_pos[length],' ');
  }
  

void delay(unsigned long d) {
    for(unsigned long l=0; l<d; l++) {
        //
    }
}
