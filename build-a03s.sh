#!/usr/bin/env bash
set -euo pipefail

# Builds the A03s-specific UEFI payload only. This deliberately does NOT emit
# boot-uefi.img: the repository's bundled DTB/initramfs belong to the donor
# device and are not valid substitutes for the SM-A037F live DTB.
. build_common.sh

CROSS_COMPILE="${CROSS_COMPILE:-aarch64-linux-gnu-}"
GCC5_AARCH64_PREFIX="${GCC5_AARCH64_PREFIX:-aarch64-linux-gnu-}"
JOBS="${JOBS:-$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 4)}"

CROSS_COMPILE="$CROSS_COMPILE" ./build_bootshim.sh
GCC5_AARCH64_PREFIX="$GCC5_AARCH64_PREFIX" build -j"$JOBS" -s -n 0 \
  -a AARCH64 -t GCC5 -p MT6765Pkg/Devices/sm-a037f.dsc \
  -D SM_A037F_UART_ONLY=TRUE

cat BootShim/BootShim.bin workspace/Build/MT6765Pkg/DEBUG_GCC5/FV/MT6765PKG_UEFI.fd \
  > workspace/UEFI-sm-a037f.bin

SIZE="$(wc -c < workspace/UEFI-sm-a037f.bin | tr -d ' ')"
if [ "$SIZE" -gt 2097152 ]; then
  echo "ERROR: BootShim + UEFI is $SIZE bytes; the current shim copies only 2 MiB." >&2
  rm -f workspace/UEFI-sm-a037f.bin
  exit 1
fi

# BootShim copies a fixed 2 MiB payload window, so pad the output explicitly.
truncate -s 2097152 workspace/UEFI-sm-a037f.bin
echo "Built workspace/UEFI-sm-a037f.bin (2 MiB raw payload; NOT an Android boot image)."
echo "No phone flashing or boot-image packaging was performed."
