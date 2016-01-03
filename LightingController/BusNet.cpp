
#include "Arduino.h"
#include "BusNet.h"

BusNet::BusNet() {
  return;
  
}

void BusNet::setup(byte id) {
  
  this->device_id = id;
  
  Serial.begin(9600);
  Serial.println();  // flush it out
  Serial.print("BUSNET SERIAL V0.1: DID ");
  Serial.println(this->device_id,BIN);
  
}

void BusNet::update() {
  while (Serial.available()) {
    char c = Serial.read();
    if ((byte)c!=0xFF) { this->serialCache += c; }
    else { this->serialComplete = true; this->parse(); } // serialComplete may not be needed
  }
}

void BusNet::parse() {
  
  this->sender_id = this->serialCache[0];
  this->receiver_id = this->serialCache[1];
  
  // Check if this message is meant for us
  if (this->device_id == this->receiver_id) {
    
    // range from 0 to 64
    this->newDuty = ((float)this->serialCache[2]) / 100;
    if (this->newDuty > 1) this->newDuty = 1;
    else if (this->newDuty < 0) this->newDuty = 0;
    
    updateReady = true;
  }
  
  // Reset variables
  this->serialComplete = false;
  this->serialCache = "";
}

bool BusNet::updateAvailable() {
  if (this->updateReady) return true;
  else return false;
}

float BusNet::getUpdate() {
  this->updateReady = false;
  return this->newDuty;
}
