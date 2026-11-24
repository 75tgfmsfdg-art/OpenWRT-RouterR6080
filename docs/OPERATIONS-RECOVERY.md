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

Write down the current firmware version and keep a copy of the matching vendor recovery image and/or recovery notes outside the router. A configuration backup is not a firmware image and may not be restorable across different devices or incompatible releases.

## Routine upgrade

1. Identify the exact model and current release in LuCI or `ubus call system board`.
2. Check OpenWrt's device page and release notes for current support and known upgrade requirements.
3. Select the exact device's **sysupgrade** image from the official Firmware Selector. Never use another model's file or a factory image for routine in-place upgrades.
4. Verify SHA-256. Ensure power is stable and save a fresh configuration backup.
5. In LuCI, use **Keep settings** only when OpenWrt's upgrade guidance says the current version transition supports it. For major transitions or configuration issues, plan a clean upgrade and manual reconfiguration instead.
6. Let the upgrade finish and reboot without removing power. Reconnect by wired LAN, confirm model/version and WAN/LAN/Wi-Fi operation, and review system logs.

## Recovery

For a boot failure, consult the exact device page's failsafe/debrick section. The R6080 device page points to NMRP recovery; its recovery flow is model-specific and requires direct Ethernet. Avoid blind flashing or power removal during a write. If recovery instructions do not match the physical router variant, stop and get model-specific help.

