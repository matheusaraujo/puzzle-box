#!/bin/bash

pb_finish() {
  validate_challenge
  validate_event
  validate_day

  ${challenge}_finish
}
