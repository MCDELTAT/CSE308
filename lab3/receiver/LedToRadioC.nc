#include <Timer.h>
#include "LedToRadio.h"

module LedToRadioC {
  uses interface Boot;
  uses interface Leds;
  uses interface Packet;
  uses interface AMPacket;
  uses interface Receive;
  uses interface SplitControl as AMControl;
}

implementation {
  bool busy = FALSE;
  message_t pkt;
  uint16_t counter = 0;

  event void Boot.booted() {
    call AMControl.start();
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
  }

  event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len) {
    if (len == sizeof(LedToRadioMsg)) {
      LedToRadioMsg* btrpkt = (LedToRadioMsg*)payload;
      if (btrpkt->nodeid == 7) {
        // Only blink the Leds on the reciever
        call Leds.set(btrpkt->counter);
      }
    }
    return msg;
  }
}
