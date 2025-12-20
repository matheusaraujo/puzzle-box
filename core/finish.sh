#!/bin/bash

pb_finish() {
  validate_challenge
  validate_event
  validate_puzzle

  ${challenge}_finish
}
