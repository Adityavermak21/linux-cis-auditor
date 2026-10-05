#!/bin/bash

# ==========================================
# Linux CIS Audit - Logging Checks
# ==========================================

# Control 18: System logging service
check_logging_service() {
    echo "Checking system logging service..."

    if systemctl is-active --quiet rsyslog 2>/dev/null; then
        pass "rsyslog is running"
    elif systemctl is-active --quiet systemd-journald 2>/dev/null; then
        pass "systemd-journald is running"
    else
        fail "No active system logging service detected"
    fi
}


# Control 19: auditd installed
check_auditd_installed() {
    echo "Checking auditd installation..."

    if command -v auditd >/dev/null 2>&1; then
        pass "auditd is installed"
    else
        fail "auditd is not installed"
    fi
}


# Control 20: auditd running
check_auditd_running() {
    echo "Checking auditd status..."

    if systemctl is-active --quiet auditd 2>/dev/null; then
        pass "auditd is running"
    else
        fail "auditd is not running"
    fi
}


# Control 21: Authentication logs
check_authentication_logs() {
    echo "Checking authentication logs..."

    if [[ -f /var/log/auth.log ]]; then
        pass "/var/log/auth.log exists"
    elif [[ -f /var/log/secure ]]; then
        pass "/var/log/secure exists"
    else
        warn "Traditional authentication log file not found"
    fi
}


# Control 22: Log file permissions
check_log_permissions() {
    echo "Checking authentication log permissions..."

    found_log=false

    for logfile in /var/log/auth.log /var/log/secure; do
        if [[ -f "$logfile" ]]; then
            permission=$(stat -c "%a" "$logfile")
            info "$logfile permissions: $permission"
            found_log=true
        fi
    done

    if [[ "$found_log" == false ]]; then
        info "No traditional authentication log file found"
    fi
}

