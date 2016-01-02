/*  BUS UI */

/* Defin Buttons */
int buttonWidth = 40, buttonHeight = 75;

/* Left Side */
int engineButtonX = 0, engineButtonY = 0;
int engineButtonColor = #B5B5B5;
boolean engineButtonOn = false;

int tireButtonX = 0, tireButtonY = 80;
int tireButtonColor = #B5B5B5;
boolean tireButtonOn = false;

/* Right Side */
int lightButtonX = 759, lightButtonY = 0;
int lightButtonColor = #B5B5B5;
boolean lightButtonOn = false;

int audioButtonX = 759, audioButtonY = 80;
int audioButtonColor = #B5B5B5;
boolean audioButtonOn = false;


PFont f;

void setup() {
  int maxWidth = 800;
  int maxHeight = 480;
  int framerate = 60;

  size(800, 480);
  frameRate(framerate);
  smooth(5);

  f = createFont("ArialHB.ttc", 12);
  textFont(f);
}

void draw() { 
  background(#000000);
  line(400, 20, 400, 460);

  stroke(#FFFFFF);
  fill(engineButtonColor);
  rect(engineButtonX, engineButtonY, buttonWidth, buttonHeight);

  stroke(#FFFFFF);
  fill(tireButtonColor);
  rect(tireButtonX, tireButtonY, buttonWidth, buttonHeight);

  /* Right Buttons */

  stroke(#FFFFFF);
  fill(lightButtonColor);
  rect(lightButtonX, lightButtonY, buttonWidth, buttonHeight);

  stroke(#FFFFFF);
  fill(audioButtonColor);
  rect(audioButtonX, audioButtonY, buttonWidth, buttonHeight);

  pushMatrix();
  fill(#000000);
  translate(width/2, height/2);
  rotate(radians(270));
  text("Engine", engineButtonY + 180, engineButtonX - 380);
  text("Tires", tireButtonY + 30, tireButtonX - 380);

  text("Lights", lightButtonY + 180, lightButtonX - 375);
  text("Audio", audioButtonY + 25, audioButtonX - 375);
  popMatrix();
  
  drawDasBus();
}

void mousePressed() {

  if (overRect(engineButtonX, engineButtonY, buttonWidth, buttonHeight) && !engineButtonOn) {
    engineButtonColor = #33cc33;
    engineButtonOn = true;
    tireButtonOn = false;
    tireButtonColor = #B5B5B5;
    // Enable Lighting Layer Features
  } else if (overRect(engineButtonX, engineButtonY, buttonWidth, buttonHeight) && engineButtonOn) {
    engineButtonColor = #B5B5B5;
    engineButtonOn = false;
    // Disable Lighting Layer Features
  }

  if (overRect(tireButtonX, tireButtonY, buttonWidth, buttonHeight) && !tireButtonOn) {
    tireButtonColor = #33cc33;
    tireButtonOn = true;
    engineButtonOn = false;
    engineButtonColor = #B5B5B5;
    // Enable Lighting Layer Features
  } else if (overRect(tireButtonX, tireButtonY, buttonWidth, buttonHeight) && tireButtonOn) {
    tireButtonColor = color(#B5B5B5);
    tireButtonOn = false;
    // Disable Lighting Layer Features
  }

  if (overRect(lightButtonX, lightButtonY, buttonWidth, buttonHeight) && !lightButtonOn) {
    lightButtonColor = #33cc33;
    lightButtonOn = true;
    audioButtonOn = false;
    audioButtonColor = #B5B5B5;
    // Enable Lighting Layer Features
  } else if (overRect(lightButtonX, lightButtonY, buttonWidth, buttonHeight) && lightButtonOn) {
    lightButtonColor = color(#B5B5B5);
    lightButtonOn = false;
    // Disable Lighting Layer Features
  }

  if (overRect(audioButtonX, audioButtonY, buttonWidth, buttonHeight) && !audioButtonOn) {
    audioButtonColor = #33cc33;
    audioButtonOn = true;
    lightButtonOn = false;
    lightButtonColor = #B5B5B5;
    // Enable Lighting Layer Features
  } else if (overRect(audioButtonX, audioButtonY, buttonWidth, buttonHeight) && audioButtonOn) {
    audioButtonColor = #B5B5B5;
    audioButtonOn = false;
    // Disable Lighting Layer Features
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void drawDasBus() {
  stroke(#FFFFFF);
 // line(475, 150, 475, 450);
 // line(675, 150, 675, 450);
  
 // line(475, 450, 675, 450);
 // line(475, 150, 675, 150);
  rect(500, 125, 160, 300, 10);
  
  line(535, 75, 625, 75);
  
  line(525, 125, 535, 75);
  line(635, 125, 625, 75);
}