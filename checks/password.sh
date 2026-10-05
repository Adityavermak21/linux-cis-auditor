#!/bin/bash

# ==========================================
# Linux CIS Audit - Password Policy Checks
# ==========================================

# Control 8: Password maximum age
check_password_max_age() {
    echo "Checking password maximum age..."

    max_age=$(grep -E '^PASS_MAX_DAYS' /etc/login.defs | awk '{print $2}')

    if [[ -n "$max_age" && "$max_age" -le 365 ]]; then
        pass "PASS_MAX_DAYS is set to $max_age"
    else
        warn "PASS_MAX_DAYS is not configured within expected range"
    fi
}


# Control 9: Password minimum length
check_password_min_length() {
    echo "Checking password minimum length..."

    min_length=$(grep -E '^PASS_MIN_LEN' /etc/login.defs | awk '{print $2}')

    if [[ -n "$min_length" && "$min_length" -ge 14 ]]; then
        pass "Minimum password length is $min_length"
    else
        warn "Minimum password length is not set to 14 or greater"
    fi
}


# Control 10: Password minimum age
check_password_min_age() {
    echo "Checking password minimum age..."

    min_age=$(grep -E '^PASS_MIN_DAYS' /etc/login.defs | awk '{print $2}')

    if [[ -n "$min_age" && "$min_age" -ge 1 ]]; then
        pass "PASS_MIN_DAYS is set to $min_age"
    else
        warn "PASS_MIN_DAYS is not set appropriately"
    fi
}

