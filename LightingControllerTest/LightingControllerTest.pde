import processing.serial.*;

Serial myPort;  // Create object from Serial class
int backgroundColor = 0;
byte fadeLevel = 0x00;
boolean increase = true;

void setup() 
{
  size(200, 200);
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(backgroundColor);
  if (direction)
  delay(100);
}

void sendFade(byte v) {
  myPort.write(0x00); // sender_id
  myPort.write(0x20); // receiver_id of the lighting controller
  myPort.write(v);
  myPort.write(0xFF); // send line termination character
}