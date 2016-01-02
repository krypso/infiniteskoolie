/*  BUS UI */

/* Defin Buttons */
int buttonWidth = 40, buttonHeight = 75;

/* Left Side */
int engineButtonX = 0, engineButtonY = 0;
color engineButtonColor = color(255);
boolean engineButtonOn = false;

int tireButtonX = 0, tireButtonY = 80;
color tireButtonColor = color(255);
boolean tireButtonOn = false;

/* Right Side */
int lightButtonX = 759, lightButtonY = 0;
color lightButtonColor = color(255);
boolean lightButtonOn = false;

int audioButtonX = 759, audioButtonY = 80;
color audioButtonColor = color(255);
boolean audioButtonOn = false;


PFont f;

void setup() {
  int maxWidth = 800;
  int maxHeight = 480;
  int framerate = 60;

  size(800,480);
  frameRate(framerate);
  smooth(5);

  f = createFont("ArialHB.ttc", 12);
  textFont(f);
}

void draw() { 
  background(#FFFFFF);
  line(400, 20, 400, 460);
  
  stroke(0);
  fill(engineButtonColor);
  rect(engineButtonX, engineButtonY, buttonWidth, buttonHeight);
   
  stroke(0);
  fill(tireButtonColor);
  rect(tireButtonX, tireButtonY, buttonWidth, buttonHeight);
  
  /* Right Buttons */
  
  stroke(0);
  fill(lightButtonColor);
  rect(lightButtonX, lightButtonY, buttonWidth, buttonHeight);
  
  stroke(0);
  fill(audioButtonColor);
  rect(audioButtonX, audioButtonY, buttonWidth, buttonHeight);
  
  fill(0);
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(270));
  text("Engine", engineButtonY + 180, engineButtonX - 380);
  text("Tires", tireButtonY + 30, tireButtonX - 380);
  
  text("Lights", lightButtonY + 180, lightButtonX - 375);
  text("Audio", audioButtonY + 25, audioButtonX - 375);
  popMatrix(); 
  

  
}

void mousePressed() {
  
   if (overRect(engineButtonX, engineButtonY, buttonWidth, buttonHeight) && !engineButtonOn) {
    engineButtonColor = color(#33cc33);
    engineButtonOn = true;
    tireButtonOn = false;
    tireButtonColor = color(#FFFFFF);
    // Enable Lighting Layer Features
  } else if (overRect(engineButtonX, engineButtonY, buttonWidth, buttonHeight) && engineButtonOn){
    engineButtonColor = color(#FFFFFF);
    engineButtonOn = false;
    // Disable Lighting Layer Features
  }
  
   if (overRect(tireButtonX, tireButtonY, buttonWidth, buttonHeight) && !tireButtonOn) {
    tireButtonColor = color(#33cc33);
    tireButtonOn = true;
    engineButtonOn = false;
    engineButtonColor = color(#FFFFFF);
    // Enable Lighting Layer Features
  } else if (overRect(tireButtonX, tireButtonY, buttonWidth, buttonHeight) && tireButtonOn){
    tireButtonColor = color(#FFFFFF);
    tireButtonOn = false;
    // Disable Lighting Layer Features
  }
  
  if (overRect(lightButtonX, lightButtonY, buttonWidth, buttonHeight) && !lightButtonOn) {
    lightButtonColor = color(#33cc33);
    lightButtonOn = true;
    audioButtonOn = false;
    audioButtonColor = color(#FFFFFF);
    // Enable Lighting Layer Features
  } else if (overRect(lightButtonX, lightButtonY, buttonWidth, buttonHeight) && lightButtonOn){
    lightButtonColor = color(#FFFFFF);
    lightButtonOn = false;
    // Disable Lighting Layer Features
  }
  
  if (overRect(audioButtonX, audioButtonY, buttonWidth, buttonHeight) && !audioButtonOn) {
    audioButtonColor = color(#33cc33);
    audioButtonOn = true;
    lightButtonOn = false;
    lightButtonColor = color(#FFFFFF);
    // Enable Lighting Layer Features
  } else if (overRect(audioButtonX, audioButtonY, buttonWidth, buttonHeight) && audioButtonOn){
    audioButtonColor = color(#FFFFFF);
    audioButtonOn = false;
    // Disable Lighting Layer Features
  }

}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}