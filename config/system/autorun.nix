{ pkgs, config, username, ... }:

let inherit (import ../../options.nix) wallpaperDir; in
{
  # system.userActivationScripts = {
  #   gitwallpapers.text = ''
  #   '';
  # };
}
