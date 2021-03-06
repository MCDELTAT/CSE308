#include <Timer.h>
#include "LedToRadio.h"

configuration LedToRadioAppC {
}
implementation {
  components MainC;
  components LedsC;
  components LedToRadioC as App;
  components new TimerMilliC() as Timer0;
  components ActiveMessageC;
  components new AMSenderC(AM_LEDTORADIOMSG);
  components new DemoSensorC() as Sensor;

  App.Boot -> MainC;
  App.Leds -> LedsC;
  App.Timer0 -> Timer0;
  App.Packet -> AMSenderC;
  App.AMPacket -> AMSenderC;
  App.AMSend -> AMSenderC;
  App.AMControl -> ActiveMessageC;
  App.Read -> Sensor;
}
