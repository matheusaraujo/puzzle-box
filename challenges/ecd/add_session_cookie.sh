#!/bin/bash

ecd_add_session_cookie() {
    cookie=$1
    echo "$cookie" > .ecd.session.cookie

    print_line "[Everybody.Codes] Cookie created ${GREEN}✔${NC}"
}