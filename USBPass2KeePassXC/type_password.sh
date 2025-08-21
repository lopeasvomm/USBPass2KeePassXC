#!/bin/bash
# type_password.sh - Securely automate password entry from KeePassXC to USB keyboard

set -e

read -p "Path to KeePassXC database (.kdbx): " DB_PATH
if [ ! -f "$DB_PATH" ]; then
    echo "Database file not found!"
    exit 1
fi

# List entries for user selection
echo "Available entries:"
ENTRIES=$(keepassxc-cli ls "$DB_PATH" 2>/dev/null | grep -v '^$')
if [ -z "$ENTRIES" ]; then
    echo "No entries found or database is locked."
    exit 1
fi
select ENTRY in $ENTRIES; do
    if [ -n "$ENTRY" ]; then
        break
    fi
    echo "Invalid selection."
done

# Prompt for master password securely (not exposed in process list)
read -s -p "Master password: " MASTERPW
echo

# Extract password using keepassxc-cli (use a file descriptor to avoid exposing password)
PASSWORD=$( (echo "$MASTERPW" | keepassxc-cli show -s -a Password "$DB_PATH" "$ENTRY") 2>/dev/null )

unset MASTERPW

if [ -z "$PASSWORD" ]; then
    echo "Failed to retrieve password. Check entry name and master password."
    exit 1
fi

# Type the password using the HID script
python3 /home/pi/send_keys.py "$PASSWORD"

echo "Password sent via USB keyboard emulation."
