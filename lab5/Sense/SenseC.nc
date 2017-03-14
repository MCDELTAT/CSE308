/*
 * Copyright (c) 2006, Technische Universitaet Berlin
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 * - Neither the name of the Technische Universitaet Berlin nor the names
 *   of its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * - Revision -------------------------------------------------------------
 * $Revision: 1.4 $
 * $Date: 2006-12-12 18:22:49 $
 * @author: Jan Hauer
 * ========================================================================
 */

/**
 *
 * Sensing demo application. See README.txt file in this directory for usage
 * instructions and have a look at tinyos-2.x/doc/html/tutorial/lesson5.html
 * for a general tutorial on sensing in TinyOS.
 *
 * @author Jan Hauer
 */

#include "Timer.h"
#include "Sense.h"

module SenseC
{
  uses {
    interface Boot;
    interface SplitControl as RadioControl;
    interface AMSend;
    interface Receive;
    interface Timer<TMilli>;
    interface Read<uint16_t>;
    interface Leds;
  }
}
implementation
{
  message_t sendBuf;
  bool sendBusy;

  /* Current local state - interval, version and accumulated readings */
  sense_t local;

  uint8_t reading; /* 0 to NREADINGS */

  bool suppressCountChange;

  // Use LEDs to report various status issues.
  void report_problem() { call Leds.led0Toggle(); }
  void report_sent() { call Leds.led1Toggle(); }
  void report_received() { call Leds.led2Toggle(); }

  event void Boot.booted() {
    local.interval = DEFAULT_INTERVAL;
    local.id = TOS_NODE_ID;
    if (call RadioControl.start() != SUCCESS)
      report_problem();
  }

  void startTimer() {
    call Timer.startPeriodic(local.interval);
    reading = 0; //here so that reading can be reset
  }

  event void RadioControl.startDone(error_t error) {
    startTimer();
  }

  event void RadioControl.stopDone(error_t error) {
  }

  event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len) {
    sense_t *omsg = payload;

    report_received();

    /* If we receive a newer version, update our interval.
       If we hear from a future count, jump ahead but suppress our own change
    */
    if (omsg->version > local.version) {
	    local.version = omsg->version;
	    local.interval = omsg->interval;
	    startTimer();
    }
    if (omsg->count > local.count) {
	    local.count = omsg->count;
	    suppressCountChange = TRUE;
    }

    return msg;
  }

  event void Timer.fired()
  {
    if (reading == NREADINGS) {
      if (!sendBusy && sizeof local <= call AMSend.maxPayloadLength()) {
        // Don't need to check for null because we've already checked
        // length above
        memcpy(call AMSend.getPayload(&sendBuf, sizeof(local)), &local, sizeof local);
        if (call AMSend.send(AM_BROADCAST_ADDR, & sendBuf, sizeof local) == SUCCESS)
          sendBusy = TRUE;
      }
      if (!sendBusy)
        report_problem();

      reading = 0;
      /* Part 2 of cheap "time sync": increment our count if we didn't
        jump ahead */
      if (!suppressCountChange) {
        local.count++;
      }
      suppressCountChange = FALSE;
    }
    if (call Read.read() != SUCCESS) {
      report_problem();
    }
  }

  event void AMSend.sendDone(message_t* msg, error_t error) {
    if (error == SUCCESS) {
      report_sent();
    } else {
      report_problem();
    }

    sendBusy = FALSE;
  }

  event void Read.readDone(error_t result, uint16_t data)
  {
    if (result != SUCCESS) {
      data = 0xffff;
      report_problem();
    }
    if (reading < NREADINGS) {
      local.readings[reading++] = data;
    }
  }
}
