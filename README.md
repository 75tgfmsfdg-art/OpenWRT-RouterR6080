# OpenWrt NETGEAR R6080 Field Kit

Cross-platform notes for identifying, installing, maintaining, backing up, and recovering OpenWrt on the NETGEAR R6080. The same workflow is provided for Windows, macOS, and Linux hosts.

This is a community field guide. It is not an official OpenWrt or NETGEAR project and is not endorsed by either organization.

> **Hardware check first:** The R6080-specific instructions apply only when the label on the physical router says **NETGEAR R6080**. A firmware filename in a download folder does not establish the router model. Do not flash any image until the exact model has been checked on the device label and in the OpenWrt Table of Hardware.

## Contents

- [Identify and install](docs/INSTALL-R6080.md)
- [Cross-platform host setup](docs/CROSS-PLATFORM.md)
- [Routine operation and recovery](docs/OPERATIONS-RECOVERY.md)
- [Privacy and safe sharing](docs/PRIVACY.md)
- [Verified upstream source repositories and package feeds](docs/RESOURCES.md)
- `scripts/verify-firmware.ps1` and `scripts/verify-firmware.sh` — local SHA-256 checks; they do not download or flash firmware.

## Quick route

1. Confirm the router model and hardware revision from its label.
2. Read the current R6080 device page and release notes linked below.
3. Download the exact R6080 image from OpenWrt's official Firmware Selector or downloads site. Follow the R6080-specific image/installation method; the R6080 device page currently documents `nmrpflash` over a **direct Ethernet cable**.
4. Verify SHA-256 before use.
5. Export the router's current configuration and save it locally. Never commit that backup or router credentials.
6. Flash only after reading the full procedure, setting aside uninterrupted time, and having a tested recovery path.
7. Set a unique administrator password, then configure Wi-Fi and verify WAN, LAN, and client access.

## Important hardware limits

The OpenWrt device page describes the R6080 as a dual-band AC1000 router with 10/100 Ethernet and 8 MiB flash. Small flash/RAM capacity limits what packages and add-on services fit. Treat it as a basic router/access point; do not plan on heavyweight VPN, IDS, or large package sets without checking current device resources.

## Official sources

- [OpenWrt NETGEAR R6080 device page](https://openwrt.org/toh/netgear/r6080)
- [OpenWrt Firmware Selector](https://firmware-selector.openwrt.org/?id=netgear_r6080)
- [Official ramips/mt76x8 release directory](https://downloads.openwrt.org/releases/)
- [OpenWrt first installation guide](https://openwrt.org/docs/guide-quick-start/factory_installation)
- [OpenWrt sysupgrade guide](https://openwrt.org/docs/guide-user/installation/generic.sysupgrade)
- [OpenWrt configuration backup guide](https://openwrt.org/docs/guide-user/troubleshooting/backup_restore)
- [nmrpflash upstream project](https://github.com/jclehner/nmrpflash)

OpenWrt is free software under its component licenses. `nmrpflash` is GPL-3.0-or-later. This kit links to upstream sources and does not redistribute firmware or nmrpflash binaries.

