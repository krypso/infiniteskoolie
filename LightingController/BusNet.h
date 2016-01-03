/*
  BUSNET HEADER FILE
*/

#ifndef BusNet_h
#define BusNet_h

#include "Arduino.h"

class BusNet {
  public:
    BusNet();
    void setup(byte);
    void update();
    void parse();
    bool updateAvailable();
    float getUpdate();
  private:
    byte device_id;
    String serialCache;  // cache for holding unparsed string
    bool serialComplete; // is the serial string ready for parsing?
    
    bool updateReady; // is there an update ready for the board
    float newDuty; // new duty cycle for the led
    
    byte sender_id;
    byte receiver_id;
};

#endif
