#!/bin/bash

# ==========================================
# Linux CIS Audit - SSH Checks
# ==========================================

# Control 11: SSH root login
check_ssh_root_login() {
    echo "Checking SSH root login..."

    setting=$(sshd -T 2>/dev/null | awk '$1 == "permitrootlogin" {print $2}')

    if [[ "$setting" == "no" ]]; then
        pass "SSH root login is disabled"
    else
        fail "SSH root login is not disabled"
    fi
}


# Control 12: SSH password authentication
check_ssh_password_authentication() {
    echo "Checking SSH password authentication..."

    setting=$(sshd -T 2>/dev/null | awk '$1 == "passwordauthentication" {print $2}')

    if [[ "$setting" == "no" ]]; then
        pass "SSH password authentication is disabled"
    else
        warn "SSH password authentication is enabled"
    fi
}


# Control 13: SSH empty passwords
check_ssh_empty_passwords() {
    echo "Checking SSH empty password authentication..."

    setting=$(sshd -T 2>/dev/null | awk '$1 == "permitemptypasswords" {print $2}')

    if [[ "$setting" == "no" ]]; then
        pass "SSH empty passwords are disabled"
    else
        fail "SSH empty passwords are permitted"
    fi
}


# Control 14: SSH X11 forwarding
check_ssh_x11_forwarding() {
    echo "Checking SSH X11 forwarding..."

    setting=$(sshd -T 2>/dev/null | awk '$1 == "x11forwarding" {print $2}')

    if [[ "$setting" == "no" ]]; then
        pass "SSH X11 forwarding is disabled"
    else
        warn "SSH X11 forwarding is enabled"
    fi
}

