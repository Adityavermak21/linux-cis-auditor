#!/bin/bash

# ==========================================
# Linux CIS Audit - Firewall Checks
# ==========================================

# Control 17: Firewall status
check_firewall_status() {
    echo "Checking firewall status..."

    if command -v ufw >/dev/null 2>&1; then
        status=$(ufw status 2>/dev/null)

        if echo "$status" | grep -q "Status: active"; then
            pass "UFW firewall is active"
        else
            fail "UFW firewall is not active"
        fi

    elif command -v nft >/dev/null 2>&1; then
        rules=$(nft list ruleset 2>/dev/null)

        if [[ -n "$rules" ]]; then
            pass "nftables ruleset is present"
        else
            warn "nftables is installed but no ruleset was detected"
        fi

    else
        warn "No supported firewall tool detected"
    fi
}

