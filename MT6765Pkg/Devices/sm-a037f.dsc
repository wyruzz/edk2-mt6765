[Defines]
  PLATFORM_NAME                  = SM-A037F
  PLATFORM_GUID                  = 28f1a3bf-193a-47e3-a7b9-5a435eaab2ee
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010019
  OUTPUT_DIRECTORY               = Build/SM-A037F
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = MT6765Pkg/MT6765Pkg.fdf

!include MT6765Pkg/MT6765Pkg.dsc

[PcdsFixedAtBuild.common]
  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x40000000
  # Temporary conservative window for UEFI-shell bring-up only.
  # The DT reports 4 GiB DRAM, but reserved-memory assignments are not mapped yet.
  # Do not treat this as the final XNU/UEFI memory map.
  gArmTokenSpaceGuid.PcdSystemMemorySize|0xc0000000
  # Keep the entry stack aligned with PrePi.c: pool end minus stack size.
  gEmbeddedTokenSpaceGuid.PcdPrePiStackBase|0x43FC0000
  gEmbeddedTokenSpaceGuid.PcdPrePiStackSize|0x00040000
  gMT6765PkgTokenSpaceGuid.PcdUefiMemPoolBase|0x40D00000
  gMT6765PkgTokenSpaceGuid.PcdUefiMemPoolSize|0x03300000
  gArmTokenSpaceGuid.PcdCpuVectorBaseAddress|0x40C40000
