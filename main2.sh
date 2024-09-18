#!/bin/bash

# Script for ethical research purposes only. Ensure you have explicit permission before proceeding.

echo "This script is intended for ethical research purposes only."
echo "Do you have explicit permission to make these changes? (yes/no)"
read permission

if [[ "$permission" != "yes" ]]; then
    echo "Permission not granted. Exiting..."
    exit 1
fi

# Ensure script is run with root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Update and install necessary packages
sudo apt-get update
sudo apt-get install gnupg2 scdaemon opensc -y

# Check if YubiKey is connected
if gpg --card-status &> /dev/null; then
    echo "YubiKey detected. Configuring SSH..."
    # Add YubiKey-stored key to SSH agent
    SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    export SSH_AUTH_SOCK
    gpg-connect-agent updatestartuptty /bye >/dev/null
    echo "SSH key added. You can now use SSH with your YubiKey."
else
    echo "YubiKey not detected. Please insert your YubiKey."
fi

# Remove Chrome policies from the user's config directory
if [ -d "$HOME/.config/google-chrome" ]; then
    rm -rf "$HOME/.config/google-chrome/Policy Files"
    echo "Chrome policies from user config removed."
else
    echo "No Chrome policies found in user config."
fi

# Remove system-wide Chrome policies
if [ -d "/etc/opt/chrome/policies/managed" ]; then
    rm -rf /etc/opt/chrome/policies/managed/*
    echo "Chrome policies from /etc/opt/chrome/policies/managed removed."
else
    echo "No Chrome policies found in /etc/opt/chrome/policies/managed."
fi

if [ -d "/etc/opt/chrome/policies/recommended" ]; then
    rm -rf /etc/opt/chrome/policies/recommended/*
    echo "Chrome policies from /etc/opt/chrome/policies/recommended removed."
else
    echo "No Chrome policies found in /etc/opt/chrome/policies/recommended."
fi

# Additional step: Prompt user to close and reopen Chrome for the changes to take effect
echo "If Chrome is open, please close and reopen it to see if the issue is resolved."
