#!/bin/bash
set -e
CROSS_COMPILE="${CROSS_COMPILE:-aarch64-linux-gnu-}"
make -C BootShim CROSS_COMPILE="$CROSS_COMPILE" UEFI_BASE=0x50000000 UEFI_SIZE=0x00200000
rm -f BootShim/BootShim.elf
