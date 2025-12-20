#!/bin/bash

pb_create() {
    validate_challenge
    validate_event
    validate_puzzle
    validate_lang
    "${challenge}_validate_event_puzzle"

    "${challenge}_create"
}
