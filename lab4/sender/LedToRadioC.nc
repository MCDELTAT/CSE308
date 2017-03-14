#include <Timer.h>
#include "LedToRadio.h"

module LedToRadioC {
  uses interface Boot;
  uses interface Leds;
  uses interface Timer<TMilli> as Timer0;
  uses interface Packet;
  uses interface AMPacket;
  uses interface AMSend;
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
      call Timer0.startPeriodic(TIMER_PERIOD_MILLI);
    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
  }

  event void Timer0.fired() {
    counter++;
    if (!busy) {
      LedToRadioMsg* btrpkt = (LedToRadioMsg*)(call Packet.getPayload(&pkt, sizeof (LedToRadioMsg)));
      btrpkt->nodeid = TOS_NODE_ID;
      btrpkt->counter = counter;
      if (call AMSend.send(AM_DEST_ADDR, &pkt, sizeof(LedToRadioMsg)) == SUCCESS) {
        // Set Red LED (LED0)
        call Leds.led0On();
        busy = TRUE;
      }
    }
  }

  // Automatically called event flag for when send is completed
  event void AMSend.sendDone(message_t* msg, error_t error) {
    if (&pkt == msg) {
      // Turn off the led to indicate the send is completed
      call Leds.led0Off();
      busy = FALSE;
    }
  }
}
