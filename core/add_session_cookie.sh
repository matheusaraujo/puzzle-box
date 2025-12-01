#!/bin/bash

pb_add_session_cookie() {
    validate_challenge

    print_line "enter token for $challenge (Ctrl+D to finish):"
    cookie=$(cat)

    ${challenge}_add_session_cookie $cookie
}