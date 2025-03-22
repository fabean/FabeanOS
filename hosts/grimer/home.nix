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
  home.stateVersion = "24.11";

  # Import Program Configurations
  imports = [
    ../../config/helix.nix
  ];

  # Place Files Inside Home Directory
  home.file.".config/fastfetch" = {
    source = ../../config/fastfetch;
    recursive = true;
  };

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
        fastfetch
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
        cat = "bat";
      };
    };
    bash = {
      enable = true;
      enableCompletion = true;
      profileExtra = '''';
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
  };
}
