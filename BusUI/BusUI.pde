/*  BUS UI */

int maxWidth = 800;
int maxHeight = 480;
int framerate = 60;

int bubbleQuantity = 50;
boolean drawBubbles = true;
Bubble bubs;
Bubble[] bubbles = new Bubble[bubbleQuantity];

void setup() {
  size(800,480);
  frameRate(framerate);
  smooth(5);
  
  // Initialize bubbles
  for (int x = 0; x<bubbleQuantity;x++) {
    bubbles[x] = new Bubble();
  }
}

void draw() {
  
  background(0);
  
  noStroke();
  fill(100,50,0);
  
  //ellipse(maxWidth/2,maxHeight/2,circleDiameter,circleDiameter);
  
  
  // handle bubble drawing
  if (drawBubbles) {
    for (int x=0; x<bubbleQuantity;x++) {
      bubbles[x].display();
      bubbles[x].update();
      // blow a new bubble if popped
      if (bubbles[x].isPopped()) bubbles[x] = new Bubble();
    }
  }
}

// Background Bubble Class
class Bubble {
  
  int colorA;
  int colorB;
  int colorC;
  int opacity = 0;
  
  int xPos;
  int yPos;
  
  int life; // in frames
  int age; // in frames
  int rate; // expansion percentage
  
  int diameter;
  
  boolean popped;
  
  Bubble() {
    colorA = (int)random(50,255);
    colorB = (int)random(50,255);
    colorC = (int)random(50,255);
    life = (int)(random(framerate,framerate*3.5));
    age = 0;
    rate = (int)random(1,4);
    
    xPos = (int)random(0,maxWidth);
    yPos = (int)random(0,maxHeight);
    
    diameter = (int)random(1,(maxHeight/4));
    
    popped = false;
  }
  
  void display() {
    if (!popped) {
      noStroke();
      fill(colorA,colorB,colorC,opacity);
      ellipse(xPos,yPos,diameter,diameter);
    }
  }
  
  void update() {
    if (age >= life) popped = true;
    else {
      age++;
      if (age <= 20) { opacity = 3 * age; }
      else if (age > (life-20)) { opacity = (life-age) * 3; }
      diameter += rate;
    }
  }
  
  boolean isPopped() { return popped; }
}
  