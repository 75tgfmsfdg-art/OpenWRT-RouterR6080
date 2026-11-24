# Routine operation, backup, and recovery

## Record the router state

From LuCI, record the exact device model, hardware revision if shown, OpenWrt version/build, uptime, memory/storage use, WAN status, LAN address, Wi-Fi bands/channel, and connected clients. Keep the record private if it includes public IPs, SSIDs, MAC addresses, or client names.

From an SSH session on the LAN, read-only commands include:

```sh
ubus call system board
cat /etc/openwrt_release
ip -br address
ip route
df -h
free
```

Do not paste secrets, full configuration files, wireless keys, public IPs, or device identifiers into public issues or chat logs.

## Back up before changes

Use **System → Backup / Flash Firmware → Generate archive** in LuCI and download the archive to an encrypted/offline location. Alternatively, the OpenWrt backup guide documents `sysupgrade -b /tmp/backup.tar.gz`; copy the resulting file off the router over the trusted LAN. Treat backups as secrets. Do not add backups to this repository or share them publicly.

Before a sysupgrade, save the installed package list or manifest and any custom files outside the standard configuration set. **Keep settings** normally backs up and restores many files under `/etc/config`, but sysupgrade replaces the system and manually installed packages must be reinstalled. A standard LuCI WireGuard setup stores its interface and peer configuration in `/etc/config/network`, so it is normally included when settings are preserved. Still verify the backup exists and protect it as sensitive data because it can contain private keys. After upgrading, reinstall any missing WireGuard protocol/tools packages and check the tunnel interface, peer handshake, routes, firewall rules, and client connectivity.

Write down the current firmware version and keep a copy of the matching vendor recovery image and/or recovery notes outside the router. A configuration backup is not a firmware image and may not be restorable across different devices or incompatible releases.

## Routine upgrade

### R6080 / WireGuard data-loss prevention checklist

Before flashing, complete every item below and stop if any item is uncertain:

- Export a fresh LuCI backup, download it to encrypted/offline storage, and make a second local copy. Do not upload it to GitHub or send it in chat.
- Check the backup contents/list for `/etc/config/network` (WireGuard interface and peer settings, including router-side private keys), `/etc/config/firewall`, `/etc/config/wireless`, and any other project-specific `/etc/config/*` files.
- Record the installed package list and save the exact package names needed for WireGuard support and LuCI management. Packages installed separately are not carried inside the sysupgrade image and may need to be reinstalled after flashing.
- Back up any custom files outside the standard preserved config set, such as `/etc/wireguard/`, custom firewall includes, hotplug scripts, cron jobs, or files listed in `/etc/sysupgrade.conf`. Keep keys and client profiles private.
- Separately preserve WireGuard client profiles stored on phones/computers. A router backup does not back up those remote client files.
- Keep a recovery route available: a wired computer, the correct R6080 device page, and stable power. Do not start if the backup or recovery path is unavailable.

During the LuCI upgrade, select **Keep settings** only when the device accepts the R6080 sysupgrade image without a warning that indicates an unsupported transition. Stop if the option is unavailable, image compatibility is rejected, or any warning is unclear. Never force an image check.

After reboot, verify the model and release, WAN/LAN/Wi-Fi, the WireGuard interface and peer handshakes, routes, firewall rules, DNS, and one real client connection. Reinstall required packages, then verify any custom service/scripts. Keep the old image and recovery notes until all checks pass.

1. Identify the exact model and current release in LuCI or `ubus call system board`.
2. Check OpenWrt's device page and release notes for current support and known upgrade requirements.
3. Select the exact device's **sysupgrade** image from the official Firmware Selector. Never use another model's file or a factory image for routine in-place upgrades.
4. Verify SHA-256. Ensure power is stable and save a fresh configuration backup.
5. In LuCI, use **Keep settings** only when OpenWrt's upgrade guidance says the current version transition supports it. For major transitions or configuration issues, plan a clean upgrade and manual reconfiguration instead. If you need a fresh setup, do not expect settings or WireGuard private keys to be restored.
6. Let the upgrade finish and reboot without removing power. Reconnect by wired LAN, confirm model/version and WAN/LAN/Wi-Fi operation, reinstall missing packages, then check VPN tunnels, firewall rules, routes, and client connectivity.

## Recovery

For a boot failure, consult the exact device page's failsafe/debrick section. The R6080 device page points to NMRP recovery; its recovery flow is model-specific and requires direct Ethernet. Avoid blind flashing or power removal during a write. If recovery instructions do not match the physical router variant, stop and get model-specific help.

