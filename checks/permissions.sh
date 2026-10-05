#!/bin/bash

# ==========================================
# Linux CIS Audit - File Permissions Checks
# ==========================================

# Control 1: /etc/passwd permissions
check_passwd_permissions() {
    echo "Checking /etc/passwd permissions..."

    permission=$(stat -c "%a" /etc/passwd)

    if [[ "$permission" == "644" ]]; then
        pass "/etc/passwd permissions are $permission"
    else
        fail "/etc/passwd permissions are $permission (expected 644)"
    fi
}


# Control 2: /etc/shadow permissions
check_shadow_permissions() {
    echo "Checking /etc/shadow permissions..."

    permission=$(stat -c "%a" /etc/shadow)

    if [[ "$permission" == "640" || "$permission" == "600" ]]; then
        pass "/etc/shadow permissions are $permission"
    else
        fail "/etc/shadow permissions are $permission (expected 640 or stricter)"
    fi
}


# Control 3: /etc/group permissions
check_group_permissions() {
    echo "Checking /etc/group permissions..."

    permission=$(stat -c "%a" /etc/group)

    if [[ "$permission" == "644" ]]; then
        pass "/etc/group permissions are $permission"
    else
        fail "/etc/group permissions are $permission (expected 644)"
    fi
}


# Control 4: World-writable files
check_world_writable_files() {
    echo "Checking for world-writable files..."

    world_writable=$(find / -type f -perm -0002 2>/dev/null)

    if [[ -z "$world_writable" ]]; then
        pass "No world-writable files found"
    else
        warn "World-writable files found:"
        echo "$world_writable"
    fi
}

