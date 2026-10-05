#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# ======================================
# Result Counters
# ======================================

PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0
INFO_COUNT=0


# ======================================
# Result Functions
# ======================================

pass() {
    echo "PASS - $1"
    ((PASS_COUNT++))
}

fail() {
    echo "FAIL - $1"
    ((FAIL_COUNT++))
}

warn() {
    echo "WARN - $1"
    ((WARN_COUNT++))
}

info() {
    echo "INFO - $1"
    ((INFO_COUNT++))
}


# ======================================
# Load audit checks
# ======================================

source "$SCRIPT_DIR/checks/permissions.sh"
source "$SCRIPT_DIR/checks/accounts.sh"
source "$SCRIPT_DIR/checks/password.sh"
source "$SCRIPT_DIR/checks/ssh.sh"
source "$SCRIPT_DIR/checks/network.sh"
source "$SCRIPT_DIR/checks/firewall.sh"
source "$SCRIPT_DIR/checks/logging.sh"
source "$SCRIPT_DIR/checks/services.sh"
source "$SCRIPT_DIR/checks/system.sh"


# ======================================
# Audit Header
# ======================================

echo "======================================"
echo "        Linux CIS Security Audit"
echo "======================================"
echo

echo "Starting security audit..."
echo


# ======================================
# FILE PERMISSIONS
# ======================================

echo "----- File Permissions -----"

check_passwd_permissions
check_shadow_permissions
check_group_permissions
check_world_writable_files


# ======================================
# ACCOUNT SECURITY
# ======================================

echo
echo "----- Account Security -----"

check_uid_zero_accounts
check_empty_password_accounts
check_inactive_accounts


# ======================================
# PASSWORD POLICY
# ======================================

echo
echo "----- Password Policy -----"

check_password_max_age
check_password_min_length
check_password_min_age


# ======================================
# SSH SECURITY
# ======================================

echo
echo "----- SSH Security -----"

check_ssh_root_login
check_ssh_password_authentication
check_ssh_empty_passwords
check_ssh_x11_forwarding


# ======================================
# NETWORK SECURITY
# ======================================

echo
echo "----- Network Security -----"

check_ip_forwarding
check_listening_services


# ======================================
# FIREWALL
# ======================================

echo
echo "----- Firewall -----"

check_firewall_status


# ======================================
# LOGGING & AUDITING
# ======================================

echo
echo "----- Logging & Auditing -----"

check_logging_service
check_auditd_installed
check_auditd_running
check_authentication_logs
check_log_permissions


# ======================================
# SERVICES
# ======================================

echo
echo "----- Services -----"

check_running_services
check_enabled_services


# ======================================
# SYSTEM SECURITY
# ======================================

echo
echo "----- System Security -----"

check_time_synchronization
check_suid_files
check_sgid_files
check_core_dumps
check_aslr


# ======================================
# AUDIT SUMMARY
# ======================================

echo
echo "======================================"
echo "           AUDIT SUMMARY"
echo "======================================"

echo "PASS : $PASS_COUNT"
echo "FAIL : $FAIL_COUNT"
echo "WARN : $WARN_COUNT"
echo "INFO : $INFO_COUNT"

echo
echo "======================================"
echo "        Audit completed."
echo "======================================"

