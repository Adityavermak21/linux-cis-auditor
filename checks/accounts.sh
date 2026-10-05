#!/bin/bash

# ==========================================
# Linux CIS Audit - Account Checks
# ==========================================

# Control 5: UID 0 accounts
check_uid_zero_accounts() {
    echo "Checking for UID 0 accounts..."

    uid_zero=$(awk -F: '$3 == 0 {print $1}' /etc/passwd)

    if [[ "$uid_zero" == "root" ]]; then
        pass "Only root has UID 0"
    else
        warn "Additional UID 0 accounts found: $uid_zero"
    fi
}


# Control 6: Empty password accounts
check_empty_password_accounts() {
    echo "Checking for accounts with empty passwords..."

    empty_passwords=$(awk -F: '$2 == "" {print $1}' /etc/shadow 2>/dev/null)

    if [[ -z "$empty_passwords" ]]; then
        pass "No accounts with empty passwords found"
    else
        fail "Accounts with empty passwords found: $empty_passwords"
    fi
}


# Control 7: Interactive login accounts
check_inactive_accounts() {
    echo "Checking for interactive login accounts..."

    interactive=$(awk -F: '$7 != "" && $7 !~ /(nologin|false)$/ {print $1}' /etc/passwd)

    if [[ -n "$interactive" ]]; then
        info "Accounts with interactive login shells: $interactive"
    else
        pass "No unexpected interactive accounts found"
    fi
}

