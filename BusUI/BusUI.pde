/*  BUS UI */

/* Define Colors */
int green = #33cc33;
int black = #000000;
int white = #FFFFFF;

/* Define Buttons */
int buttonWidth = 40, buttonHeight = 75;

/* Left Side */
int engineButtonX = 0, engineButtonY = 0;
int engineButtonColor = #B5B5B5;
boolean engineButtonOn = false;

int tireButtonX = 0, tireButtonY = 80;
int tireButtonColor = #B5B5B5;
boolean tireButtonOn = false;

/* Right Side */
// Lighting
int lightButtonX = 759, lightButtonY = 0;
int lightButtonColor = #B5B5B5;
boolean lightButtonOn = false;
boolean lightOnOne = false;
boolean lightOnTwo = false;
boolean lightOnThree = false;
boolean lightOnFour = false;
boolean lightOnFive = false;
boolean lightOnSix = false;
boolean lightOnSeven= false;



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
  
  drawMainTabs();
  drawDasBus();
  
  if (lightButtonOn) drawLights();
}

void mousePressed() {
// General Tabs
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
    disableLightBanks(0);
    // Disable Lighting Layer Features
  }

  if (overRect(audioButtonX, audioButtonY, buttonWidth, buttonHeight) && !audioButtonOn) {
    audioButtonColor = #33cc33;
    audioButtonOn = true;
    lightButtonOn = false;
    lightButtonColor = #B5B5B5;
    disableLightBanks(0);
    // Enable Lighting Layer Features
  } else if (overRect(audioButtonX, audioButtonY, buttonWidth, buttonHeight) && audioButtonOn) {
    audioButtonColor = #B5B5B5;
    audioButtonOn = false;
    // Disable Lighting Layer Features
  }
  
  
  // Second Layer Tabs
  // Lighting
  activateLighting();

  
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void drawMainTabs() {
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

void drawLights() {
  stroke(#FFFFFF);

  if (lightOnOne) {
    // Display Options
    showLightOptions(1);
    fill(green);
  } else fill(#000000); 
  rect(500, 220, 20, 55);
  fill(#FFFFFF); text("1", 505, 247);
  
  if (lightOnTwo) {
    // Display Options
    showLightOptions(2);
    fill(green);
  } else fill(#000000); 
  rect(500, 295, 20, 55);
  fill(#FFFFFF); text("2", 505, 322);
  
  if (lightOnThree) {
    // Display Options
    showLightOptions(3);
    fill(green);
  } else fill(#000000); 
  rect(500, 370, 20, 55);
  fill(#FFFFFF); text("3", 505, 397);
  
  if (lightOnFour) {
    // Display Options
    showLightOptions(4);
    fill(green);
  } else fill(#000000); 
  rect(640, 145, 20, 55);
  fill(#FFFFFF); text("4", 645, 172);
  
  if (lightOnFive) {
    // Display Options
    showLightOptions(5);
    fill(green);
  } else fill(#000000); 
  rect(640, 220, 20, 55);
  fill(#FFFFFF); text("5", 645, 247);
  
  if (lightOnSix) {
    // Display Options
    showLightOptions(6);
    fill(green);
  } else fill(#000000); 
  rect(640, 295, 20, 55);
  fill(#FFFFFF); text("6", 645, 322);
  
  if (lightOnSeven) {
    // Display Options
    showLightOptions(7);
    fill(green);
  } else fill(#000000); 
  rect(640, 370, 20, 55);
  fill(#FFFFFF); text("7", 645, 397);
}
void disableLightBanks(int exception) {
  if (exception != 1) lightOnOne = false;
  if (exception != 2) lightOnTwo = false;
  if (exception != 3) lightOnThree = false;
  if (exception != 4) lightOnFour = false;
  if (exception != 5) lightOnFive = false;
  if (exception != 6) lightOnSix = false;
  if (exception != 7) lightOnSeven= false;
}

void activateLighting() {
   // 1
  if (overRect(500, 220, 20, 55) && lightButtonOn && !lightOnOne) {
    disableLightBanks(0);
    lightOnOne = true;
  } else if (overRect(500, 220, 20, 55) && lightButtonOn && lightOnOne) {
    disableLightBanks(0);
  }
    // 2
  if (overRect(500, 295, 20, 55) && lightButtonOn && !lightOnTwo) {
    disableLightBanks(0);
    lightOnTwo = true;
  } else if (overRect(500, 295, 20, 55) && lightButtonOn && lightOnTwo) {
    disableLightBanks(0);
  }
    // 3
  if (overRect(500, 370, 20, 55) && lightButtonOn && !lightOnThree) {
    disableLightBanks(0);
    lightOnThree = true;
  } else if (overRect(500, 370, 20, 55) && lightButtonOn && lightOnThree) {
    disableLightBanks(0);
  }
    // 4
  if (overRect(640, 145, 20, 55) && lightButtonOn && !lightOnFour) {
    disableLightBanks(0);
    lightOnFour = true;
  } else if (overRect(640, 145, 20, 55) && lightButtonOn && lightOnFour) {
    disableLightBanks(0);
  }
    // 5
  if (overRect(640, 220, 20, 55) && lightButtonOn && !lightOnFive) {
    disableLightBanks(0);
    lightOnFive = true;
  } else if (overRect(640, 220, 20, 55) && lightButtonOn && lightOnFive) {
    disableLightBanks(0);
  }
    // 6
  if (overRect(640, 295, 20, 55) && lightButtonOn && !lightOnSix) {
    disableLightBanks(0);
    lightOnSix = true;
  } else if (overRect(640, 295, 20, 55) && lightButtonOn && lightOnSix) {
    disableLightBanks(0);
  }
    // 7
  if (overRect(640, 370, 20, 55) && lightButtonOn && !lightOnSeven) {
    disableLightBanks(0);
    lightOnSeven = true;
  } else if (overRect(640, 370, 20, 55) && lightButtonOn && lightOnSeven) {
    disableLightBanks(0);
  } 
  
}

void showLightOptions(int bank) { 
  fill(#FFFFFF); text("Edit \n" + bank, 725, 322);
}