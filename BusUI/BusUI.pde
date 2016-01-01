/*  BUS UI */

void setup() {
  int maxWidth = 800;
  int maxHeight = 480;
  int framerate = 60;

  size(maxWidth,maxHeight);
  frameRate(framerate);
  smooth(5);

}

void draw() { 
  background(0);
  
  noStroke();
  fill(100,50,0);
}