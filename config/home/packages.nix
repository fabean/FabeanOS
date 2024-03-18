{ pkgs, config, username, ... }:

let inherit (import ../../options.nix) browser wallpaperDir flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    audacity
    awscli2
    beekeeper-studio
    beeper
    brave
    bruno
    calc
    ddev
    discord
    element-desktop
    firefox
    floorp
    font-awesome
    gimp
    glow
    gnome.file-roller
    gnome.gnome-boxes
    go
    grim
    gum
    imv
    jq
    krita
    kubectl
    kubectx
    libreoffice
    libvirt
    mkcert
    mpv
    neovide
    nixfmt
    nodejs
    obs-studio
    obsidian
    openrct2
    parsec-bin
    pavucontrol
    php
    php82Packages.composer
    prusa-slicer
    qemu
    rofi-wayland
    rustup
    slack
    slurp
    spotify
    swayidle
    swaylock
    swaynotificationcenter
    swww
    tailscale
    tailscale-systray
    teams-for-linux
    thunderbird
    transmission-gtk
    tree
    ungoogled-chromium
    vhs
    vscode
    watson
    yarn
    youtube-tui
    zellij
    zoom-us
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix {
      inherit pkgs;
      inherit wallpaperDir;
      inherit username;
    })
    (import ./../scripts/themechange.nix {
      inherit pkgs;
      inherit flakeDir;
    })
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
