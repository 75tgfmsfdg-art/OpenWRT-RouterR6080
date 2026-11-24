# Project notes and verification limits

This kit captures the OpenWrt router work as a reusable public workflow. It includes model-specific R6080 procedures, cross-platform host instructions, safe firmware verification, routine upgrades, backup, and recovery references.

The source workspace contains a downloaded image whose filename identifies the NETGEAR R6080 target. That filename is not proof of the make/model currently connected to the network, proof of which firmware is installed, or proof that a particular hardware revision is compatible. Confirm the physical label and current OpenWrt device page every time before flashing.

Private Wi-Fi names, local IP addresses, Tailscale identifiers, credentials, router backups, paired device data, and household network diagnostics are deliberately excluded. Those values are site-specific and must be discovered and kept locally by each person following the guide.

Firmware versions and instructions change. This documentation intentionally points to the official live Firmware Selector, release directory, and device page instead of freezing a firmware binary in the repository. Check these sources immediately before every installation or upgrade.

