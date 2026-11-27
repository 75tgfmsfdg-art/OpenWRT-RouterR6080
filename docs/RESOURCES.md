# Verified OpenWrt repositories and resources

This page records relevant upstream code repositories and binary package sources for the NETGEAR R6080 (`ramips/mt76x8`). These are references for research, building, and release verification. **They have not been added as extra feeds to the live router.**

## Primary upstream source repositories

- [OpenWrt source tree](https://git.openwrt.org/openwrt/openwrt.git) — base system, kernel integration, image definitions, and target support. For this device, use the `openwrt-25.12` release branch when researching the 25.12 series; do not build production firmware from `master`/`main` or a daily snapshot.
- [LuCI source tree](https://git.openwrt.org/project/luci.git) — LuCI web interface code. The router uses LuCI, so this is relevant to its management interface and package updates.
- [OpenWrt packages feed](https://git.openwrt.org/feed/packages.git) — community-maintained package build definitions. The repository documents that it is layered on an OpenWrt buildroot; it is primarily a build/source reference, not a reason to change package sources on a running router.
- [OpenWrt routing feed](https://git.openwrt.org/feed/routing.git) — community routing package build definitions. Use only if the project later needs to research or build a specific routing package; do not install the whole feed on the R6080.
- [OpenWrt source repository index](https://git.openwrt.org/) — official index of OpenWrt project source repositories and feeds.

## Release-matched firmware and binary packages

- [OpenWrt 25.12.6 R6080 target directory](https://downloads.openwrt.org/releases/25.12.6/targets/ramips/mt76x8/) — exact R6080 factory, initramfs, and sysupgrade images with published SHA-256 values.
- [OpenWrt 25.12.6 ramips/mt76x8 base package index](https://downloads.openwrt.org/releases/25.12.6/targets/ramips/mt76x8/packages/) — target-specific packages, including kernel-coupled components.
- [Official OpenWrt Attended Sysupgrade server](https://sysupgrade.openwrt.org/) — builds custom, device-specific sysupgrade images with selected packages preinstalled. A successful build is only an image artifact; it does not install the image on the router.
- [Attended Sysupgrade source repository](https://github.com/openwrt/asu) — official ASU server source and its client/build workflow.
- [OpenWrt downloads release index](https://downloads.openwrt.org/releases/) — confirms the currently published stable release and its official feeds.
- [OpenWrt 25.12.6 announcement](https://lists.openwrt.org/pipermail/openwrt-announce/2026-October/000090.html) — release changes and security notes.

## Package-source rules for this router

1. Prefer the feeds already generated for the installed OpenWrt release and target. For 25.12, package sources must match the `openwrt-25.12` release and the device's architecture/target (`ramips/mt76x8`).
2. Do not add arbitrary GitHub/APK repositories to `/etc/apk/repositories`. A package from another release, target, or kernel build can fail to install or destabilize the router.
3. Do not mass-upgrade individual packages across firmware revisions. Use a coherent supported sysupgrade or attended-sysupgrade image, after making and verifying a fresh configuration backup and checking free overlay space.
4. The R6080 has 8 MiB of flash and no USB host port. Keep the live router lean; investigate the installed package list and `/overlay` usage before removing anything. Preserve LuCI, WireGuard, DNS, firewall, and the Fire Stick WAN-bypass policy unless a verified dependency review proves a component is unused.
5. Do not commit firmware binaries, router backups, credentials, private keys, or machine-specific exports to this repository. Follow [Privacy and safe sharing](PRIVACY.md).

## Verification status

As of 2026-11-26, the official stable series is OpenWrt 25.12.6. The R6080 `squashfs-sysupgrade.bin` was downloaded to the local ignored `private/firmware/` directory and matched the SHA-256 published in the official 25.12.6 target index. It has **not** been flashed. The live router's installed packages and overlay usage were reviewed on 2026-11-26; recheck them immediately before any cleanup or upgrade because the device state can change.
