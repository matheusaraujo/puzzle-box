#!/bin/bash

pb_create() {
    validate_challenge
    validate_event
    validate_day
    validate_lang
    "${challenge}_validate_event_day"

    "${challenge}_create"
}
