#include <Timer.h>
#include "LedToRadio.h"

configuration LedToRadioAppC {
}
implementation {
  components MainC;
  components LedsC;
  components LedToRadioC as App;
  components ActiveMessageC;
  components new AMReceiverC(AM_BLINKTORADIO);

  App.Boot -> MainC;
  App.Leds -> LedsC;
  App.Receive -> AMReceiverC;
  App.AMControl -> ActiveMessageC;
}
