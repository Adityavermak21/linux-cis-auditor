#!/bin/bash

# ==========================================
# Linux CIS Audit - Service Checks
# ==========================================

# Control 23: Running services
check_running_services() {
    echo "Checking running services..."

    services=$(systemctl list-units --type=service --state=running --no-legend 2>/dev/null)

    if [[ -n "$services" ]]; then
        info "Running services detected"
        echo "$services"
    else
        warn "Unable to retrieve running services"
    fi
}


# Control 24: Enabled services
check_enabled_services() {
    echo "Checking enabled services..."

    services=$(systemctl list-unit-files --type=service --state=enabled --no-legend 2>/dev/null)

    if [[ -n "$services" ]]; then
        info "Enabled services detected"
        echo "$services"
    else
        warn "Unable to retrieve enabled services"
    fi
}


