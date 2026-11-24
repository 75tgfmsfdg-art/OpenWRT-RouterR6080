# Project notes and verification limits

This kit captures the OpenWrt router work as a reusable public workflow. It includes model-specific R6080 procedures, cross-platform host instructions, safe firmware verification, routine upgrades, backup, and recovery references.

The owner-provided LuCI Overview confirms the router model and target for this project. A downloaded image filename alone does not identify a connected router or prove its installed version. The Overview did not show the hardware revision; confirm the label and current OpenWrt device page before flashing any different router or revision.

Private Wi-Fi names, local IP addresses, Tailscale identifiers, credentials, router backups, paired device data, and household network diagnostics are deliberately excluded. Those values are site-specific and must be discovered and kept locally by each person following the guide.

## Local verification record

Checked 2026-11-24 from the connected LAN: the gateway's landing page redirects to LuCI, confirming that an OpenWrt management interface is reachable. Requests for the overview and login routes returned HTTP 403 without an authenticated session. No login was attempted and no router configuration was changed. The owner then supplied the LuCI Overview values: NETGEAR R6080, MediaTek MT7628AN v1 eco2, `ramips/mt76x8`, OpenWrt 25.12.2 `r32802-f505120278`, kernel 6.12.74. Hardware revision was not included in that Overview snapshot.

A local file named `openwrt-25.12.2-ramips-mt76x8-netgear_r6080-squashfs-factory.img` was verified against the published OpenWrt 25.12.2 target directory SHA-256: `8b237aa9b033d2fbdbeb621fd2aeed931433624765e5688d9659b132942be783`. This confirms that file matches the published checksum for that image only. It does not confirm that the live router is an R6080, that the image is current, or that it is the correct image for the router's state. Do not use it for a new flash without rechecking current official guidance.

## Prepared security update

OpenWrt 25.12.6 is the current stable release. Its announcement recommends updating because it fixes multiple remotely reachable vulnerabilities in services enabled by default, including LuCI's web server. The official release directory provides the R6080 `squashfs-sysupgrade.bin` with SHA-256 `20586d130edb7659757484aca334dfca6c89d4d954770de9f1c209d7798a17d4`. That image was downloaded to the local Downloads folder and both checksum helper scripts verified it. It is not stored in this public repository and has not been flashed.

Before applying the update, export a fresh LuCI configuration backup and keep it offline. In LuCI use System → Backup / Flash Firmware, select the R6080 sysupgrade image, follow the upgrade guidance for preserving settings, and allow the router to finish and reboot without interrupting power. Then verify access, WAN, LAN, both Wi-Fi bands, and firmware version. Do not proceed if the model/target shown on the router differs from the supplied Overview or if the backup is unavailable.

## WireGuard and settings preservation

The 25.12.6 sysupgrade image does not itself contain this router's configuration or WireGuard keys. When the supported sysupgrade path is used with **Keep settings**, OpenWrt normally restores saved configuration files from locations including `/etc/config`; standard WireGuard interface and peer settings are generally part of `/etc/config/network`. This is not a guarantee for custom scripts, files outside the preserved set, or a clean flash with settings disabled. Manually installed packages are not retained and may need reinstalling after upgrade. Keep an offline LuCI backup, save an installed-package manifest, and treat any backup or exported WireGuard configuration as secret because it can contain private keys. Verify the WireGuard interface, peer handshakes, routes, firewall rules, and clients after the upgrade.

Firmware versions and instructions change. This documentation intentionally points to the official live Firmware Selector, release directory, and device page instead of freezing a firmware binary in the repository. Check these sources immediately before every installation or upgrade.

