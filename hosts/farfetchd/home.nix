{
  pkgs,
  username,
  host,
  lib,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername gitEmail;
in
{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Import Program Configurations
  imports = [
    ../../config/emoji.nix
    ../../config/hyprland/default.nix
    ../../config/neovim.nix
    ../../config/rofi/rofi.nix
    ../../config/rofi/config-emoji.nix
    ../../config/rofi/config-long.nix
    ../../config/swaync.nix
    ../../config/waybar.nix
    ../../config/wlogout.nix
    ../../config/helix.nix
    ../../config/kitty.nix
    ../../config/zellij.nix
    # ../../config/pyprland.nix
  ];

  # Place Files Inside Home Directory
  # home.file."Pictures/Wallpapers" = {
  #   source = ../../config/wallpapers;
  #   recursive = true;
  # };
  home.file.".config/fastfetch" = {
    source = ../../config/fastfetch;
    recursive = true;
  };
  home.file.".config/wlogout/icons" = {
    source = ../../config/wlogout;
    recursive = true;
  };
  # home.file.".face.icon".source = ../../config/face.jpg;
  # home.file.".config/face.jpg".source = ../../config/face.jpg;
  # home.file.".config/swappy/config".text = ''
  #   [Default]
  #   save_dir=/home/${username}/Pictures/Screenshots
  #   save_filename_format=swappy-%Y%m%d-%H%M%S.png
  #   show_panel=false
  #   line_size=5
  #   text_size=20
  #   text_font=Ubuntu
  #   paint_mode=brush
  #   early_exit=true
  #   fill_shape=false
  # '';

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Styling Options
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    style.name = lib.mkForce "adwaita-dark";
    platformTheme.name = lib.mkForce "gtk3";
  };


  # Scripts
  home.packages = [
    (import ../../scripts/emopicker9000.nix { inherit pkgs; })
    (import ../../scripts/task-waybar.nix { inherit pkgs; })
    (import ../../scripts/squirtle.nix { inherit pkgs; })
    (import ../../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ../../scripts/wallsetter.nix {
      inherit pkgs;
      inherit username;
    })
    (import ../../scripts/web-search.nix { inherit pkgs; })
    (import ../../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ../../scripts/screenshootin.nix { inherit pkgs; })
    (import ../../scripts/watson-status.nix { inherit pkgs; })
    (import ../../scripts/list-hypr-bindings.nix {
      inherit pkgs;
      inherit host;
    })
  ];

  services = {
    flatpak = {
      enable = true;
      packages = [
        "com.jeffser.Alpaca"
      ];
    };
  };

  programs = {
    gh.enable = true;
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        starship init fish | source
      '';
      shellAliases = {
        sv = "sudo nvim";
        fr = "nh os switch --hostname ${host} /home/${username}/Code/fabeanos";
        fu = "nh os switch --hostname ${host} --update /home/${username}/Code/fabeanos";
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        v = "nvim";
        ls = "eza --icons";
        ll = "eza -lh --icons --grid --group-directories-first";
        la = "eza -lah --icons --grid --group-directories-first";
        ggpull = "git pull origin $(git branch --show-current)";
        ggpush = "git push origin $(git branch --show-current)";
        gs = "git status";
        lando = "node /home/josh/Code/lando-cli/bin/lando";
        ytviewer = "/home/josh/Code/ytviewer/ytviewer";
        cat = "bat";
        mobile-display = "hyprctl keyword monitor 'DP-4, highres, 2257, 1' && hyprctl keyword monitor 'eDP-1, highres, 0x0, 1'";
        mobile-display-alt = "hyprctl keyword monitor 'DP-2, highres, 2257, 1' && hyprctl keyword monitor 'eDP-1, highres, 0x0, 1'";
        docked-display = "hyprctl keyword monitor 'DP-4, highres, 0x0, 1' && hyprctl keyword monitor 'DP-2, highres, 0x1441, 1' && hyprctl keyword monitor 'eDP-1, highres,3441x1441,1'";
        laptop-display-off = "hyprctl keyword monitor 'eDP-1, disable'";
        laptop-display-on = "hyprctl keyword monitor 'eDP-1, highres,3441x1441,1'";
      };
    };
    bash = {
      enable = true;
      enableCompletion = true;
      profileExtra = ''
        #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        #  exec Hyprland
        #fi
      '';
      initExtra = ''
        fastfetch
        if [ -f $HOME/.bashrc-personal ]; then
          source $HOME/.bashrc-personal
        fi
      '';
      shellAliases = {
        sv = "sudo nvim";
        fr = "nh os switch --hostname ${host} /home/${username}/Code/fabeanos";
        fu = "nh os switch --hostname ${host} --update /home/${username}/Code/fabeanos";
        zu = "sh <(curl -L https://gitlab.com/Zaney/zaneyos/-/raw/main/install-zaneyos.sh)";
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        v = "nvim";
        ls = "eza --icons";
        ll = "eza -lh --icons --grid --group-directories-first";
        la = "eza -lah --icons --grid --group-directories-first";
        ggpull = "git pull origin $(git branch --show-current)";
        ggpush = "git push origin $(git branch --show-current)";
        gs = "git status";
        ".." = "cd ..";
      };
    };
    home-manager.enable = true;
    # hyprlock = {
    #   enable = true;
    #   settings = {
    #     general = {
    #       disable_loading_bar = true;
    #       grace = 0;
    #       hide_cursor = true;
    #       no_fade_in = false;
    #       no_unlock_animation = false;
    #       ignore_empty_input = false;
    #     };
    #     background = lib.mkForce [
    #       {
    #         blur_passes = 3;
    #         blur_size = 8;
    #         path = "/home/josh/Pictures/Wallpapers/sunrise.jpg";
    #       }
    #     ];
    #     image = lib.mkForce [
    #       {
    #         path = "/home/${username}/.config/face.jpg";
    #         size = 150;
    #         border_size = 4;
    #         border_color = "rgb(0C96F9)";
    #         rounding = -1; # Negative means circle
    #         position = "0, 200";
    #         halign = "center";
    #         valign = "center";
    #       }
    #     ];
    #     input-field = lib.mkForce [
    #       {
    #         size = "200, 50";
    #         position = "0, -80";
    #         monitor = "";
    #         dots_center = true;
    #         fade_on_empty = false;
    #         font_color = "rgb(CFE6F4)";
    #         inner_color = "rgb(657DC2)";
    #         outer_color = "rgb(0D0E15)";
    #         outline_thickness = 5;
    #         placeholder_text = "Password...";
    #         shadow_passes = 2;
    #         check_color = "rgb(0C96F9)";
    #         fail_color = "rgb(FF0000)";
    #         capslock_color = "rgb(F9A80C)";
    #         password_input = true;
    #         swap_input_on_fail = true;
    #       }
    #     ];
    #   };
    # };
  };
}
