#!/usr/bin/env sh
set -eu

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <firmware-file> <expected-64-character-sha256>" >&2
  exit 2
fi

file=$1
expected=$(printf '%s' "$2" | tr 'A-F' 'a-f')
case "$expected" in
  *[!0-9a-f]*|'') echo "Expected SHA-256 must be 64 hexadecimal characters." >&2; exit 2 ;;
esac
if [ "${#expected}" -ne 64 ]; then
  echo "Expected SHA-256 must be 64 hexadecimal characters." >&2
  exit 2
fi
if [ ! -f "$file" ]; then
  echo "File not found: $file" >&2
  exit 2
fi

if command -v sha256sum >/dev/null 2>&1; then
  actual=$(sha256sum "$file" | awk '{print tolower($1)}')
elif command -v shasum >/dev/null 2>&1; then
  actual=$(shasum -a 256 "$file" | awk '{print tolower($1)}')
else
  echo "Install a SHA-256 utility (sha256sum or shasum) and retry." >&2
  exit 2
fi
echo "File: $file"
echo "SHA-256: $actual"
if [ "$actual" != "$expected" ]; then
  echo "SHA-256 mismatch. Do not use this image." >&2
  exit 1
fi
echo "SHA-256 matches the supplied official value. This does not verify model selection."
