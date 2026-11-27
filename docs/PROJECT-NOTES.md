# Project notes and verification limits

This kit captures the OpenWrt router work as a reusable public workflow. It includes model-specific R6080 procedures, cross-platform host instructions, safe firmware verification, routine upgrades, backup, and recovery references.

The owner-provided LuCI Overview confirms the router model and target for this project. A downloaded image filename alone does not identify a connected router or prove its installed version. The Overview did not show the hardware revision; confirm the label and current OpenWrt device page before flashing any different router or revision.

Private Wi-Fi names, local IP addresses, Tailscale identifiers, credentials, router backups, paired device data, and household network diagnostics are deliberately excluded. Those values are site-specific and must be discovered and kept locally by each person following the guide.

## Local verification record

Checked 2026-11-24 from the connected LAN: the gateway's landing page redirects to LuCI, confirming that an OpenWrt management interface is reachable. Requests for the overview and login routes returned HTTP 403 without an authenticated session. No login was attempted and no router configuration was changed. The owner then supplied the LuCI Overview values: NETGEAR R6080, MediaTek MT7628AN v1 eco2, `ramips/mt76x8`, OpenWrt 25.12.2 `r32802-f505120278`, kernel 6.12.74. Hardware revision was not included in that Overview snapshot.

A local file named `openwrt-25.12.2-ramips-mt76x8-netgear_r6080-squashfs-factory.img` was verified against the published OpenWrt 25.12.2 target directory SHA-256: `8b237aa9b033d2fbdbeb621fd2aeed931433624765e5688d9659b132942be783`. This confirms that file matches the published checksum for that image only. It does not confirm that the live router is an R6080, that the image is current, or that it is the correct image for the router's state. Do not use it for a new flash without rechecking current official guidance.

## Prepared security update

OpenWrt 25.12.6 is the current stable release. Its announcement recommends updating because it fixes multiple remotely reachable vulnerabilities in services enabled by default, including LuCI's web server. The official release directory provides the R6080 `squashfs-sysupgrade.bin` with SHA-256 `20586d130edb7659757484aca334dfca6c89d4d954770de9f1c209d7798a17d4`. That image was downloaded and both checksum helper scripts verified it; it was later moved into the owner's local OpenWrt desktop folder. It is not stored in this public repository and has not been flashed.

**Owner decision (2026-11-24): defer the upgrade.** Keep the router on OpenWrt 25.12.2 for now. The verified 25.12.6 image is retained locally for later review; no firmware has been flashed. A local backup archive dated 2026-11-22 was found; its file list includes `etc/config/network`, `etc/config/firewall`, and `etc/config/wireless`, but its contents have not been inspected and its date predates the recent WireGuard work. Do not treat it as a current pre-upgrade backup. Generate a fresh backup immediately before any future upgrade and verify its file list.

## WireGuard and settings preservation

The 25.12.6 sysupgrade image does not itself contain this router's configuration or WireGuard keys. When the supported sysupgrade path is used with **Keep settings**, OpenWrt normally restores saved configuration files from locations including `/etc/config`; standard WireGuard interface and peer settings are generally part of `/etc/config/network`. This is not a guarantee for custom scripts, files outside the preserved set, or a clean flash with settings disabled. Manually installed packages are not retained and may need reinstalling after upgrade. The repository's [R6080/WireGuard loss-prevention checklist](OPERATIONS-RECOVERY.md) lists the backup and validation items required before revisiting the update. Treat any backup or exported WireGuard configuration as secret because it can contain private keys.

Firmware versions and instructions change. This documentation intentionally points to the official live Firmware Selector, release directory, and device page instead of freezing a firmware binary in the repository. Check these sources immediately before every installation or upgrade.

## Package feed and inventory snapshot (owner-supplied, 2026-11-26)

The router's `apk update` output showed the standard OpenWrt 25.12.2 feeds for the `ramips/mt76x8` target and `mipsel_24kc` architecture: target packages, kernel modules matching kernel `6.12.74-1`, base, LuCI, packages, routing, telephony, and video. The fetch completed successfully with 11,014 package records. No third-party repository was present in this output. These are already the standard official feeds; adding unrelated feeds is not needed.

The supplied `apk list --upgradable` output showed 16 updates: 14 LuCI components and `ppp` plus `ppp-mod-pppoe`. The installed list includes LuCI, WireGuard and its LuCI protocol page, PPPoE, firewall, Wi-Fi, and core networking packages. Preserve these functions during any cleanup. The earlier `apk list upgradable` line without `--` returned no output; the later `apk list --upgradable` command is the meaningful result.

The owner supplied `df -h /overlay`: `/dev/mtdblock6`, size 1.4 MiB, 988 KiB used, 420 KiB available (70%), mounted at `/overlay`. The later `du -ak /overlay/upper` listing totals 1,704 KiB by file/path accounting; the largest subtree is `/overlay/upper/www/luci-static/resources` at 1,295 KiB, including network/status views and icons. This looks like installed LuCI web-interface content, not an orphaned cache or log directory. `du`'s total exceeds the `df` used space; this may reflect compression or accounting differences, so do not treat the `du` values as reclaimable physical space. The installed package list is primarily the base system and LuCI plus Wi-Fi, firewall, PPPoE, and WireGuard components; it shows no obvious standalone application to remove. Removing LuCI would sacrifice the management interface and is not recommended for this setup. No package update, feed change, or removal is recorded from this snapshot. The owner had previously chosen to defer the 25.12.6 firmware upgrade; keep that decision in effect unless changed explicitly.

## Device-specific WAN bypass verification

The owner added a second Fire Stick's IPv4 WAN-bypass policy using a persistent DHCP reservation, a source policy rule to lookup table 100, and a matching IPv4 LAN-to-WAN firewall rule. The supplied live checks show the new rule active at priority 10001 and its route lookup using the WAN gateway/table 100. A comparison client remains routed through `WireguardVPN`. The owner then confirmed streaming apps work on the second Fire Stick, completing the end-to-end check. Device labels and home-network IP/MAC details are intentionally omitted from this project record.

