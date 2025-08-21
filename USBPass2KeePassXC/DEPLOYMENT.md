
# Deployment Instructions

1. Ensure you have Ansible installed on your control machine (not the Pi):
   ```bash
   sudo apt update
   sudo apt install ansible
   ```

2. Place `ansible-setup.yml`, `send_keys.py`, and `type_password.sh` in the same directory on your control machine.

3. Run the playbook directly against your Pi (no inventory file needed):
   ```bash
   ansible-playbook -i 'pi-hostname-or-ip,' -u pi --ask-pass --ask-become-pass ansible-setup.yml
   ```
   - Replace `pi-hostname-or-ip` with your Pi’s hostname or IP address.
   - The trailing comma is required.
   - `--ask-pass` and `--ask-become-pass` will prompt for SSH and sudo passwords.

4. After the playbook completes and the Pi reboots, your Pi will be ready for use as a USB keyboard password device.


## Platform and Version Information

See the main README.md for all platform, hardware, and version requirements. This ensures a single source of truth for all deployment and compatibility details.
