#!/usr/bin/env bash
set -euo pipefail
echo "ERROR: build.sh will not package an SM-A037F image yet." >&2
echo "The old roo target uses donor-device DTB/initramfs and is not valid for Samsung Galaxy A03s." >&2
echo "Use 'bash ./build-a03s.sh' to build the raw UEFI payload only; it is NOT a boot image." >&2
echo "A03s boot-image packaging remains blocked until the live A03s DTB and boot-chain framing are integrated." >&2
exit 2
