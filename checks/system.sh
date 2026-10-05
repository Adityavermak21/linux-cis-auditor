#!/bin/bash

# ==========================================
# Linux CIS Audit - System Checks
# ==========================================

# Control 25: Time synchronization
check_time_synchronization() {
    echo "Checking time synchronization..."

    if timedatectl show -p NTPSynchronized --value 2>/dev/null | grep -q "yes"; then
        pass "System time is synchronized"
    else
        warn "System time is not synchronized"
    fi
}


# Control 26: SUID files
check_suid_files() {
    echo "Checking SUID files..."

    suid_files=$(find / -type f -perm -4000 2>/dev/null)

    if [[ -n "$suid_files" ]]; then
        info "SUID files found"
        echo "$suid_files"
    else
        pass "No SUID files found"
    fi
}


# Control 27: SGID files
check_sgid_files() {
    echo "Checking SGID files..."

    sgid_files=$(find / -type f -perm -2000 2>/dev/null)

    if [[ -n "$sgid_files" ]]; then
        info "SGID files found"
        echo "$sgid_files"
    else
        pass "No SGID files found"
    fi
}


# Control 28: Core dumps
check_core_dumps() {
    echo "Checking core dump configuration..."

    core_pattern=$(sysctl -n kernel.core_pattern 2>/dev/null)

    if [[ "$core_pattern" == "|/bin/false" || "$core_pattern" == "|/usr/bin/false" ]]; then
        pass "Core dumps are disabled"
    else
        warn "Core dumps may be enabled"
        echo "Current configuration: $core_pattern"
    fi
}


# Control 29: ASLR
check_aslr() {
    echo "Checking ASLR configuration..."

    aslr=$(sysctl -n kernel.randomize_va_space 2>/dev/null)

    if [[ "$aslr" == "2" ]]; then
        pass "ASLR is fully enabled"
    else
        fail "ASLR is not fully enabled"
    fi
}


