#!/bin/bash

pb_create() {
    validate_challenge
    validate_year
    validate_day
    validate_lang
    "${challenge}_validate"

    "${challenge}_create"
}
