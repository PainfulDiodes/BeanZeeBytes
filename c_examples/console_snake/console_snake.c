#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "readchar.h"
#include "terminal.h"

// function prototypes
void splash(void);
void splashDot(int,int);
bool splashBox(int,int,int,int);
void delay(unsigned long);
void setCell(int,int,char);
void drawSnake(void);
void setupGame(void);
void dropFruit(void);
bool isWithinSnake(int,int);
    
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

bool alive;
int seed,length,score,motion,fruit_x,fruit_y;

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

    setupGame();

    while(readchar()==0); // wait for keypress

    clearScreen();
    showCursor();
    setCursorHome();
}

void splash() {
    seed=0;
    setCursor(35,13);
    printf("Snake!");
    setCursor(28,16);
    printf("Press any key to start");
    setCursorHome();
    for(int r=0; r<12; r++) {
        if(splashBox(1+r,SCREEN_WIDTH-r,1+r,SCREEN_HEIGHT-r)) break;
    }
    setCursor(35,13);
    printf("Snake!");
    srand(seed);
}

bool splashBox(int x1, int x2, int y1, int y2) {
    for(int x=x1; x<=x2; x++) {
        splashDot(x,y1); 
        if(readchar()!=0) return true;
    }
    for(int y=y1; y<=y2; y++) {
        splashDot(x2,y);
        if(readchar()!=0) return true;
    }
    for(int x=x2; x>=x1; x--) {
        splashDot(x,y2);
        if(readchar()!=0) return true;
    }
    for(int y=y2; y>=y1; y--) {
        splashDot(x1,y);
        if(readchar()!=0) return true;
    }
    return false;
}

void splashDot(int x, int y) {
    setCell(x,y,'*');
    delay(3);
    seed++;
}

void setupGame() {
    // lastMoveMillis = millis();
    score = 0;
    length = 5;
    motion = MOTION_NONE;
    alive = true;

    for(int i=0; i<=length; i++) // use <= as the position after the length is used to clean up the prior position of the snake
    {
        x_cell_pos[i] = X_START_CELL-i;
        y_cell_pos[i] = Y_START_CELL;
    }

    clearScreen();

    drawSnake();
    dropFruit();
    // printScore(ILI9341_WHITE);
}
  
void setCell(int x, int y, char c) {
    setCursor(x,y);
    putchar(c);
}

void drawSnake() {
    int c = 1;
    for(int i=0; i<length; i++) {
        if(i==0) setCell(x_cell_pos[i],y_cell_pos[i], alive ? '#' : '&');         //head
        else if(c==1) setCell(x_cell_pos[i],y_cell_pos[i], alive ? '*' : '.');    //stripe
        else setCell(x_cell_pos[i],y_cell_pos[i],alive ? '*' : '.');              //alt-stripe
        c=-c;
    }
    setCell(x_cell_pos[length],y_cell_pos[length],' ');  
}

void dropFruit() {
    while(true) {
      fruit_x = (rand() % X_MAX_CELL)+1;
      fruit_y = (rand() % Y_MAX_CELL)+1;
      if(!isWithinSnake(fruit_x, fruit_y)) {
        setCell(fruit_x,fruit_y,'+');
        return;
      }
    }
  }
  
bool isWithinSnake(int x, int y) {
    for(int i = 0; i < length; i++) {
        if(x == x_cell_pos[i] && y == y_cell_pos[i]) {
            return true;
        }
    }
    return false;
}

void delay(unsigned long d) {
    for(unsigned long l=0; l<d; l++) {
        //
    }
}
