/* Interactive Bubble With Dimmer Example */


int circleColor = 0;

int red = #ff0000;
int blue = #0066ff;
int gray = #808080;
int green = #33cc33;

int framerate = 30;

int background = 0;

Touchbubble testBubble;
Touchbubble testBubble2;

float fadeCount = 0;

void setup() {
  size(800,480);
  frameRate(framerate);
  smooth(10);
  
  testBubble = new Touchbubble(0,200,200);
  testBubble2 = new Touchbubble(0,200,400);
  
}






void draw() {
  
  background(background);
  
  testBubble.display();
  testBubble2.display();
  
  if (fadeCount>=1) fadeCount = 0;
  testBubble.setFade(fadeCount);
  //println(fadeCount);
  fadeCount+=.01;
  
  
  // Draw test slider
  rect(700,50,75,350);
  fill(0,255);
  rect(700,50,75,fadeCount*(100*3.5));
  
  
}

void mousePressed() {
  
  testBubble.isPressed();
  testBubble2.isPressed();
  
  
}




class Touchbubble {
  
  int state = 0;
  
  int xPos = 0;
  int yPos = 0;
  float xFader;
  float yFader;
  int innerDiameter = 60;
  int outerDiameter = 75;
  
  int innerColor = gray;
  
  int gradientSize = 35;
  int gradientStart = 200; // starting gradient opacity for fadey thing
  int gradientStop = 0; // ending gradient opacity for fadey thing
  int gradientState = 0; // 0 = minus, 1 = plus
  
  int gradientNow = 0; // handles the start gradient after pulse calculation
  int gradientPulseHop = 5;
  int gradientPulseDelay = 30; // in frames
  int gradientPulseFrame = 0;
  
  float fadePercent = .5; // if state = 2, fade percentage from 0 to 1
  float fadeAngle;
  
  
  Touchbubble(int State, int x, int y) {
    setState(State);
    setCoords(x,y);
    
    setFade(0.5);
  }
  
  // Draw the touch bubble
  void display() {
    
    //Draw Outer Glow Gradient
    int edgeOpacity = gradientStop;
    int currentOpacity = edgeOpacity;
    int currentDiameter = innerDiameter+gradientSize;
    
    int gradientHop = (gradientNow-gradientStop)/gradientSize;
    
    noStroke();
    for (int x=0;x<gradientSize;x++) {
      if (state == 0) fill(currentOpacity,0,0,255);
      else if (state == 1) fill(0,currentOpacity,0);
      else if (state == 2) fill(0,0,currentOpacity);
      //fill(currentOpacity,0,0,255);
      ellipse(xPos,yPos,currentDiameter,currentDiameter);
      
      currentOpacity += gradientHop;
      currentDiameter --;
    }
    
    // Handle Gradient Pulsing
    if (gradientPulseFrame >= gradientPulseDelay) {
      //println("NOW: " + gradientNow + " Start: " + gradientStart + " State: " + gradientState + " Stop: " + gradientStop);
      if (gradientNow >= gradientStart) { gradientState = 0;}
      else if (gradientNow <= gradientStop) { gradientState = 1; gradientPulseFrame = 0;}
      
      if (gradientState==1) gradientNow = gradientNow + 50;
      else gradientNow = gradientNow - 10;
    }
    else gradientPulseFrame++;
    
    // Draw the percentage draggy line thing
    stroke(255,150);
    strokeWeight(2);
    //line(xPos, yPos, xPos + outerDiameter/2 + 25, yPos);
    line(xPos,yPos,xFader,yFader);
    
    // Draw the drag bubble
    if (state == 0) fill(gradientNow,0,0,255);
    else if (state == 1) fill(0,gradientNow,0);
    else if (state == 2) fill(0,0,gradientNow);
    ellipse(xFader, yFader,15,15);
    
    //Inner Bubble
    fill(innerColor,255);
    stroke(0,150);
    strokeWeight(1);
    ellipse(xPos,yPos,60,60);
  }
  
  void isPressed() {
    
    // If mouse is pressed on this bubble, change the state
    if (overBubble()) {
      if (state == 0) setState(1);
      else setState(0);
    }
  }
  
  boolean overBubble() {
    println(xPos + " " + mouseX + " " + yPos + " " + mouseY);
    float disX = xPos - mouseX;
    float disY = yPos - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < innerDiameter/2 ) return true;
    else return false; //<>//
  }
  
  int getState() { return state; }
  
  void setState(int State) {
    state = State;
    
    println(state);
    
    switch(state) {
      case 0: innerColor = red; break;
      case 1: innerColor = green; break;
      case 2: innerColor = blue; break;
      default: innerColor = 0; break;
    }
    
  }
  
  void setCoords(int x, int y) {
    xPos = x;
    yPos = y;
  }
  
  void setFade(float Percent) {
    fadePercent = Percent;
    fadeAngle = fadePercent * 360;
    
    xFader = xPos + cos(radians(fadeAngle-90)) * 60;
    yFader = yPos + sin(radians(fadeAngle-90)) * 60;
    
  }
  
  void pressEvent() { println("HELLO WORLD"); }
}