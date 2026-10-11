# Linux Software Update Alert System

## Overview
A Bash-based Linux automation project that checks for available Ubuntu package updates, displays an alert in the terminal, and records the result in a timestamped log file.

## Features
- Checks for available APT package updates.
- Displays the number of available updates.
- Lists packages that can be updated.
- Records the check result with a timestamp.
- Handles package metadata refresh failures.
- Reports available updates without installing them automatically.

## Technologies Used
- Ubuntu Linux
- Bash scripting
- APT package manager
- Git and GitHub

## Requirements
- Ubuntu or another compatible Debian-based Linux distribution.
- Bash shell.
- Administrator privileges to refresh package metadata.

## How to Run

Clone the repository and enter the project directory:

```bash
git clone https://github.com/tamilmalars/linux-update-alert-system.git
cd linux-update-alert-system
```

Make the script executable:

```bash
chmod +x update_alert.sh
```

Run the update check:

```bash
sudo ./update_alert.sh
```

The script refreshes package metadata, lists available package updates, and records the result in `update_alert.log`.

## Safety
This script does not install, upgrade, or remove packages. It only refreshes APT package metadata and reports available updates. Review updates before installing them.

## Project Status
Initial working prototype. Tested on Ubuntu 26.04.1 LTS running under Windows Subsystem for Linux (WSL).
