# Status
Boots to UEFI Shell

SimpleFbDxe is broken due to weird mtk fb, while FrameBufferSerialLib works fine

UART works too, but for it, you must first disable FrameBufferSerialLib in MT6765Pkg.dsc

# Building
First, clone EDK2:
```
git clone https://github.com/tianocore/edk2 --recursive -b edk2-stable202302
git clone https://github.com/tianocore/edk2-platforms.git
```
First run `./firstrun.sh` <br>
Then, `./build.sh` <br>
This should make a boot-uefi.img to be flashed/booted via fastboot.

# Credits
[edk2-exynos7885](https://github.com/sonic011gamer/edk2-exynos7885/) - I based this port on this tree

## Experimental Samsung Galaxy A03s (SM-A037F) bring-up

An initial UART-first firmware profile is available on the `sm-a037f-uart-first`
branch. It adds `MT6765Pkg/Devices/sm-a037f.dsc` and can be built with:

```sh
bash ./build-a03s.sh
```

The build emits `workspace/UEFI-sm-a037f.bin`, a raw BootShim + padded UEFI
firmware payload. **It is not an Android boot image and must not be flashed or
passed to fastboot as-is.** The stock A03s DTB and boot-image packaging have not
yet been integrated or validated, so this script intentionally does not create
`boot-uefi.img`.

The profile uses the observed UART register base `0x11002000`, with a bounded
transmit wait, and disables the donor framebuffer/logo drivers because the
A03s framebuffer address is not yet established. UART output and pin routing
remain unverified. The current 3 GiB UEFI memory window is a conservative
bring-up setting, not a final map: the captured device tree reports 4 GiB DRAM,
but reserved-memory assignments still need to be parsed before claiming all
ranges are safe.

