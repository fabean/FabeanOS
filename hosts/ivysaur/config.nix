{
  config,
  pkgs,
  host,
  username,
  options,
  inputs,
  ...
}:

{
  imports = [
    ./hardware.nix
    ./users.nix
  ];

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_zen;
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };

    # Remove Plymouth (graphical boot splash)
    # plymouth.enable = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = host;
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  programs = {
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        buf = {
          symbol = " ";
        };
        c = {
          symbol = " ";
        };
        directory = {
          read_only = " 󰌾";
        };
        docker_context = {
          symbol = " ";
        };
        fossil_branch = {
          symbol = " ";
        };
        git_branch = {
          symbol = " ";
        };
        golang = {
          symbol = " ";
        };
        hg_branch = {
          symbol = " ";
        };
        hostname = {
          ssh_symbol = " ";
        };
        lua = {
          symbol = " ";
        };
        memory_usage = {
          symbol = "󰍛 ";
        };
        meson = {
          symbol = "󰔷 ";
        };
        nim = {
          symbol = "󰆥 ";
        };
        nix_shell = {
          symbol = " ";
        };
        nodejs = {
          symbol = " ";
        };
        ocaml = {
          symbol = " ";
        };
        package = {
          symbol = "󰏗 ";
        };
        python = {
          symbol = " ";
        };
        rust = {
          symbol = " ";
        };
        swift = {
          symbol = " ";
        };
        zig = {
          symbol = " ";
        };
      };
    };
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  users = {
    mutableUsers = true;
  };

  environment.systemPackages = with pkgs; [
    bat
    starship
    libva-utils
    btop
    ctop
    eza
    fastfetch
    fishPlugins.bass
    ffmpeg
    gdu
    git
    htop
    superfile
    lm_sensors
    mkcert
    nh    
    pciutils
    pkg-config
    tailscale
    unrar
    unzip
    vim
    wget
    zellij
  ];


  environment.variables = {
    ZANEYOS_VERSION = "2.2";
    ZANEYOS = "true";
    TERM = "xterm-256color";
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  # Services to start
  services = {
    
    # Replace greetd with autologin for server
    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          user = username;
          # Auto-login to console
          command = "${pkgs.bash}/bin/bash --login";
        };
      };
    };
    
    smartd = {
      enable = true;
      autodetect = true;
    };
    fstrim.enable = true;
    openssh.enable = true;
    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };

    rpcbind.enable = true;
    nfs.server.enable = true;
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
    fwupd.enable = true;
  };

   # NFS mounts
  fileSystems."/mnt/exeggcute" = {
    device = "192.168.86.18:/srv/nfs/storage";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };


  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';


  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Virtualization / Containers
  virtualisation.libvirtd = {
    enable = true;
  };
  virtualisation.docker.enable = true;

  # OpenGL - can be simplified for server
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # No need for 32-bit support on server
    extraPackages = with pkgs; [
      intel-ocl # Generic OpenCL support

      # For Broadwell and newer (ca. 2014+), use with LIBVA_DRIVER_NAME=iHD:
      intel-media-driver

      # For older processors, use with LIBVA_DRIVER_NAME=i965:
      intel-vaapi-driver
      libva-vdpau-driver

      # For older processors:
      intel-compute-runtime-legacy1

      # For 11th gen and newer:
      vpl-gpu-rt
      libvdpau-va-gl
      vaapiIntel          # Optional fallback for i965
    ];
  };

  # Open ports in the firewall.
  networking = {
    firewall = {
      allowedTCPPorts = [ 8384 22000 9003 5432 8096 ];
      allowedUDPPorts = [ 22000 21027 7359 ];
    };
    extraHosts = ''

      '';
  };
  environment.etc.hosts.mode = "0644";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
