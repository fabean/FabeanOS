# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "amdgpu.sg_display=0" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/009a90e6-d690-4dc1-8369-c1c146642766";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-fb832238-d182-4333-894a-521aa8779928".device = "/dev/disk/by-uuid/fb832238-d182-4333-894a-521aa8779928";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0A2B-5BB2";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/22c7c189-ba8a-4330-b798-613d760ada8f"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-06b01a2ff1d0.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-107bebe3df74.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-440ccbda9619.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-50cf616773d2.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-791f8849f478.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-ae8fb1adb14d.useDHCP = lib.mkDefault true;
  # networking.interfaces.br-b30a36c1260d.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth1d36b22.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
