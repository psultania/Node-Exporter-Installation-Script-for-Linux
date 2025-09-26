
<div align="center"><img width="1536" height="1024" alt="Designer" src="https://github.com/user-attachments/assets/0e8b5387-893a-44a4-a3c2-42197104d8fa" /></div>

# Linux-Node-Exporter-Installation-Script
# Node Exporter Installation Script
Linux Node Exporter Installation Script will install node_exporter on the linux server automatically whichever version you want. This script will also create the service (systemd) script as well. This script will help you running node exporter running on the custom IP Address and PORT. 

What's in this script:
1. User interactive script
2. User Required version will be installed
3. Custom System script will be created automatically.
4. Only 2 step interactive script.

## What `node_exporter.sh` does

- Prompts for a Node Exporter version and downloads that release from the official GitHub.
- Extracts the archive and creates a `current` symlink to the extracted folder in the working directory.
- Detects the machine's primary IP address and stores it in `host`.
- Writes a systemd unit at `/etc/systemd/system/node_exporter.service` that runs `node_exporter` bound to `$host:9100`.
- Reloads systemd, starts the service, and shows its status.

Notes:
- The service `ExecStart` defaults to `/opt/platform/nodeexporter/current/node_exporter`. Adjust this path or move the extracted files so that this binary exists at that location.
- Replace `service_account_name` and `service_group_name` in the unit with valid user/group names on your system.

## Prerequisites

- A Linux host using systemd with root or sudo access
- `wget` and `tar` installed
- Outbound internet access to `github.com`

## How to run the script

1. Make the script executable:
   ```bash
   chmod +x node_exporter.sh
   ```
2. Run it as root (or with sudo):
   ```bash
   sudo ./node_exporter.sh
   ```
3. When prompted, enter the Node Exporter version to install (e.g., `1.8.1`).
4. Verify the service status:
   ```bash
   sudo systemctl status node_exporter.service
   ```
5. Validate metrics endpoint (replace `<host>` with your IP or hostname):
   ```bash
   curl http://<host>:9100/metrics
   ```

Optional:
- Enable service at boot: `sudo systemctl enable node_exporter.service`
- To listen on all interfaces, change the listen address in the unit to `:9100`.
