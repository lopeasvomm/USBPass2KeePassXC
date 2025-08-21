## Security Note: USB HID Only

When configured as described, the Pi Zero only presents itself as a USB keyboard (HID) to the target host. The target system cannot access the Pi’s files, shell, or network—only the emulated keyboard interface is exposed. Do not enable other USB gadget functions (like mass storage, serial, or networking) if you want to maintain this isolation.
## Platform and Version Information

- **Raspberry Pi Model:** Pi Zero or Pi Zero W (required for USB gadget mode)
- **Storage:** Minimum 8GB microSD card (16GB+ recommended for logs/backups)
- **Cable:** USB A to micro-USB data cable (not just charging cable) for connecting Pi Zero to the target host.
  - On the Pi Zero, there are two micro-USB ports: one labeled "PWR IN" (for power only) and one labeled "USB" (for data and USB devices).
  - You must plug the cable into the port labeled "USB" (not "PWR IN"). This is the only port that supports USB gadget mode and will allow the Pi to act as a keyboard.
- **Raspberry Pi OS:** Bookworm or Bullseye (32-bit, latest stable)
- **Python:** 3.9 or newer (default on recent Pi OS)
- **KeePassXC:** 2.6.x or newer (from official repos)
- **pyusb:** 1.2.x or newer (installed via pip3)
- **Ansible:** 2.10 or newer (on control machine)
- **send_keys.py:** See this repo, keep updated
- **type_password.sh:** See this repo, keep updated

Update these version numbers and hardware details as you upgrade components or encounter issues.
# USB Keyboard Password Pass-Through for KeePassXC

## Problem Statement
Most password managers run on the same device as browsers and other applications. If that device is compromised, the password manager and all stored credentials are at risk.

## Proposed Solution
- Run the password manager (e.g., KeePassXC) on a dedicated, secure device.
- When a password is needed, the device emulates a USB keyboard (HID device) and types the password directly into the target system.
- This avoids using the clipboard or network, reducing the attack surface and making it easier to use long, complex passwords.

## Key Requirements
1. The secure device must emulate a USB keyboard.
2. The password manager must be able to send the password to the emulated keyboard for output.
3. The workflow should be simple and secure for the user.


## Usage Instructions

### 1. Prepare your KeePassXC database
Copy your `.kdbx` database file to the Pi.


### 2. Run the automation script
```bash
./type_password.sh
```
You will be prompted for:
- The path to your KeePassXC database
- The entry to use (select from a list)
- The master password (entered securely)

If successful, the password will be typed into the connected system via USB keyboard emulation.

### Security Notes
- The master password is read securely and not exposed in the process list.
- The script lists available entries for easier selection.
- Error handling is included for missing files and failed lookups.
