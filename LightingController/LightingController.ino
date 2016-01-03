#include "BusNet.h"

byte device_id = 0x20; // this has to be unique to busnet
BusNet busnet;

boolean debug = 0;

float dutyCycle = .5; // how many millis on
int cycleLength = 200; // cycle length in milliseconds
int lastMillis = 0;

unsigned long currentMicros = 0;
unsigned long cycleStart = 0;
unsigned long cycleTrigger = 0;
unsigned long cycleStop = 0;

void setup() {
  pinMode(13,OUTPUT);  // this is our test onboard LED
  
  busnet.setup(device_id);
}

void loop() {
  
  if (dutyCycle == 1) digitalWrite(13,HIGH);
  else if (dutyCycle == 0) digitalWrite(13,LOW);
  else {
    currentMicros = micros();  // TODO: we will need to handle overflows eventually
    if (currentMicros > cycleStop) {
      // reset variables
      cycleStart = currentMicros;
      cycleTrigger = currentMicros + (dutyCycle*cycleLength);
      cycleStop = currentMicros+cycleLength;
      digitalWrite(13,HIGH);
    }
    else {
      if (currentMicros < cycleTrigger) digitalWrite(13,HIGH);
      else digitalWrite(13,LOW);
    }
  }
}


void serialEvent() {
  busnet.update();
  if (busnet.updateAvailable()) {
    dutyCycle = busnet.getUpdate();
  }
}
