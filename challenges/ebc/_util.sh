#!/bin/bash

available_challenges+=("ebc")
ignore_files+=(".ebc.session.cookie")

ebc_directory() {
    echo "everybody.codes/$year/quest$day"
}

ebc_title() {
    echo "Everybody.Codes $year - Quest $day"
}