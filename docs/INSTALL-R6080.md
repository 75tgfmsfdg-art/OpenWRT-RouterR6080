# NETGEAR R6080: installation workflow

This is a careful runbook. Router flashing is a high-impact operation and is not automatic: it interrupts internet service, can erase settings, and can make a device unusable if the image or model is wrong.

## Before starting

- Read the physical label. It must say **NETGEAR R6080**. Record the hardware revision and regional variant privately.
- Compare the exact model against the [OpenWrt R6080 device page](https://openwrt.org/toh/netgear/r6080). Stop if model/revision is not an exact match or if the page no longer lists it as supported.
- Download the appropriate image using the OpenWrt [Firmware Selector](https://firmware-selector.openwrt.org/?id=netgear_r6080). Use the image type explicitly specified by the current R6080 installation instructions. Do not substitute an image for the similar R6020 or R6120.
- Read the release notes and calculate/compare the published SHA-256 using [the cross-platform instructions](CROSS-PLATFORM.md).
- Save an export of the existing router configuration and ISP settings offline. It may contain passwords, Wi-Fi keys, and network details; never upload it to a public repository.
- Have a computer with a wired Ethernet port or a compatible USB Ethernet adapter, a known-good cable, stable power, and a second way to access the Internet.
- Close other applications that may reconfigure network adapters. Identify the wired interface by its name/MAC address before beginning.
- Download the upstream `nmrpflash` release for the host OS. Windows requires Npcap with WinPcap compatibility enabled, as described upstream.

## First-time install on R6080

The R6080 device page documents NMRP recovery flashing with `nmrpflash`; it specifically requires a **direct Ethernet connection** between the host computer and router. It notes that port **1** may work when the blue WAN port does not. The exact image selection and sequence can change between OpenWrt releases, so follow the current device page rather than guessing from a generic guide.

1. Disconnect the router from the production network. Connect the host directly to the router using Ethernet. Do not use Wi-Fi for the NMRP transfer.
2. List `nmrpflash` interfaces (`nmrpflash -L`) and select the wired adapter connected to the router.
3. Follow the current R6080 device page's exact image and command options. In the documented NMRP flow, start the utility while the router is powered off; when it reports that it is waiting for an Ethernet connection, power on the router (and hold reset only if the current device instructions require it).
4. Do not remove power or cable while the transfer/flash is running. Wait for the utility's explicit success/completion message and the device page's stated reboot step.
5. The R6080 page notes that the first boot may offer SSH on the LAN without LuCI. Connect only from the directly attached LAN host, using the address documented on the current device page. Follow the current page to initialize writable overlay, reboot, and install LuCI if required. Do not expose SSH on the WAN.
6. Set an administrator password immediately. Confirm the exact OpenWrt model/version, LAN address, wired access, and recovery path before connecting the WAN.
7. Configure WAN and wireless securely; the R6080 device page indicates its 2.4 GHz and 5 GHz radios may initially be disabled. Use country-appropriate regulatory settings and WPA2/WPA3 options supported by the installed build.
8. Test one wired client, both wireless bands as applicable, DNS, WAN connectivity, and router restart. Keep the original configuration export and firmware version details offline.

## If the NMRP tool cannot find the router

- Confirm the wired interface is enabled and selected; Wi-Fi can make the wrong adapter easy to select.
- Try the router's LAN port labeled **1**, as the R6080 device page notes, instead of the WAN port.
- Confirm the downloaded file is the correct R6080 image and that the transfer tool is current.
- On Windows, confirm Npcap is installed with WinPcap compatibility. Restarting the Npcap service may help if the adapter is missing.
- Stop if model, image, adapter, or device state is uncertain. Do not try random images, MAC addresses, blind mode, or repeated power cycles.

## Reverting to vendor firmware

Use only a NETGEAR firmware file for the exact R6080 hardware revision and follow the R6080 recovery instructions. The OpenWrt device page and nmrpflash documentation are the primary references. Do not assume that a normal OpenWrt sysupgrade file can restore the vendor firmware.

