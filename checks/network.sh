#!/bin/bash

# ==========================================
# Linux CIS Audit - Network Checks
# ==========================================

# Control 15: IP forwarding
check_ip_forwarding() {
    echo "Checking IP forwarding..."

    ipv4=$(sysctl -n net.ipv4.ip_forward 2>/dev/null)

    if [[ "$ipv4" == "0" ]]; then
        pass "IPv4 forwarding is disabled"
    else
        warn "IPv4 forwarding is enabled"
    fi
}


# Control 16: Listening network services
check_listening_services() {
    echo "Checking listening network services..."

    listening=$(ss -tuln 2>/dev/null)

    if [[ -n "$listening" ]]; then
        info "Listening network sockets detected"
        echo "$listening"
    else
        pass "No listening network sockets found"
    fi
}

