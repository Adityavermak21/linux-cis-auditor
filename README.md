# Linux CIS Hardening Auditor

A lightweight **Bash-based Linux security auditing tool** that checks selected Linux security configurations against simplified CIS-inspired security requirements.

The project is designed for learning, cybersecurity auditing practice, and understanding basic Linux security hardening concepts.

## Features

* Linux security configuration auditing
* File and permission checks
* User and account checks
* Password policy checks
* SSH security checks
* Firewall checks
* Service checks
* Network security checks
* Logging configuration checks
* PASS / FAIL / WARNING results
* Security audit summary
* Simple report generation

## Technology

* Bash
* Linux
* Standard Linux utilities

## Project Structure

```text
linux_cis_audit/
│
├── cisaudit.sh
│
├── checks/
│   ├── accounts.sh
│   ├── firewall.sh
│   ├── logging.sh
│   ├── network.sh
│   ├── password.sh
│   ├── permissions.sh
│   ├── services.sh
│   ├── ssh.sh
│   └── system.sh
│
├── lib/
│
├── reports/
│
├── .gitignore
└── README.md
```

## How It Works

The main script, `cisaudit.sh`, loads the security-check modules from the `checks/` directory.

Each module performs specific Linux security checks and reports the result.

The basic workflow is:

```text
Linux System
     │
     ▼
cisaudit.sh
     │
     ├── Permission Checks
     ├── Account Checks
     ├── Password Checks
     ├── SSH Checks
     ├── Firewall Checks
     ├── Service Checks
     ├── Network Checks
     ├── Logging Checks
     └── System Checks
     │
     ▼
PASS / FAIL / WARNING
     │
     ▼
Audit Summary
```

## Installation

Clone the repository:

```bash
git clone <YOUR-GITHUB-REPOSITORY-URL>
cd linux_cis_audit
```

Make the main script executable:

```bash
chmod +x cisaudit.sh
```

## Usage

Run the auditor with root privileges:

```bash
sudo ./cisaudit.sh
```

Some checks require root privileges because they inspect protected Linux configuration files.

## Example

```text
========================================
       Linux CIS Security Auditor
========================================

Starting security audit...

[PASS] /etc/passwd permissions
[PASS] /etc/shadow permissions
[FAIL] Password policy
[PASS] SSH configuration
[PASS] Firewall configuration
[WARNING] Service requires manual review

========================================
             AUDIT SUMMARY
========================================
Total Checks : 29
Passed       : 23
Failed       : 4
Warnings     : 2
```

*The example above is illustrative; actual results depend on the Linux system being audited.*

## Security Approach

This project follows a simple auditing model:

```text
CHECK → EVALUATE → REPORT → RECOMMEND
```

It is an **auditing tool**, not an automatic hardening tool.

The project does not automatically modify system configuration.

## Scope

This project implements a selected set of Linux security checks inspired by common CIS Linux security recommendations.

It is **not a complete implementation of the CIS Benchmark** and should not be considered a formal CIS compliance certification tool.

Some security requirements may require manual verification.

## Why Bash?

Bash was selected because it provides direct access to common Linux security utilities and configuration files.

It also makes the relationship between a security requirement and its technical check easy to understand.

## Example Security Checks

The project can inspect areas such as:

* File permissions
* User accounts
* Password configuration
* SSH configuration
* Firewall status
* Running services
* Network parameters
* System configuration
* Logging configuration

## Limitations

* Only selected security controls are implemented.
* Some checks require manual verification.
* Results depend on the Linux distribution and configuration.
* The project does not automatically remediate failed checks.
* It is intended for educational and basic auditing purposes.

## Future Improvements

Possible future improvements include:

* More CIS controls
* HTML reports
* JSON report generation
* Improved control metadata
* Automated test cases
* Support for additional Linux distributions
* More detailed remediation recommendations

## Disclaimer

Use this tool only on Linux systems that you own or are authorized to audit.

The project is intended for educational, defensive security auditing, and authorized security assessment purposes.
