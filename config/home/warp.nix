{ pkgs, config, ... }:

let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in
{

  # Warp Terminal
  home.packages = with pkgs; [
    # other packages...
    warp-terminal
  ];
}