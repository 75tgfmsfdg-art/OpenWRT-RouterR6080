# Privacy and safe sharing

This folder is prepared for public download. It intentionally contains general procedures and official public links only.

Never add these items to GitHub:

- Router configuration exports, private keys, certificates with private keys, or password files.
- Wi-Fi passwords, administrator credentials, API keys, pairing tokens, or `.env` files.
- Private WAN/public IP addresses, home SSIDs, client MAC addresses/names, or unredacted network scans and logs.
- Account information, QR pairing images, or screenshots showing router credentials or public addresses.

Before sharing a diagnostic report, make a redacted copy and search it for secrets, addresses, SSIDs, MAC addresses, serial numbers, and device names. Keep the original local. Remove sensitive files from Git history too; deleting a file in a later commit does not remove it from earlier public commits.

