# Windows, macOS, and Linux host instructions

The router procedure is the same on all three systems. Differences are limited to installing `nmrpflash`, identifying the wired interface, and calculating a checksum. Run these steps on the computer physically connected to the router by Ethernet.

## Windows

1. Download the Windows `nmrpflash` release from the [upstream releases page](https://github.com/jclehner/nmrpflash/releases).
2. Install Npcap from its official site and select **WinPcap API-compatible Mode** during setup. Use the upstream nmrpflash instructions for prerequisites.
3. Open PowerShell in the folder containing the tool. List interfaces with `./nmrpflash.exe -L` and identify the wired adapter. Do not guess the interface name.
4. Verify the firmware file:

```powershell
Get-FileHash .\firmware.img -Algorithm SHA256
```

Or use the included script:

```powershell
.\scripts\verify-firmware.ps1 -File .\firmware.img -ExpectedSha256 PASTE_OFFICIAL_SHA256
```

5. Follow the model-specific [R6080 installation workflow](INSTALL-R6080.md). Start PowerShell with the permissions required by Npcap/nmrpflash; do not disable Windows Firewall globally.

## macOS

1. Install Homebrew from its [official instructions](https://brew.sh/) if it is not already installed.
2. Install the upstream utility: `brew install nmrpflash`.
3. List network interfaces: `nmrpflash -L`. Use the wired adapter directly connected to the router.
4. Verify the image using `shasum -a 256 firmware.img` or `./scripts/verify-firmware.sh firmware.img PASTE_OFFICIAL_SHA256`.
5. Follow the model-specific [R6080 installation workflow](INSTALL-R6080.md). macOS may request permission for the tool to access the network; approve only the expected nmrpflash application.

## Linux

1. Prefer a package from a trusted distribution repository when available. Otherwise use the signed/reviewed upstream source or release from [jclehner/nmrpflash](https://github.com/jclehner/nmrpflash). Building from source may require the distribution's libpcap and libnl development packages.
2. List interfaces using `sudo nmrpflash -L`, then identify the wired interface by plugging/unplugging or comparing MAC addresses.
3. Verify the image with `sha256sum firmware.img` or `./scripts/verify-firmware.sh firmware.img PASTE_OFFICIAL_SHA256`.
4. Follow the model-specific [R6080 installation workflow](INSTALL-R6080.md). Use only the privileges needed by the network capture/packet utility; do not disable the host firewall wholesale.

## Shared rules

- `nmrpflash -L` is an interface inventory command; it does not flash the router.
- Firmware SHA-256 must match the value published by OpenWrt for the **same exact image**. A checksum proves file integrity against that published value; it does not prove the chosen model/image is correct.
- The included scripts only hash a local file and compare it with a caller-provided expected hash. They do not download, install, or flash anything.
- Disconnect the host from other networks if needed to prevent the host's routing from interfering; reconnect after router validation.

