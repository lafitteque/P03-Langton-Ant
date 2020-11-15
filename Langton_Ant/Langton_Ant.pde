// Simulation of the cellular automata Langtaon's Ant
// The ant (here a red square) goes 1 step further each step but changes its direction depending on the colour of the cell (Left/Right for White/Black)
// The Cells are initialized with the white colour, but can be modified by clicking on them.
// The simulation can run by pressing any key (except Alt or Escape).
// The simulation can be reinitilized by pressing Alt.


// the grid of cells (white = 1 ; black = 0 )
int[][] grid;

// Screen Parameters
int screenWidth = 1000;
int gridWidth = 100;
int cellWidth;

// Position
int x;
int y;

// Direction
int d_x = 0;
int d_y = -1;

// Is running / Is not running (should be a boolean)
int activation = 0;

void setup(){
  frameRate(100);
  size(1000,1000);
  Init();
}

void Init(){
  
  grid = new int[gridWidth][gridWidth];
  
  cellWidth = (int) ((float)screenWidth/gridWidth);
  
  // The initial position is the middle of the grid
  x =(int) (gridWidth/(float)2);
  y =(int) (gridWidth/(float)2);
  
  background(40,40,40);
  
  // All the cells are set to white ( cell value = 1 )
  for (int i=0; i<gridWidth;i++){
    for (int j =0; j<gridWidth;j++){
      grid[i][j] = 1;
    }
  }
  drawGrid();
  drawAnt(x,y);
}

void draw(){
  // Always show the grid and move the ant if the simulation is running (activation = 1)
  
  boolean isInBounds =  x>1 && x<gridWidth && y>1 && y<gridWidth ;
  if (activation == 1 && isInBounds){
    advanceAnt();
  }
  
  background(40,40,40);
  drawGrid();
  drawAnt(x,y);
}
  
  
  
void mouseClicked() {
  // click on a cell to change its colour
  
  int i = (int) ((float)mouseX/cellWidth);
  int j = (int) ((float)mouseY/cellWidth);
  println(mouseX , mouseY);
  grid[i][j] = 1 - grid[i][j];
  
}


void keyPressed(){
  // Press ALT to clear
  // Press any other key (except escape) to run the simulation)
  
  if (key == CODED) {
    if (keyCode == ALT) {
      Init(); 
    }
    else{
      activation = 1;
    }
  }
  else{
    activation = 1;
  }

}



void drawGrid(){
  for (int i=0; i<gridWidth;i++){
    for (int j =0; j<gridWidth;j++){
      push();
      stroke(0);
      fill(grid[i][j]*255);
      rect(cellWidth*i,cellWidth*j,cellWidth*0.95,cellWidth*0.95);
      pop();
    }
  }
}

void advanceAnt(){
  // we change the direction depending on actual direction and the colour of the cell the Ant is actually walking on
  
  if(grid[x][y] == 1){
    if(d_y !=0){
      d_x = d_y;
      d_y = 0 ;
    }
    else{
      d_y = -d_x;
      d_x = 0;
    }
  }
  else{
    if(d_y !=0){
      d_x = -d_y;
      d_y = 0 ;
    }
    else{
      d_y = +d_x;
      d_x = 0;
    }   
  }
  
  x += d_x;
  y += d_y;
  grid[x][y] = 1 - grid[x][y]; // We change the colour of the cell
}



void drawAnt(int x , int y){
  push();
  stroke(0);
  fill(255,20,20);
  ellipse(cellWidth*(x+0.5), cellWidth*(y+0.5), cellWidth*0.7, cellWidth*0.7);
  pop(); 
}
