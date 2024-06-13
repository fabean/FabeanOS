{ inputs, config, pkgs,
  username, hostname, ... }:

let
  inherit (import ./options.nix)
    theLocale theTimezone gitUsername
    theShell wallpaperDir
    theLCVariables theKBDLayout flakeDir
    theme;
in {
  imports =
    [
      ./hardware.nix
      ./config/system
    ];

  # Enable networking
  networking.hostName = "${hostname}"; # Define your hostname
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "${theTimezone}";

  # Select internationalisation properties
  i18n.defaultLocale = "${theLocale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${theLCVariables}";
    LC_IDENTIFICATION = "${theLCVariables}";
    LC_MEASUREMENT = "${theLCVariables}";
    LC_MONETARY = "${theLCVariables}";
    LC_NAME = "${theLCVariables}";
    LC_NUMERIC = "${theLCVariables}";
    LC_PAPER = "${theLCVariables}";
    LC_TELEPHONE = "${theLCVariables}";
    LC_TIME = "${theLCVariables}";
  };

  console.keyMap = "${theKBDLayout}";

  # Define a user account.
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      hashedPassword = "$6$hZHT24npNcOznyp1$xpUfwBcO1YPH9wi6uSy/TS/PrNIiSJrDEMm6fhJYdTOC/b6JmC.PSnlYtLQ2KFb6txMPRijtVmfK5YswA9.rG/";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "disk"
        "power"
        "video"
        "docker"
        "dialout"
        ];
      shell = pkgs.${theShell};
      ignoreShellProgramCheck = true;
      packages = with pkgs; [];
    };
  };

  environment.variables = {
    FLAKE = "${flakeDir}";
    POLKIT_BIN = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  virtualisation.docker.enable = true;
  ## 9003 - xdebug
  ## 8384, 22000 Syncthing
  networking.firewall.allowedTCPPorts = [ 8384 22000 9003 5432 ];
  ## Syncthing
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  environment.etc.hosts.mode = "0644";


  system.stateVersion = "24.05";
}
