{ pkgs, config, username, ... }:

let
  inherit (import ../../options.nix)
    browser wallpaperDir  flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    discord
    awscli2
    beekeeper-studio
    bruno
    qemu
    beeper
    brave
    ddev
    glow
    floorp
    gnome.gnome-boxes
    go
    gum
    jq
    kubectl
    kubectx
    libreoffice
    mkcert
    nodejs
    obsidian
    openrct2
    parsec-bin
    php
    php82Packages.composer
    prusa-slicer
    slack
    tailscale
    tailscale-systray
    thunderbird
    ungoogled-chromium
    vhs
    vscode
    watson
    yarn
    zoom-us
    libvirt
    swww
    grim
    slurp
    gnome.file-roller
    swaynotificationcenter
    rofi-wayland
    imv
    transmission-gtk
    mpv
    gimp
    obs-studio
    rustup
    audacity
    pavucontrol
    tree
    font-awesome
    spotify
    swayidle
    neovide
    element-desktop
    zellij
    swaylock
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir;
      inherit username; })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../scripts/screenshootin.nix { inherit pkgs; })
    (import ./../scripts/list-hypr-bindings.nix { inherit pkgs; })
    (import ./../scripts/watson-status.nix { inherit pkgs; })
  ];

  programs.gh.enable = true;
}
