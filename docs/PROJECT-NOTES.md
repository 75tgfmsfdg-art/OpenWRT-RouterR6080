# Project notes and verification limits

This kit captures the OpenWrt router work as a reusable public workflow. It includes model-specific R6080 procedures, cross-platform host instructions, safe firmware verification, routine upgrades, backup, and recovery references.

The source workspace contains a downloaded image whose filename identifies the NETGEAR R6080 target. That filename is not proof of the make/model currently connected to the network, proof of which firmware is installed, or proof that a particular hardware revision is compatible. Confirm the physical label and current OpenWrt device page every time before flashing.

Private Wi-Fi names, local IP addresses, Tailscale identifiers, credentials, router backups, paired device data, and household network diagnostics are deliberately excluded. Those values are site-specific and must be discovered and kept locally by each person following the guide.

## Local verification record

Checked 2026-11-24 from the connected LAN: the gateway's landing page redirects to LuCI, confirming that an OpenWrt management interface is reachable. Requests for the overview and login routes returned HTTP 403 without an authenticated session. No login was attempted and no router configuration was changed. The physical model/revision and currently installed OpenWrt release therefore remain unverified; confirm those in the router label and authenticated LuCI before using the R6080 flashing procedure.

A local file named `openwrt-25.12.2-ramips-mt76x8-netgear_r6080-squashfs-factory.img` was verified against the published OpenWrt 25.12.2 target directory SHA-256: `8b237aa9b033d2fbdbeb621fd2aeed931433624765e5688d9659b132942be783`. This confirms that file matches the published checksum for that image only. It does not confirm that the live router is an R6080, that the image is current, or that it is the correct image for the router's state. Do not use it for a new flash without rechecking current official guidance.

Firmware versions and instructions change. This documentation intentionally points to the official live Firmware Selector, release directory, and device page instead of freezing a firmware binary in the repository. Check these sources immediately before every installation or upgrade.

