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
  //testBubble2 = new Touchbubble(0,200,400);
  
  testBubble.open();
  
}






void draw() {
  
  background(background);
  
  testBubble.display();
  //testBubble2.display();
  
  //if (fadeCount>=1) fadeCount = 0;
  //testBubble.setFade(fadeCount);
  //fadeCount+=.01;
  
}

void mousePressed() {
  
  testBubble.isClicked();
  //testBubble2.isClicked();
  
  
}

void mouseReleased() {
  
  testBubble.faderRelease();
  //testBubble2.faderRelease();
  
}




class Touchbubble {
  
  int state = 0; // 0=off,1=on,2=fader
  int openState = 0; // 0=closed,1=opening,2=open,3=closing
  
  int xPos = 0;
  int yPos = 0;
  int innerDiameter = 60;
  int currentDiameter = 0; // for opening and closing the bubble
  
  float xFader;
  float yFader;
  int faderDiameter = 25;
  
  int innerColor = gray;
  
  int gradientSize = 35;
  int gradientStart = 200; // starting gradient opacity for fadey thing
  int gradientStop = 0; // ending gradient opacity for fadey thing
  int gradientState = 0; // 0 = minus, 1 = plus
  
  int gradientNow = 0; // handles the start gradient after pulse calculation
  int gradientPulseHop = 5;
  int gradientPulseDelay = 10; // in frames
  int gradientPulseFrame = 0;
  boolean allowPulse = false;
  
  float fadePercent = .5; // if state = 2, fade percentage from 0 to 1
  float fadeAngle;
  int faderMultiplier;  // used to resize fader bubble
  
  boolean overFader = false;  // is the cursor over the fader?
  boolean faderLocked = false; // is the fader locked to a finger for scrolling?
  
  boolean closeTrigger = false;
  int closeCount = 0;
  
  
  Touchbubble(int State, int x, int y) {
    setState(State);
    setCoords(x,y);
    
    setFade(0);
  }
  
  void open() { openState = 1; closeTrigger = false; closeCount = 0; }
  void close() { if (openState == 2) openState = 3; }
  
  // Draw the touch bubble
  void display() {
    if (openState == 0) return;  // bubble not active
    
    // Draw Outer Glow Gradient
    if (openState == 2) { // only if in state 2 of open
      int edgeOpacity = gradientStop;
      int currentOpacity = edgeOpacity;
      int currentDiameter = innerDiameter+gradientSize;
      int gradientHop = (gradientNow-gradientStop)/gradientSize;
      
      noStroke();  // disable stroke on the gradient lines
      for (int x=0;x<gradientSize;x++) {
        stateFill(currentOpacity);
        ellipse(xPos,yPos,currentDiameter,currentDiameter);
        currentOpacity += gradientHop;
        currentDiameter --;
      }
    
      // Handle Gradient Pulsing
      if (gradientPulseFrame >= gradientPulseDelay) {  // delay the next pulse
        if (gradientNow >= gradientStart) { gradientState = 0;}
        else if (gradientNow <= gradientStop) { gradientState = 1; gradientPulseFrame = 0;}
        if (gradientState==1) gradientNow = gradientNow + 50;
        else gradientNow = gradientNow - 10;
      } else { gradientPulseFrame++; }
    }
    
    // Draw the percentage draggy line thing
    if (openState == 2) {
      stroke(255,150);
      strokeWeight(2);
      line(xPos,yPos,xFader,yFader);
      
      // Check if the fader is being pressed before we draw anything
      faderPress();
      if (faderLocked) { xFader = mouseX; yFader = mouseY; }
      
      // Draw the drag bubble
      stateFill(gradientNow);
      if (faderLocked) faderMultiplier = 2;
      else faderMultiplier = 1;
      ellipse(xFader, yFader,faderDiameter*faderMultiplier,faderDiameter*faderMultiplier);
    }
    
    // Inner Bubble
    fill(innerColor,255);
    stroke(0,150);
    strokeWeight(1);
    ellipse(xPos,yPos,currentDiameter,currentDiameter);
    
    // Make the bubble open look more smooth
    if (openState == 1 && currentDiameter < (innerDiameter*.20)) currentDiameter+=2;
    else if (openState == 1 && currentDiameter < (innerDiameter*.5)) currentDiameter+=8;
    else if (openState == 1 && currentDiameter < (innerDiameter*.75)) currentDiameter+=4;
    else if (openState == 1 && currentDiameter < innerDiameter) currentDiameter+=2;
    else if (openState == 1 && currentDiameter >= innerDiameter) { openState = 2; }
    
    // If fader is locked, shrink middle to 90% //<>//
    if (openState == 2 && faderLocked) currentDiameter = (int)(.9 * innerDiameter);
    else if (openState == 2 && !faderLocked) currentDiameter = innerDiameter;
    
    // If closing bubble, make it quick
    if (openState == 3 && closeCount == framerate) openState = 0;
    else if (openState == 3 && closeCount < framerate) {
      currentDiameter = innerDiameter - closeCount*(innerDiameter/framerate);
      closeCount++;
    }
    
  }
  
  void isClicked() {
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
  
  boolean overCircle(int xC, int yC, int diameter) {
    float disX = xC - mouseX;
    float disY = yC - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) return true;
    else return false;
  }
  
  int getState() { return state; }
  
  void setState(int State) {
    state = State;
    
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
  
  void faderPress() {
    
    // Is the cursor over the fader?
    if (overCircle((int)xFader,(int)yFader,faderDiameter)) overFader = true;
    else overFader = false;
    
    // If we are actively dragging this fader
    if (overFader && mousePressed || faderLocked) {
      faderLocked = true;
      setState(2);
      
      // Calculate Angle
      
      // Draw angle value over finger
      textSize(15);
      fill(255,255,255);
      textAlign(CENTER,BOTTOM);
      text("Angle Value", xFader, yFader-25); 
      
    }
    else faderLocked = false;
  }
  
  void faderRelease() {
    // Unlock the fader from cursor
    faderLocked = false;
    
    // Trigger bubble close
    close();
    
    // Calculate angle to send
    /* TO DO */
  }
  
  float getAngle(int x1, int y1, int x2, int y2) {
    //PVector v1 = new PVector(
    return 0.0;
  }
  
  // Set the fill for a certain color depending on current state
  void stateFill(int level) {
    switch(state) {
      case 0: fill(level,0,0,255); break;  // red
      case 1: fill(0,level,0,255); break;  // green
      case 2: fill(0,0,level,255); break;  // blue
      default: fill(0,0,0,255); break;     // black
    }
  }
}