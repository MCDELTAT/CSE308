#ifndef LEDTORADIO_H
#define LEDTORADIO_H

enum {
 AM_BLINKTORADIO = 6,
 TIMER_PERIOD_MILLI = 1000
};

typedef nx_struct LedToRadioMsg {
 nx_uint16_t nodeid;
 nx_uint16_t counter;
} LedToRadioMsg;

#endif
