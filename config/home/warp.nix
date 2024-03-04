let unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in { environment.systemPackages = with pkgs; [ warp-terminal ]; }
