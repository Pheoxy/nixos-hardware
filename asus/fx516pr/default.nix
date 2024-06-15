{ lib, ... }:
{
  imports = [
    ../../common/cpu/intel
    ../../common/cpu/intel/tiger-lake
    ../../common/gpu/nvidia
    ../../common/gpu/nvidia/prime.nix
    ../../common/pc/laptop
    ../../common/pc/ssd
    ../battery.nix
  ];

  # Needed for asusd power profiles to work.
  services.power-profiles-daemon.enable = lib.mkDefault true;

  # Adds the missing asus functionality to Linux.
  # https://asus-linux.org/manual/asusctl-manual/
  services = {
    asusd = {
      enable = lib.mkDefault true;
      enableUserService = lib.mkDefault true;
    };
    supergfxd = {
      enable = lib.mkDefault true;
    };
  };

  hardware.nvidia = {
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    # Needed for suspend to work properly, otherwise the system will hang.
    powerManagement.enable = lib.mkDefault true;
  };
}
