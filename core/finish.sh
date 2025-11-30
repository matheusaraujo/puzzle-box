#!/bin/bash

pb_finish() {
  validate_challenge
  validate_year
  validate_day

  ${challenge}_finish
}
