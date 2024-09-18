# YubiKeyPolicyBypass
This script checks if a YubiKey is connected and configures the associated SSH key, adding it to the SSH agent. If no YubiKey is detected, the script prompts for insertion and includes a bypass placeholder. It also removes Chrome policies from both user-specific directories ($HOME/.config) and system-wide directories (/etc/opt/chrome).

Usage: Supports Linux environments.

Clone the repository
git clone https://github.com/SleepTheGod/YubiKeyPolicyBypass

Navigate to the directory
cd YubiKeyPolicyBypass

Make the script executable
chmod +x main.sh && chmod +x main2.sh

Execute the script
./main.sh; ./main2.sh;
